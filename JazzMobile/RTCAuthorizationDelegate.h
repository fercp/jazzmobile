#import "JMDelegate.h"

@interface RTCAuthorizationDelegate : JMDelegate 

- (void) login:(NSString *) userName password : (NSString*)password url:(NSString *) url;

@end
