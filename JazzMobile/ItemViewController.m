//
//  ItemViewController.m
//  Project Tracker
//
//  Created by Ferat Capar on 26.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemViewController.h"
#import "Comment.h"
#import "DateUtil.h"
#import "JMCommentViewController.h"
#import "ItemListDelegate.h"
#import "ImageUtil.h"


@interface ItemViewController ()
@property (strong,nonatomic) ItemListDelegate *delegate;
@property (strong,nonatomic) NSArray* defects;
@property (strong,nonatomic) RtcQueryList *queryResult;
@end

@implementation ItemViewController
@synthesize itemIcon;
@synthesize itemId;
@synthesize stateIcon;
@synthesize summary;
@synthesize stateTitle;
@synthesize owner;
@synthesize creator;
@synthesize priority;
@synthesize priorityIcon;
@synthesize severityIcon;
@synthesize severity;
@synthesize creationDate;
@synthesize dueDate;
@synthesize item;
@synthesize imageDictionary;
@synthesize scrollView;
@synthesize pageControl;
@synthesize viewControllers;
@synthesize delegate;
@synthesize queryResult;
@synthesize defects;

BOOL pageControlUsed;

-(UIImage*) imageOfRtcEnum:(RtcEnumeration*) rtcEnum{
    UIImage *image=[imageDictionary objectForKey:rtcEnum.identifier];
    if(image==nil){
        image=[ImageUtil getImage:rtcEnum.iconUrl ];
        [imageDictionary setValue:image forKey:rtcEnum.identifier];
    }
    return image;
}

- (void)loadView
{
    [super loadView];
    item=[[self parentViewController] valueForKey:@"item"];
    [[[self parentViewController] navigationItem] setTitle:[NSString stringWithFormat:@"Work Item : %d",item.identifier]];
    imageDictionary=[[self parentViewController] valueForKey:@"imageDictionary"];
	// Do any additional setup after loading the view, typically from a nib.
    if([imageDictionary objectForKey:item.type.identifier]!=nil)
      [itemIcon setImage:[imageDictionary objectForKey:item.type.identifier]];
    else {
        [itemIcon setImage:[self imageOfRtcEnum:item.type]];
    }
    [itemId setText:[NSString stringWithFormat:@"%d",item.identifier]];
    if([imageDictionary objectForKey:item.state.identifier]!=nil)
       [stateIcon setImage:[imageDictionary objectForKey:item.state.identifier]];
    else {
        [stateIcon setImage:[self imageOfRtcEnum:item.state]];
    }
    [summary setText:item.title];
    [stateTitle setText:item.state.title];
    [owner setText:item.owner.title];
    [creator setText:item.creator.title];
    [priority setText:item.priority.title];
    [severity setText:item.severity.title];
    if([imageDictionary objectForKey:item.priority.identifier]!=nil)
      [priorityIcon setImage:[imageDictionary objectForKey:item.priority.identifier]];
    else {
        [priorityIcon setImage:[self imageOfRtcEnum:item.priority]];
    }
    if([imageDictionary objectForKey:item.severity.identifier]!=nil)
       [severityIcon setImage:[imageDictionary objectForKey:item.severity.identifier]];
    else {
        [severityIcon setImage:[self imageOfRtcEnum:item.severity]];
    }
    
    [creationDate setText:[DateUtil formatDate:item.creationDate]];
    if(item.dueDate != nil)
      [dueDate setText:[DateUtil formatDate:item.dueDate]];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < item.comments.count; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * item.comments.count, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    pageControl.numberOfPages = item.comments.count;
    pageControl.currentPage = 0;
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //
    
    if(item.comments.count>0)
        [self loadScrollViewWithPage:0];
    if(item.comments.count>1)
        [self loadScrollViewWithPage:1];
     delegate=[[ItemListDelegate alloc] initWithController:self];
}

-(void) drawView{
    if([imageDictionary objectForKey:item.type.identifier]!=nil)
        [itemIcon setImage:[imageDictionary objectForKey:item.type.identifier]];
    else {
        [itemIcon setImage:[self imageOfRtcEnum:item.type]];
    }
    [itemId setText:[NSString stringWithFormat:@"%d",item.identifier]];
    if([imageDictionary objectForKey:item.state.identifier]!=nil)
        [stateIcon setImage:[imageDictionary objectForKey:item.state.identifier]];
    else {
        [stateIcon setImage:[self imageOfRtcEnum:item.state]];
    }
    [summary setText:item.title];
    [stateTitle setText:item.state.title];
    [owner setText:item.owner.title];
    [creator setText:item.creator.title];
    [priority setText:item.priority.title];
    [severity setText:item.severity.title];
    if([imageDictionary objectForKey:item.priority.identifier]!=nil)
        [priorityIcon setImage:[imageDictionary objectForKey:item.priority.identifier]];
    else {
        [priorityIcon setImage:[self imageOfRtcEnum:item.priority]];
    }
    if([imageDictionary objectForKey:item.severity.identifier]!=nil)
        [severityIcon setImage:[imageDictionary objectForKey:item.severity.identifier]];
    else {
        [severityIcon setImage:[self imageOfRtcEnum:item.severity]];
    }
    [creationDate setText:[DateUtil formatDate:item.creationDate]];
    if(item.dueDate != nil)
        [dueDate setText:[DateUtil formatDate:item.dueDate]];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < item.comments.count; i++)
    {
		[controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * item.comments.count, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    

    pageControl.numberOfPages = item.comments.count;
    pageControl.currentPage = 0;
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    //
    
    if(item.comments.count>0)
        [self loadScrollViewWithPage:0];
    if(item.comments.count>1)
        [self loadScrollViewWithPage:1];
    
}

-(void) setDefects:(NSArray *)defects{
    self.item=[defects objectAtIndex:0];
    [[self parentViewController] setValue:self.item forKey:@"item"];
    [self drawView];
}

- (void)loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= self.item.comments.count)
        return;
    Comment *comment=[item.comments objectAtIndex:page];
    
    // replace the placeholder if necessary
    JMCommentViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [self.storyboard instantiateViewControllerWithIdentifier:@"JMVC"];   
        controller = [controller initWithComment:comment];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    // add the controller's view to the scroll view
    if (controller.view.superview == nil)
    {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed)
    {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender
{
    int page = pageControl.currentPage;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setItemIcon:nil];
    [self setItemId:nil];
    [self setStateIcon:nil];
    [self setStateTitle:nil];
    [self setOwner:nil];
    [self setCreator:nil];
    [self setPriority:nil];
    [self setPriorityIcon:nil];
    [self setSeverityIcon:nil];
    [self setSeverity:nil];
    [self setCreationDate:nil];
    [self setDueDate:nil];
    [self setSummary:nil];
    [self setSummary:nil];
    [self setScrollView:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) reload{
    NSString *url=[NSString stringWithFormat:@"/oslc/contexts/%@%@%@",[[self parentViewController] valueForKey:@"projectId"],@"/workitems.json?oslc_cm.properties=rtc_cm:com.ibm.team.workitem.linktype.attachment.attachment%7B*,dc:creator%7B*%7D%7D,dc:identifier,dc:title,oslc_cm:severity%7B*%7D,oslc_cm:priority%7B*%7D,rtc_cm:state%7B*%7D,rtc_cm:ownedBy%7B*%7D,dc:creator%7B*%7D,dc:created,rtc_cm:due,dc:type%7B*%7D,rtc_cm%3Acomments%7Bdc:description,dc:created,dc:creator%7B*%7D%7D&oslc_cm.query=dc:identifier=",itemId.text];
    [delegate retriveFromUrl:url];
}


@end
