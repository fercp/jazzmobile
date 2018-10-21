//
//  DateUtil.m
//  Project Tracker
//
//  Created by Ferat Capar on 26.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil
+(NSString *)formatDate:(NSString *) date{
   return  [NSString stringWithFormat:@"%@ %@",[date substringToIndex:10],[date substringWithRange:NSMakeRange(11,8)]];
}
@end
