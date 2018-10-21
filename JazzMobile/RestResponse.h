//
//  RestResponse.h
//  Project Tracker
//
//  Created by Ferat Capar on 23/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@interface RestResponse : NSObject
-(NSString *) headerValueWithKey:(NSString *) key;
-(bool) isOK;
-(id) initWithRKResponse:(NSHTTPURLResponse *) response;
@end
