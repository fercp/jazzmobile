//
//  JMLink.h
//  JazzMobile
//
//  Created by Ferat Capar on 28.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMLink : NSObject
@property (strong,atomic) NSString *title;
@property (strong,atomic) NSString *creator;
@property (strong,atomic) NSString *format;
@property (strong,atomic) NSString *creationDate;
@property (strong,atomic) NSString *resource;
@property (strong,atomic) NSString *label;
@property NSInteger identifier;
@end
