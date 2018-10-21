//
//  JMImagePostDelegate.m
//  JazzMobile
//
//  Created by Ferat Capar on 27.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMImagePostDelegate.h"
#import "RestClient.h"
#import "JMLink.h"

@implementation JMImagePostDelegate


-(void)putImage:(UIImage*) image projectId:(NSString *)projectId{
    [[RestClient sharedClient] putImage:image toUrl:[NSString stringWithFormat:@"%@%@",@"/service/com.ibm.team.workitem.service.internal.rest.IAttachmentRestService/?projectId=",projectId] 
                               delegate:self];
    
}

-(void)putMovie:(NSData*) movie projectId:(NSString *)projectId{
    [[RestClient sharedClient] putMovie:movie toUrl:[NSString stringWithFormat:@"%@%@",@"/service/com.ibm.team.workitem.service.internal.rest.IAttachmentRestService/?projectId=",projectId] 
                               delegate:self];    
}

-(void) responseReturned:(RestResponse *)response request:(RestRequest *) request{
    if([response isOK]){
        JMLink *attachment=[JMLink new];
        NSArray *parts=[response.description componentsSeparatedByString:@":"];
        parts=[[parts objectAtIndex:1] componentsSeparatedByString:@","];
        attachment.resource=[parts objectAtIndex:0];
        attachment.resource=[NSString stringWithFormat:@"%@%@%@",[[RestClient sharedClient] baseURL],@"/resource/itemOid/com.ibm.team.workitem.Attachment/",attachment.resource];
        
        attachment.label=[NSString stringWithFormat:@"%@%@",[[parts objectAtIndex:1] stringByReplacingOccurrencesOfString:@"</body></html>" withString:@""],@".jpeg"];
        [self.controller.presentingViewController setValue:attachment forKey:@"attachment"];        
    }

}



@end
