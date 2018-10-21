//
//  RootViewController.h
//  Project Tracker
//
//  Created by Ferat Capar on 30/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTCAuthorizationDelegate.h"
#import "MBProgressHUD.h"

@interface RootViewController : UIViewController <UIPageViewControllerDelegate,UITextFieldDelegate,MBProgressHUDDelegate>
    
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UITextField *repositoryAddress;

@end
