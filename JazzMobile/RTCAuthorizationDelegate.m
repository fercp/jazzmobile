#import "RTCAuthorizationDelegate.h"
#import "RestClient.h"



// Here we declare that we implement the RKRequestDelegate protocol
// Check out RestKit/Network/RKRequest.h for additional delegate methods
// that are available.


@interface RTCAuthorizationDelegate ()
    @property (strong,nonatomic) NSString *userName;
    @property (strong,nonatomic) NSString *password;
@end


@implementation RTCAuthorizationDelegate


@synthesize userName=_userName;
@synthesize password=_password;




- (void) login:(NSString *) userName password : (NSString*)password  url:(NSString *) url{    
    self.userName=userName;
    self.password=password;
    RestClient *client=[RestClient clientWithURL:url user:userName password:password];
    [client get:@"/authenticated/identity" delegate:self];
}


-(void) responseReturned:(RestResponse *)response request:(RestRequest *) request{
    NSString *authCheck=[response headerValueWithKey:@"X-com-ibm-team-repository-web-auth-msg"];
    if([response isOK]){
        if ([authCheck isEqualToString:@"authrequired"]) {
            NSMutableDictionary *params = [[ NSMutableDictionary alloc] init]; 
            [ params setObject:self.userName forKey:@"j_username"]; 
            [ params setObject:self.password forKey:@"j_password"];
            [[RestClient sharedClient] post:@"/j_security_check" params:params delegate:self];        
        } else if ([authCheck isEqualToString:@"authfailed"]){
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"Invalid username/password" delegate:self 
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
        }else{
            [self.controller performSegueWithIdentifier: @"loginOk" sender: self];
        }
    }
}



@end
