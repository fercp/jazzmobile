//
//  ItemCounterDelegate.m
//  Project Tracker
//
//  Created by Ferat Capar on 24/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemCounterDelegate.h"
#import "RestClient.h"
#import "RtcQueryList.h"

@interface ItemCounterDelegate()
@property (strong,nonatomic) NSString * projectId;
@end

@implementation ItemCounterDelegate
@synthesize projectId=_projectId;

static NSString *OPENDEFECT=@"%20and%20rtc_cm:state=%22%7Bopen%7D%22";
static NSString *OWNERDEFECT=@"%20and%20rtc_cm:ownedBy=%22%7BcurrentUser%7D%22";

bool searchingForOwnedDefects,searchingForOpenDefects;


-(void) searchCountForDefects:(NSString *) type ownedBy:(NSString *) owner{
    NSString *url=[NSString stringWithFormat:@"%@%@%@%@%@%@",@"/oslc/contexts/",self.projectId,@"/workitems.json?oslc_cm.properties=dc:identifier,dc:title&oslc_cm.query=dc:type%3D%22com.ykb.workitem.type.defect%22",type,owner,@"&oslc_cm.pageSize=1"];
   [[RestClient sharedClient] getObjectsFrom:url mapClass:[RtcQueryList class] delegate:self];
}

- (void)didLoadObjects:(NSArray*)objects {
    UILabel *label;
    RtcQueryList *itemCount=[objects objectAtIndex:0];
    if(searchingForOwnedDefects){
        label=[self.controller valueForKey:@"ownedDefectsCountLabel"];
        [self searchCountForDefects:OPENDEFECT ownedBy:@""];
        searchingForOwnedDefects=NO;
    }else if(searchingForOpenDefects){
        label=[self.controller valueForKey:@"openDefectsCountLabel"];
        [self searchCountForDefects:@"" ownedBy:@""];
        searchingForOpenDefects=NO;
    }else{
        label=[self.controller valueForKey:@"totalDefectsCountLabel"];
    }
    [label setText:[NSString stringWithFormat:@"%d",itemCount.count]];

}

-(void) countItems:(NSString *)projectId{
    searchingForOwnedDefects=YES;
    searchingForOpenDefects=YES;
    self.projectId=projectId;
   [self searchCountForDefects:OPENDEFECT ownedBy:OWNERDEFECT];
}


@end
