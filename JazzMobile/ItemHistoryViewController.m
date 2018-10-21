//
//  ItemHistoryViewController.m
//  Project Tracker
//
//  Created by Ferat Capar on 26.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemHistoryViewController.h"
#import "ItemHistoryDelegate.h"
#import "ItemHistory.h"
#import "DateUtil.h"
#import "RtcItem.h"
#import "RestClient.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>



@interface ItemHistoryViewController ()
@property (strong,nonatomic) ItemHistoryDelegate *delegate;
@property (strong,nonatomic) NSArray *history;
@property (strong,nonatomic) RtcItem *item;
@end

@implementation ItemHistoryViewController
@synthesize delegate,item;
@synthesize history=_history;

-(void) setHistory:(NSArray *)history{
    _history=history;
    [self.tableView reloadData];    
}

- (void)loadView
{
    [super loadView];
    item=[[self parentViewController] valueForKey:@"item"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate=[[ItemHistoryDelegate alloc] initWithController:self];
    [delegate getHistoryOfItem:item.identifier];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.history.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    ItemHistory *itemHistory=[self.history objectAtIndex:indexPath.row];
    UILabel *label=(UILabel *)[cell viewWithTag:1];
    [label setText:itemHistory.modifier];
    
    label=(UILabel *)[cell viewWithTag:2];
    [label setText:[DateUtil formatDate:itemHistory.modificationDate]];
    
    UIWebView *webView=(UIWebView *)[cell viewWithTag:3];
    NSString *htmlString=[NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<style type=\"text/css\"> \n"
                          "td {font-family: \"%@\"; font-size: 40;}\n"
                          "</style> \n"
                          "</head> \n"
                          "<body>%@</body> \n"
                          "</html>", @"helvetica",itemHistory.content];

    [webView loadHTMLString:htmlString baseURL:nil];
    
    return cell;
}



-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
       [ [ UIApplication sharedApplication ] openURL: [inRequest URL] ]; 
       return NO;
    }
    
    return YES;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
