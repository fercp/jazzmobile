//
//  JMWorkItemModifier.h
//  JazzMobile
//
//  Created by Ferat Capar on 26.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMResourceRepresentation.h"


@interface JMWorkItemModifier : NSObject
@property (strong,nonatomic) JMResourceRepresentation *owner;
@property (strong,nonatomic) JMResourceRepresentation *state;
@property (strong,nonatomic) JMResourceRepresentation *severity;
@property (strong,nonatomic) JMResourceRepresentation *priority;
@property (strong,nonatomic) NSArray *attachedLinks;
@end
