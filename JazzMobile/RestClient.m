//
//  RestClient.m
//  Project Tracker
//
//  Created by Ferat Capar on 23/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <RestKit/RestKit.h>

#import "RestClient.h"
#import "RKDelegate.h"
#import "Mapper.h"
#import <UIKit/UIKit.h>
#import "RtcItem.h"
#import "JMDelegate.h"


@interface RestClient()
@property (strong,nonatomic) RKObjectManager *client;
@property (strong,nonatomic) NSMutableArray *delegates;
@property (strong,nonatomic) NSString *baseURL;
@end

@implementation RestClient

@synthesize client=_client;
@synthesize delegates=_delegates;
@synthesize baseURL=_baseURL;

static RestClient* sharedClient = nil;

+ (RestClient*)sharedClient {
	return sharedClient;
}

+ (void)setSharedClient:(RestClient*)client {
    sharedClient = client;
}

- (UIImage *) getImage:(NSString*) url{
    NSURL *URL = [NSURL URLWithString:url];
 /*   NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [[RKObjectManager sharedManager].HTTPClient postPath:url parameters:nil success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>]
    RKRequest* request = [[RKRequest alloc] initWithURL:[NSURL URLWithString:url] delegate:nil];
    [[RKClient sharedClient] setupRequest:request];    
    NSData* imageData = [[request sendSynchronously] body];
 
   return [[UIImage alloc] initWithData:imageData];  */
    return nil;
}

-(RestRequest*) putMovie:(NSData*) movie toUrl:(NSString *) url delegate:(JMDelegate *)delegate{
    [delegate showHUD];
    RKDelegate *rkDelegate=[[RKDelegate alloc] initWithRestDelegate:delegate];
 /*   [self.delegates addObject:rkDelegate];
    RKParams* params = [RKParams params]; 
    RKParamsAttachment* attachment = [params 
                                      setData:movie MIMEType:@"video/quicktime" forParam:@"movie[mov]"]; 
    [attachment setFileName:@"iPhoneMovie.mov"];
    [attachment setName:@"uploadFileInput"];
    RestRequest *request=[[RestRequest alloc] 
                          initWithRKObjectLoader:[[[RKObjectManager sharedManager] client] post:url params:params  
                                                                                       delegate:rkDelegate]];
  
    return request;*/
    return nil;
}
 
-(RestRequest*) putImage:(UIImage*) image toUrl:(NSString *) url delegate:(JMDelegate *)delegate{
    [delegate showHUD];
  /*  RKDelegate *rkDelegate=[[RKDelegate alloc] initWithRestDelegate:delegate];
    [self.delegates addObject:rkDelegate];
    RKParams* params = [RKParams params]; 
    RKParamsAttachment* attachment = [params 
                                      setData:UIImageJPEGRepresentation(image, 
                                                                        0.1) MIMEType:@"image/jpeg" forParam:@"photo[image]"]; 
    [attachment setFileName:@"iPhoneImage.jpeg"];
    [attachment setName:@"uploadFileInput"];
    
    RestRequest *request=[[RestRequest alloc] 
                          initWithRKObjectLoader:[[[RKObjectManager sharedManager] client] post:url params:params  
                          delegate:rkDelegate]];
 
    return request;
   */
    return nil;
}

