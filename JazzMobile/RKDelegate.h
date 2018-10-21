//
//  RestDelegate.h
//  Project Tracker
//
//  Created by Ferat Capar on 14/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "RestDelegate.h"
#import "JMDelegate.h"


@interface RKDelegate:NSObject
-(id) initWithRestDelegate:(JMDelegate *) delegate;
@end


