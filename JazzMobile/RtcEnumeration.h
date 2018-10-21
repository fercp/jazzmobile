//
//  RtcEnumeration.h
//  Project Tracker
//
//  Created by Ferat Capar on 23/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RtcEnumeration : NSObject
@property (strong,nonatomic) NSString *identifier;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *iconUrl;
@property (strong,nonatomic) NSString *resource;
@property (strong,nonatomic) NSString *extraInfo;
@end
