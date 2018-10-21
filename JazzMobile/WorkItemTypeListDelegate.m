//
//  WorkItemTypeListDelegate.m
//  Project Tracker
//
//  Created by Ferat Capar on 25.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WorkItemTypeListDelegate.h"
#import "RestClient.h"
#import "RtcEnumeration.h"

@implementation WorkItemTypeListDelegate


- (void)didLoadObjects:(NSArray*)objects {
  [self.controller setValue:objects forKey:@"workItemTypes"];
}

-(void) getWorkItemTypeListOfProject:(NSString *) projectId{
    NSString *url=[NSString stringWithFormat:@"%@%@",@"/oslc/types/",projectId];;
    [[RestClient sharedClient] getObjectsFrom:url mapClass:[RtcEnumeration class] delegate:self];
}


@end
