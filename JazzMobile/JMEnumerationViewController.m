//
//  JMEnumerationViewController.m
//  JazzMobile
//
//  Created by Ferat Capar on 26.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMEnumerationViewController.h"
#import "JMEnumerationDelegate.h"
#import "RtcEnumeration.h"

@interface JMEnumerationViewController ()
@property (strong,nonatomic) JMEnumerationDelegate *delegate;
@property (strong,nonatomic) NSArray *enumerations;
@end

@implementation JMEnumerationViewController
@synthesize navigationBar;
@synthesize title;



@synthesize delegate,projectId,viewDelegate,dissmissBlock,key,type,resource;
@synthesize enumerations=_enumerations;

-(void)setEnumerations:(NSArray *)enumerations{
    _enumerations=enumerations;
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self.navigationBar.items  objectAtIndex:0] setTitle:title];
    delegate=[[JMEnumerationDelegate alloc] initWithController:self];
    if([resource characterAtIndex:resource.length-1]=='/')
        resource=[resource substringToIndex:resource.length-1];
    
    resource=[NSString stringWithFormat:@"%@%@",resource,@"?oslc_cm.properties=*,rtc_cm:resultState%7Bdc:title%7D"];
    [delegate getEnumerationWithUrl:resource];
}

- (void)viewDidUnload
{
    [self setNavigationBar:nil];
    [super viewDidUnload];
    self.enumerations=nil;
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

    return [self.enumerations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    RtcEnumeration *rtcEnum=[self.enumerations objectAtIndex:indexPath.row];
    cell.textLabel.text=rtcEnum.title;
    cell.detailTextLabel.text=rtcEnum.resource;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self.tableView cellForRowAtIndexPath:indexPath];
    [viewDelegate setValue:cell.detailTextLabel.text forKeyPath:key];
    RtcEnumeration *rtcEnum=[self.enumerations objectAtIndex:indexPath.row];
    if(rtcEnum.extraInfo==nil)
       [viewDelegate setValue:cell.textLabel.text forKeyPath:type];
    else {
        [viewDelegate setValue:rtcEnum.extraInfo forKeyPath:type];
    }
    [self dismissViewControllerAnimated:YES completion:self.dissmissBlock];

}

- (IBAction)onCancelClicked:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
