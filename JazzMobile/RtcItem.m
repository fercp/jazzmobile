//
//  RtcItem.m
//  Project Tracker
//
//  Created by Ferat Capar on 24/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RtcItem.h"

@implementation RtcItem
@synthesize identifier,title,severity,priority,state,owner,creator,creationDate,dueDate,type,comments,attachedLinks;
-(NSString *) description{
    return [NSString stringWithFormat:@"id=%d title=%@ state=%@ severity=%@ priority=%@ owner=%@",identifier,title,state.identifier,severity.identifier,priority.identifier,owner.userId];
}
@end
