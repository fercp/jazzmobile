//
//  RtcItem.h
//  Project Tracker
//
//  Created by Ferat Capar on 24/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RtcEnumeration.h"
#import "User.h"
#import "Comment.h"


@interface RtcItem : NSObject
@property NSInteger identifier;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) RtcEnumeration *severity;
@property (strong,nonatomic) RtcEnumeration *priority;
@property (strong,nonatomic) RtcEnumeration *state;
@property (strong,nonatomic) RtcEnumeration *type;
@property (strong,nonatomic) User  *owner;
@property (strong,nonatomic) User  *creator;
@property (strong,nonatomic) NSString *creationDate;
@property (strong,nonatomic) NSString  *dueDate;
@property (strong,nonatomic) NSArray *comments;
@property (strong,nonatomic) NSArray *attachedLinks;
@end
