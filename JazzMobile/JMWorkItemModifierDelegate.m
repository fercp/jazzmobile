//
//  JMWorkItemModifierDelegate.m
//  JazzMobile
//
//  Created by Ferat Capar on 26.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMWorkItemModifierDelegate.h"
#import "RestClient.h"

@implementation JMWorkItemModifierDelegate


-(void)saveItem:(JMWorkItemModifier*)item ofId:(NSInteger)identifier{
    NSString *url=[NSString stringWithFormat:@"/oslc/workitems/%d",identifier];
    [[RestClient sharedClient] putObject:url params:item delegate:self];
}

-(void)saveComment:(Comment*)comment ofId:(NSInteger)identifier{
    NSString *url=[NSString stringWithFormat:@"/oslc/workitems/%d/rtc_cm:comments",identifier];
    [[RestClient sharedClient] postObject:url params:comment delegate:self];    
}

- (void)didLoadObjects:(NSArray*)objects {
    [self.controller setValue:objects forKey:@"result"];
}
 


@end
