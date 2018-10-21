//
//  WorkItemTypeListDelegate.h
//  Project Tracker
//
//  Created by Ferat Capar on 25.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMDelegate.h"

@interface WorkItemTypeListDelegate : JMDelegate
-(void) getWorkItemTypeListOfProject:(NSString *) projectId;
@end
