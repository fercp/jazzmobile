//
//  RestClient.h
//  Project Tracker
//
//  Created by Ferat Capar on 23/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestRequest.h"

@interface RestClient : NSObject
+ (RestClient *) sharedClient;
+ (RestClient *) clientWithURL:(NSString *)url user:(NSString *) user password:(NSString *) password;
- (RestRequest*)post:(NSString*)resourcePath params:(NSObject*)params delegate:(id)delegate ;
- (RKObjectManager*)postObject:(NSString*)resourcePath params:(NSObject*)params delegate:(id)delegate;
- (RKObjectManager *)putObject:(NSString*)resourcePath params:(NSObject*)params delegate:(id)delegate;
- (RestRequest*)get:(NSString*)resourcePath delegate:(id)delegate ;
- (void) getObjectsFrom:(NSString*)resourcePath mapClass:(Class) class delegate:(id)delegate ;
- (void) getObjectsFrom:(NSString*)resourcePath delegate:(id)delegate ;
-(RestRequest*) putImage:(UIImage*) image toUrl:(NSString *) url delegate:(id)delegate;
-(RestRequest*) putMovie:(NSData*) movie toUrl:(NSString *) url delegate:(id)delegate;
-(NSString *) baseURL;
- (UIImage *) getImage:(NSString*) url;
@end
