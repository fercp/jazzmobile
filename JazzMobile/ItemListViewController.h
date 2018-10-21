//
//  DefectViewControllerViewController.h
//  Project Tracker
//
//  Created by Ferat Capar on 16/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RtcQueryList.h"

@interface ItemListViewController : UITableViewController
@property (strong,nonatomic) NSString *projectId;
@property (strong,nonatomic) NSDictionary *imageDictionary;
@property (strong,nonatomic) NSString *url;
@property (strong,nonatomic) NSArray* defects;
@property (strong,nonatomic) RtcQueryList *queryResult;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UISegmentedControl *listCriteria;

- (IBAction)listCriteriaChanged:(id)sender;
@end
