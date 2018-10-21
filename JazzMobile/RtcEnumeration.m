//
//  RtcEnumeration.m
//  Project Tracker
//
//  Created by Ferat Capar on 23/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RtcEnumeration.h"
#import "RestClient.h"

@implementation RtcEnumeration
@synthesize identifier,title,extraInfo;
@synthesize resource=_resource;
@synthesize iconUrl=_iconUrl;

-(void) setResource:(NSString *)resource{
    _resource=[resource stringByReplacingOccurrencesOfString:@"" withString:[[RestClient sharedClient] baseURL]];
}

-(void)setIconUrl:(NSString *)iconUrl{
    _iconUrl=[iconUrl stringByReplacingOccurrencesOfString:@"" withString:[[RestClient sharedClient] baseURL]];
}
@end
