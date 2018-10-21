//
//  JMSearchPropertiesViewController.m
//  JazzMobile
//
//  Created by Ferat Capar on 25.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMSearchPropertiesViewController.h"
#import "JMPropertySearchDelegate.h"
#import "JMSearchResult.h"

@interface JMSearchPropertiesViewController ()
@property (strong,nonatomic) JMPropertySearchDelegate *delegate;
@end

@implementation JMSearchPropertiesViewController
@synthesize searchBar;
@synthesize searchResult=_searchResult;
@synthesize savedSearchTerm,searchWasActive,key,type;
@synthesize delegate;
@synthesize viewDelegate;
@synthesize dissmissBlock;
@synthesize projectId;
@synthesize resource;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) setSearchResult:(NSArray *)searchResult{
    _searchResult=searchResult;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.searchBar becomeFirstResponder];
	// restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];    
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
	
    self.delegate=[[JMPropertySearchDelegate alloc] initWithController:self];
    
    [self.tableView reloadData];
	self.tableView.scrollEnabled = YES;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [super viewDidUnload];
    _searchResult = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    // save the state of the search UI so that it can be restored if the view is re-created
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [self.searchResult count];
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	
    JMSearchResult *result=[self.searchResult objectAtIndex:indexPath.row];
	cell.textLabel.text= result.title;
    cell.detailTextLabel.text=result.resource;
    
    // Configure the cell...
    
    return cell;
}


- (void)filterContentForSearchText:(NSString*)searchText
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	[self.delegate getUsers:searchText];
	
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    [viewDelegate setValue:[NSString stringWithFormat:@"%@%@",resource,
                            cell.detailTextLabel.text] forKeyPath:key];
    [viewDelegate setValue:cell.textLabel.text forKeyPath:type];
    [self dismissViewControllerAnimated:YES completion:self.dissmissBlock];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
    [theSearchBar resignFirstResponder];
    [self filterContentForSearchText:theSearchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar

{  
     
    [theSearchBar resignFirstResponder];
    [self dismissModalViewControllerAnimated:YES];
    
}


@end
