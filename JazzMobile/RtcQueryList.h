//
//  RtcQueryList.h
//  Project Tracker
//
//  Created by Ferat Capar on 24/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMError.h"

@interface RtcQueryList : NSObject
@property NSInteger count;
@property NSInteger status;
@property (strong,nonatomic) NSString *url;
@property (strong,nonatomic) NSString *message;

@end
