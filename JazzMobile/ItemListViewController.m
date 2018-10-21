//
//  DefectViewControllerViewController.m
//  Project Tracker
//
//  Created by Ferat Capar on 16/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemListViewController.h"
#import "RtcItem.h"
#import "ItemListDelegate.h"
#import "ImageUtil.h"

@interface ItemListViewController ()
@property (strong,nonatomic) ItemListDelegate *delegate;
@property (nonatomic) NSInteger currentCount;
@property (nonatomic) NSInteger lastIndex;
@property (strong,nonatomic) NSString *changed;
@property (strong,nonatomic)NSArray *allDefects;
-(UIImage*) imageOfRtcEnum:(RtcEnumeration*) rtcEnum;
@end

@implementation ItemListViewController
@synthesize navigationItem;
@synthesize listCriteria;


@synthesize imageDictionary,queryResult;
@synthesize defects=_defects;
@synthesize url;
@synthesize delegate;
@synthesize changed;
@synthesize currentCount,projectId,allDefects,lastIndex;


-(void)loadItems{
    [self.listCriteria  setTitle:@"Loading..." forSegmentAtIndex:[self.listCriteria selectedSegmentIndex]];
   
    self.url=[self.url stringByReplacingOccurrencesOfString:@"%20and%20rtc_cm:ownedBy%3D%22%7BcurrentUser%7D%22" withString:@""];  
    if(listCriteria.selectedSegmentIndex==0){
     self.url=[NSString stringWithFormat:@"%@%@", self.url,@"%20and%20rtc_cm:ownedBy%3D%22%7BcurrentUser%7D%22"];        
    }  
  
    [delegate retriveFromUrl:self.url];                
}

-(void)refresh{
    self.currentCount=0;
    self.url=[self.url stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"_startIndex=%d",
                                                             self.lastIndex] withString:@"_startIndex=0"];
    self.allDefects=nil;
    [self loadItems];
}

- (IBAction)listCriteriaChanged:(id)sender{
    if([self.listCriteria selectedSegmentIndex]==0)
        [self.listCriteria setTitle:@"All Items" forSegmentAtIndex:1];
    else
        [self.listCriteria setTitle:@"My Items" forSegmentAtIndex:0];
    [self refresh];
}

-(NSInteger)findCurrentCount:(NSString *)searchUrl{
    NSCharacterSet* characters = [NSCharacterSet characterSetWithCharactersInString:@"?&"];
    NSArray *tokens=[searchUrl componentsSeparatedByCharactersInSet:characters];
    
    for(NSString *token in tokens){
        if([token hasPrefix:@"_startIndex"]){
            return [[token stringByReplacingOccurrencesOfString:@"_startIndex=" withString:@""] integerValue];
        }
    }
    return NSNotFound;
}


- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(self.allDefects==nil)
        allDefects=self.defects;
    else
        allDefects=[allDefects arrayByAddingObjectsFromArray:self.defects];
    [self.tableView reloadData];
    NSInteger currCount=[self findCurrentCount:queryResult.url];
    if(currCount!=NSNotFound){
        self.currentCount=currCount;
    }
    else {
        self.currentCount=queryResult.count;
    }
    [self.listCriteria setTitle:[ NSString stringWithFormat:@"%d of %d",self.currentCount,queryResult.count] forSegmentAtIndex:[self.listCriteria selectedSegmentIndex]];
    [navigationItem setTitle:[ NSString stringWithFormat:@"%d of %d",self.currentCount,queryResult.count]];
    
    changed=@"NO";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addObserver:self forKeyPath:@"defects" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self.refreshControl addTarget:self
                         action:@selector(action)
               forControlEvents:UIControlEventValueChanged];
    changed=@"YES";
    self.lastIndex=0;
    self.currentCount=0;
}



- (void)action{
    [self refresh];
    [self.refreshControl endRefreshing];
}

- (void)viewDidUnload
{
    [self setListCriteria:nil];
    [super viewDidUnload];
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
  return self.allDefects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    RtcItem *defect=[self.allDefects objectAtIndex:indexPath.row];
  
    UILabel *label=(UILabel *) [cell viewWithTag:3];
    [label setText:[NSString stringWithFormat:@"%d",defect.identifier]];
    
    
    label=(UILabel *) [cell viewWithTag:4];
    [label setText:defect.title];

    
    label=(UILabel *) [cell viewWithTag:6];
    [label setText:defect.state.title];
    
    label=(UILabel *) [cell viewWithTag:7];
    [label setText:defect.owner.title];
    
    UIImageView *imageView=(UIImageView *)[cell viewWithTag:1];
    [imageView setImage:[self imageOfRtcEnum:defect.severity]];
        
    imageView=(UIImageView *)[cell viewWithTag:2];
    [imageView setImage:[self imageOfRtcEnum:defect.priority]];

    imageView=(UIImageView *)[cell viewWithTag:5];
    [imageView setImage:[self imageOfRtcEnum:defect.state]];
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if([self.url rangeOfString:@"currentUser"].location == NSNotFound) 
        [listCriteria setSelectedSegmentIndex:1];
    delegate=[[ItemListDelegate alloc] initWithController:self];
    if(imageDictionary==nil)
        imageDictionary=[[NSMutableDictionary alloc] initWithCapacity:20];

    if([changed isEqualToString:@"YES"]){
      self.allDefects=nil;
      [self loadItems];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if((indexPath.row+1)==self.currentCount&&(indexPath.row+1)<queryResult.count){
        NSString *nextUrl=[self.url stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"_startIndex=%d",
                                                                          self.currentCount-20] withString:
                           [NSString stringWithFormat:@"_startIndex=%d",self.currentCount]];
        self.lastIndex=self.currentCount;
        [self setUrl:nextUrl];
        [self loadItems];
    }
}

-(UIImage*) imageOfRtcEnum:(RtcEnumeration*) rtcEnum{
    UIImage *image=[imageDictionary objectForKey:rtcEnum.identifier];
    if(image==nil&&rtcEnum!=nil&&rtcEnum.identifier!=nil){
        image=[ImageUtil getImage:rtcEnum.iconUrl ];
        [imageDictionary setValue:image forKey:rtcEnum.identifier];
    }
    return image;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ItemDetailSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destination = segue.destinationViewController;
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    if([destination respondsToSelector:@selector(setItem:)]){
        [destination setValue:[self.allDefects objectAtIndex:path.row] forKey:@"item"];
    }
    if([destination respondsToSelector:@selector(setParentController:)])
        [destination setValue:self forKey:@"parentController"];
    [destination setValue:imageDictionary forKey:@"imageDictionary"];
    [destination setValue:projectId forKey:@"projectId"];
}
     
@end
