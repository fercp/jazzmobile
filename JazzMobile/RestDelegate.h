//
//  RestDelegate.h
//  Project Tracker
//
//  Created by Ferat Capar on 23/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RestRequest.h"
#import "RestResponse.h"

@protocol RestDelegate <NSObject>
@property UIViewController * controller;

@required
- (id)   initWithController:(UIViewController *)controller ;

@optional
-(void) responseReturned:(RestResponse *)response request:(RestRequest *) request;
-(void) didLoadObjects:(NSArray*)objects; 
@end
