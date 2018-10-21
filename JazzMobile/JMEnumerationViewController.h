//
//  JMEnumerationViewController.h
//  JazzMobile
//
//  Created by Ferat Capar on 26.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMEnumerationViewController : UITableViewController
@property (strong,nonatomic) NSString *key;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSString *projectId;
@property (strong,nonatomic) NSString *resource;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) UIViewController *viewDelegate;
@property (copy,nonatomic)  void (^dissmissBlock)(void);
- (IBAction)onCancelClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end
