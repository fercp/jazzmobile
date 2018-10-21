//
//  RestResponse.m
//  Project Tracker
//
//  Created by Ferat Capar on 23/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RestResponse.h"
@interface RestResponse()
@property NSHTTPURLResponse *response;
@end


@implementation RestResponse
@synthesize response=_response;


-(id) initWithRKResponse:(NSHTTPURLResponse *) response{
self=[super init];
self.response=response;
return self;

}

-(NSString *) headerValueWithKey:(NSString *) key{
return [[self.response allHeaderFields] valueForKey:key ];
}

-(bool) isOK{
return [self.response statusCode]>=200 && [self.response statusCode]<300;
}

-(NSString *) description{
return [self.response description];
}

@end
