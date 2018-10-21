//
//  ItemHistoryDelegate.h
//  Project Tracker
//
//  Created by Ferat Capar on 26.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMDelegate.h"

@interface ItemHistoryDelegate : JMDelegate
-(void) getHistoryOfItem:(NSInteger)itemId;
@end
