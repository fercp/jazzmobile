//
//  ItemHistoryDelegate.m
//  Project Tracker
//
//  Created by Ferat Capar on 26.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemHistoryDelegate.h"
#import "RestClient.h"

@implementation ItemHistoryDelegate


-(void) getHistoryOfItem:(NSInteger)itemId{
[[RestClient sharedClient] getObjectsFrom:[NSString stringWithFormat:@"%@%d%@",@"/service/com.ibm.team.workitem.common.internal.rest.IWorkItemRestService/workItemDTO2?id=",itemId,@"&includeAttributes=false&includeLinks=false&includeApprovals=false&includeHistory=true"] delegate:self];
}

- (void)didLoadObjects:(NSArray*)objects {
  [self.controller setValue:objects forKey:@"history"];
}

@end
