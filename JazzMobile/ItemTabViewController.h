//
//  ItemTabViewController.h
//  Project Tracker
//
//  Created by Ferat Capar on 26.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RtcItem.h"
@interface ItemTabViewController : UITabBarController
@property (strong,nonatomic) RtcItem *item;
@property (strong,nonatomic) NSString *projectId;
@property (strong,nonatomic) NSDictionary *imageDictionary;
@property (strong,nonatomic) UITableViewController *parentController;
@end
