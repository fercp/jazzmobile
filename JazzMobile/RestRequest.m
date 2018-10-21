//
//  RestRequest.m
//  Project Tracker
//
//  Created by Ferat Capar on 23/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RestRequest.h"



@interface RestRequest()
@property (strong,nonatomic) RKRequestDescriptor *request;
@property (strong,nonatomic) RKObjectManager *loader;
@end

@implementation RestRequest
@synthesize request=_request;
@synthesize loader=_loader;


-(id) initWithRKRequest:(RKRequestDescriptor *) request{
    self=[super init];
    self.request=request;
    return self;
}

-(id) initWithRKObjectLoader:(RKObjectManager *)loader{
self=[super init];
self.loader=loader;
return self;
}
@end
