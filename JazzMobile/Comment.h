//
//  Comment.h
//  Project Tracker
//
//  Created by Ferat Capar on 26.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Comment : NSObject
@property (strong,nonatomic) NSString *description;
@property (strong,nonatomic) NSString *creationDate;
@property (strong,nonatomic) User *creator;
@end
