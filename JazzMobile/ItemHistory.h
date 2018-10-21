//
//  ItemHistory.h
//  Project Tracker
//
//  Created by Ferat Capar on 26.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemHistory : NSObject
@property (strong,nonatomic) NSString *modifier;
@property (strong,nonatomic) NSString *modificationDate;
@property (strong,nonatomic) NSString *content;
@end
