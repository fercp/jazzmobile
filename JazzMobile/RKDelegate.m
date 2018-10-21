//
//  RestDelegate.m
//  Project Tracker
//
//  Created by Ferat Capar on 23/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RKDelegate.h"
#import "MessageUtil.h"
#import "RtcQueryList.h"

@interface RKDelegate()
@property (strong,nonatomic) JMDelegate* delegate;
@end

@implementation RKDelegate
@synthesize delegate=_delegate;

- (void) checkAndSetCookie:(NSHTTPURLResponse *) response {
    NSString *cookie=[[response allHeaderFields] valueForKey:@"Set-Cookie"];
    if(cookie!=nil&&![cookie isEqualToString:@"X-com-ibm-team-foundation-auth-loop-avoidance=false"])
        [[[RKObjectManager sharedManager] HTTPClient] setDefaultHeader:@"\"Cookie\"" value:cookie];
}

-(void)request:(RKObjectRequestOperation *)operation result:(RKMappingResult *)result{
    
}

- (void)request:(RKRequestDescriptor*)request didLoadResponse:(NSHTTPURLResponse*)response{
    [self.delegate hideHUD];
    RestRequest *restRequest=[[RestRequest alloc] initWithRKRequest:request];
    [self checkAndSetCookie:response];
    RestResponse *restResponse=[[RestResponse alloc] initWithRKResponse:response];
    
    if( [self.delegate respondsToSelector:@selector(responseReturned:request:)])
        [self.delegate responseReturned:restResponse request:restRequest];
}


-(id) initWithRestDelegate:(JMDelegate *)delegate{
    self=[super init];
    self.delegate=delegate;
    return self;
}

- (void) objectLoader:(RKObjectRequestOperation *) operation result:(RKMappingResult *)objects{
    [self.delegate hideHUD];
    if( [self.delegate respondsToSelector:@selector(didLoadObjects:)])
        [self.delegate didLoadObjects:[objects array]];
}


-(void)request:(RKObjectRequestOperation *) operation err:(NSError *)error{    
    [self.delegate hideHUD];
    [MessageUtil showError:[error localizedDescription]];
}


@end
