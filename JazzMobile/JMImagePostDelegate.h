//
//  JMImagePostDelegate.h
//  JazzMobile
//
//  Created by Ferat Capar on 27.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMDelegate.h"

@interface JMImagePostDelegate : JMDelegate
-(void)putImage:(UIImage*) image projectId:(NSString *)projectId;
-(void)putMovie:(NSData*) movie projectId:(NSString *)projectId;
@end