- (RestRequest*)post:(NSString*)resourcePath params:(NSObject*)params delegate:(JMDelegate *)delegate {
    [delegate showHUD];
    RKDelegate *rkDelegate=[[RKDelegate alloc] initWithRestDelegate:delegate];
    [self.delegates addObject:rkDelegate];
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:resourcePath];
    NSMutableURLRequest *request = [manager requestWithObject:nil     method:RKRequestMethodPOST path:resourcePath parameters:params];
    RKObjectRequestOperation *operation = [manager  objectRequestOperationWithRequest:request ^(RKObjectRequestOperation *operation,     RKMappingResult *result) {
        [rkDelegate 
    } failure:nil];
    RestRequest *request=[[RestRequest alloc] initWithRKRequest:[self.client post: params:(NSObject<RKRequestSerializable>*)params delegate:rkDelegate]];
    return request;
}
- (RestRequest*)postObject:(NSString*)resourcePath params:(NSObject*)params delegate:(JMDelegate *)delegate
{
    [delegate showHUD];
    RKDelegate *rkDelegate=[[RKDelegate alloc] initWithRestDelegate:delegate];
    [[[[RKObjectManager sharedManager] router] routeSet] addRoute:[RKRoute routeWithClass:[params class] pathPattern:resourcePath method:RKRequestMethodPOST]];
    [self.delegates addObject:rkDelegate];
    [[RKObjectManager sharedManager] postObject:params path:resourcePath parameters:nil success:<#^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)success#> failure:<#^(RKObjectRequestOperation *operation, NSError *error)failure#>]
    RestRequest *request=[[RestRequest alloc] initWithRKObjectLoader:[RKObjectManager.sharedManager postObject:(NSObject<RKRequestSerializable>*)params mapResponseWith:[[Mapper mappings] valueForKey:NSStringFromClass([RtcItem class])] delegate:rkDelegate]];
    return request;
}

- (RestRequest*)putObject:(NSString*)resourcePath params:(NSObject*)params delegate:(JMDelegate *)delegate
{
    [delegate showHUD];
    RKDelegate *rkDelegate=[[RKDelegate alloc] initWithRestDelegate:delegate];
  //  [RKObjectManager sharedManager].serializationMIMEType = RKMIMETypeJSON;
    [self.delegates addObject:rkDelegate];
    //RKObjectRouter *router=[RKObjectRouter new];
    //[router routeClass:[params class]  toResourcePath:resourcePath];
    //[[RKObjectManager sharedManager] setRouter:router];
    //RestRequest *request=[[RestRequest alloc] initWithRKObjectLoader:[RKObjectManager.sharedManager putObject:(NSObject<RKRequestSerializable>*)params mapResponseWith:[[Mapper mappings] valueForKey:NSStringFromClass([RtcItem class])] delegate:rkDelegate]];
    //return request;
    return nil;
}

- (RestRequest*)get:(NSString*)resourcePath delegate:(id)delegate {
    [delegate showHUD];
    RKDelegate *rkDelegate=[[RKDelegate alloc] initWithRestDelegate:delegate];
    [self.delegates addObject:rkDelegate]; 
    RestRequest *request=[[RestRequest alloc] initWithRKRequest:[self.client get:resourcePath delegate:rkDelegate]];
    return request;
}

- (void) getObjectsFrom:(NSString*)resourcePath mapClass:(Class) class delegate:(JMDelegate *)delegate{
    [delegate showHUD];
    RKDelegate *rkDelegate=[[RKDelegate alloc] initWithRestDelegate:delegate];
    [self.delegates addObject:rkDelegate];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath objectMapping:[[Mapper mappings] valueForKey:NSStringFromClass(class)] delegate:rkDelegate]; 
}

- (void) getObjectsFrom:(NSString*)resourcePath delegate:(id)delegate{
    [delegate showHUD];
    RKDelegate *rkDelegate=[[RKDelegate alloc] initWithRestDelegate:delegate];
    [self.delegates addObject:rkDelegate]; 
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:resourcePath delegate:rkDelegate]; 
}

- (id) init{
    self=[super init];
    
     RKLogConfigureByName("RestKit/*", RKLogLevelTrace);
    [[RKParserRegistry sharedRegistry] setParserClass: 
     [RKXMLParserLibXML class] forMIMEType:@"application/x-oslc-disc-service-provider-catalog+xml"]; 
    [[RKParserRegistry sharedRegistry] setParserClass: 
     [RKXMLParserLibXML class] forMIMEType:@"text/xml"]; 
    if (sharedClient == nil) {
        [RestClient setSharedClient:self];
    }
    self.delegates=[[NSMutableArray alloc] init];
    return self;
}

-(NSString *) baseURL{
    return [self.client baseURL];
}

- (id) initWithURL:(NSString *) url{
    self=[self init];
    RKObjectManager *objectManager=[RKObjectManager objectManagerWithBaseURL:url];
    [objectManager setClient:self.client];
    self.baseURL=url;
    [Mapper initMappings];
    [[self.client HTTPHeaders] setValue:@"keep-alive" forKey:@"Connection"];
    [[self.client HTTPHeaders] setValue:url forKey:@"Referer"];
    [[self.client HTTPHeaders] setValue:nil forKey:@"Cookies"];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:nil]; 
    return self;
}
-(id) initWithURL:(NSString *)url user:(NSString *) userName password:(NSString *) password{
    self=[self initWithURL:url];    
    [self.client setUsername:userName];
    [self.client setPassword:password];
    [self.client setForceBasicAuthentication:YES];
    return self;
}


+ (RestClient *) clientWithURL:(NSString *)url user:(NSString *) user password:(NSString *) password{
   // if(sharedClient==nil)
      sharedClient=[[RestClient alloc] initWithURL:url user:user password:password];
    return sharedClient;
}

@end
