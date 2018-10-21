//
//  JMEnumerationDelegate.m
//  JazzMobile
//
//  Created by Ferat Capar on 26.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMEnumerationDelegate.h"
#import "RestClient.h"
#import "RtcEnumeration.h"

@implementation JMEnumerationDelegate


-(void) getEnumerationWithUrl:(NSString *) url{
    NSString *resourceUrl=[url  stringByReplacingOccurrencesOfString:[[RestClient sharedClient] baseURL] withString:@""];
    [[RestClient sharedClient] getObjectsFrom:resourceUrl mapClass:[RtcEnumeration class] delegate:self];
}

- (void)didLoadObjects:(NSArray*)objects {
    [self.controller setValue:objects forKey:@"enumerations"];
}


@end
