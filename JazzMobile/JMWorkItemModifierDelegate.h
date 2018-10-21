//
//  JMWorkItemModifierDelegate.h
//  JazzMobile
//
//  Created by Ferat Capar on 26.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMDelegate.h"
#import "JMWorkItemModifier.h"
#import "Comment.h"

@interface JMWorkItemModifierDelegate : JMDelegate
-(void)saveItem:(JMWorkItemModifier*)item ofId:(NSInteger)identifier;
-(void)saveComment:(Comment*)comment ofId:(NSInteger)identifier;
@end
