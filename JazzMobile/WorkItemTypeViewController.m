//
//  WorkItemTypeViewController.m
//  Project Tracker
//
//  Created by Ferat Capar on 25.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WorkItemTypeViewController.h"
#import "WorkItemTypeListDelegate.h"
#import "ImageUtil.h"
#import "RtcEnumeration.h"

@interface WorkItemTypeViewController ()
@property (strong,nonatomic) NSArray *workItemTypes;
@property (strong,nonatomic) NSDictionary *imageDictionary;
@property (strong,nonatomic) WorkItemTypeListDelegate *wTypeDelegate;
@end

@implementation WorkItemTypeViewController



@synthesize projectId,wTypeDelegate,imageDictionary;
@synthesize workItemTypes=_workItemTypes;


-(void) setWorkItemTypes:(NSArray *)workItemTypes{
    _workItemTypes=workItemTypes;
    [[self navigationItem] setLeftBarButtonItem:nil];
    [[self tableView] reloadData];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.imageDictionary==nil)
        imageDictionary=[[NSMutableDictionary alloc] init];
     wTypeDelegate=[[WorkItemTypeListDelegate alloc] initWithController:self];
    [wTypeDelegate getWorkItemTypeListOfProject:projectId];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.workItemTypes=nil;
    self.wTypeDelegate=nil;
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
    return self.workItemTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    RtcEnumeration *rtcEnum=[self.workItemTypes objectAtIndex:indexPath.row];
    UIImageView *imageView=(UIImageView *)[cell viewWithTag:1];
    UIImage *image=[ImageUtil getImage:rtcEnum.iconUrl];
    [imageView setImage:image];
    [imageDictionary setValue:image forKey:rtcEnum.identifier];
    UILabel *label=(UILabel*)[cell viewWithTag:2];
    [label setText:rtcEnum.title];
    label=(UILabel*)[cell viewWithTag:3];
    [label setText:rtcEnum.identifier];
    return cell;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destination = segue.destinationViewController;
    UITableViewCell *cell=(UITableViewCell *) sender;
    UILabel *identifier=(UILabel *) [cell viewWithTag:3];
    
    if ([destination respondsToSelector:@selector(setUrl:)]) {
        NSString *url=[NSString stringWithFormat:@"%@%@%@%@%@%@",@"/oslc/contexts/",self.projectId,@"/workitems.json?_startIndex=0&oslc_cm.properties=rtc_cm:com.ibm.team.workitem.linktype.attachment.attachment%7B*,dc:creator%7B*%7D%7D,dc:identifier,dc:title,oslc_cm:severity%7B*%7D,oslc_cm:priority%7B*%7D,rtc_cm:state%7B*%7D,rtc_cm:ownedBy%7B*%7D,dc:creator%7B*%7D,dc:created,rtc_cm:due,dc:type%7B*%7D,rtc_cm%3Acomments%7Bdc:description,dc:created,dc:creator%7B*%7D%7D&oslc_cm.pageSize=20",@"&oslc_cm.query=rtc_cm:state%3D%22%7Bincomplete%7D%22%20and%20dc:type%3D%22",identifier.text,
                       @"%22%20and%20rtc_cm:ownedBy%3D%22%7BcurrentUser%7D%22"];
        [destination setValue:url forKey:@"url"];
        [destination setValue:imageDictionary forKey:@"imageDictionary"];
        [destination setValue:projectId forKey:@"projectId"];
    }
}



@end
