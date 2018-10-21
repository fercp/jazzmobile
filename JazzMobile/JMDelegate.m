//
//  JMDelegate.m
//  JazzMobile
//
//  Created by Ferat Capar on 01.04.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMDelegate.h"


@interface JMDelegate()
@property (strong,nonatomic) MBProgressHUD *HUD;
@end

@implementation JMDelegate
@synthesize controller=_controller;
@synthesize HUD;


-(void) showHUD {
	self.HUD = [MBProgressHUD showHUDAddedTo:self.controller.view animated:YES];
}

-(void)hideHUD{
    [self.HUD hide:YES];  
}

-(id) initWithController:(UIViewController *)controller {
    self=[super init];
    self.controller=controller;
    return self;
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[self.HUD removeFromSuperview];
	self.HUD = nil;
}

@end
