//
//  ItemViewController.h
//  Project Tracker
//
//  Created by Ferat Capar on 26.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RtcItem.h"
#import "RtcQueryList.h"

@interface ItemViewController : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *itemIcon;
@property (weak, nonatomic) IBOutlet UILabel *itemId;
@property (weak, nonatomic) IBOutlet UIImageView *stateIcon;
@property (weak, nonatomic) IBOutlet UITextView *summary;
@property (weak, nonatomic) IBOutlet UILabel *stateTitle;
@property (weak, nonatomic) IBOutlet UILabel *owner;
@property (weak, nonatomic) IBOutlet UILabel *creator;
@property (weak, nonatomic) IBOutlet UILabel *priority;
@property (weak, nonatomic) IBOutlet UIImageView *priorityIcon;
@property (weak, nonatomic) IBOutlet UIImageView *severityIcon;
@property (weak, nonatomic) IBOutlet UILabel *severity;
@property (weak, nonatomic) IBOutlet UILabel *creationDate;
@property (weak, nonatomic) IBOutlet UILabel *dueDate;
@property (strong,nonatomic)RtcItem *item;
@property (strong,nonatomic)NSDictionary* imageDictionary;
@property (strong,nonatomic) NSMutableArray *viewControllers;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
-(void) reload;
- (IBAction)changePage:(id)sender;
- (void)loadScrollViewWithPage:(int)page;
@end
