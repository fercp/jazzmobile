//
//  MessageUtil.m
//  Project Tracker
//
//  Created by Ferat Capar on 27.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MessageUtil.h"

@implementation MessageUtil
+(void) showError:(NSString *) message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
@end
