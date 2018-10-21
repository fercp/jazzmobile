//
//  ImageUtil.m
//  Project Tracker
//
//  Created by Ferat Capar on 25.02.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageUtil.h"
#import "RestClient.h"

@implementation ImageUtil
+(UIImage *) getImage:(NSString *) url{
    return [[RestClient sharedClient] getImage:url];
}
@end
