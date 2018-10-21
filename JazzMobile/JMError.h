//
//  JMError.h
//  JazzMobile
//
//  Created by Ferat Capar on 27.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMError : NSObject
@property (strong,nonatomic) NSString *message;
@property NSInteger status;
@end
