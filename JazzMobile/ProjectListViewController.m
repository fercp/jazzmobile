//
//  ProjectListControllerViewController.m
//  Project Tracker
//
//  Created by Ferat Capar on 14/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectListViewController.h"
#import "ProjectListDelegate.h"

@interface ProjectListViewController ()
@property (strong,nonatomic) NSDictionary *projectIds;
@property (strong,nonatomic) NSMutableArray *projectArray;
@property (strong,nonatomic) ProjectListDelegate *projectListDelegate;
@end

@implementation ProjectListViewController

@synthesize projectArray,projectIds,projectListDelegate;



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    projectArray=[[NSMutableArray alloc] init ];
    projectIds=[[NSMutableDictionary alloc] init];

   
    projectListDelegate=[[ProjectListDelegate alloc] initWithController:self];
    [ projectListDelegate getProjects];
    
    
}

-(void) setProjects:(NSDictionary *)projects{
    for(NSString * key in [projects keysSortedByValueUsingComparator:^(NSString *str1,NSString *str2){
        return [[str1 uppercaseString] compare:[str2 uppercaseString]];  
    }]){
        [projectArray addObject:[projects objectForKey:key]];
        [projectIds setValue:key forKey:[projects objectForKey:key]];
    }; 
    [[self navigationItem] setLeftBarButtonItem:nil];
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.projects=nil;
    self.projectArray=nil;
    self.projectIds=nil;
    self.projectListDelegate=nil;
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

    return [self.projectArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [cell.textLabel setText:[projectArray objectAtIndex:indexPath.row]];
    
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destination = segue.destinationViewController;
    UITableViewCell *cell=(UITableViewCell *) sender;

    if ([destination respondsToSelector:@selector(setProjectId:)]) { 
        [destination setValue:[projectIds objectForKey:[[cell textLabel] text]]
                       forKey:@"projectId"];
    }
}

@end
