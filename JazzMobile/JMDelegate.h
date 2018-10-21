//
//  JMDelegate.h
//  JazzMobile
//
//  Created by Ferat Capar on 01.04.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestDelegate.h"
#import "MBProgressHUD.h"

@interface JMDelegate : NSObject<RestDelegate,MBProgressHUDDelegate>
-(void) showHUD;
-(void) hideHUD;
@end
