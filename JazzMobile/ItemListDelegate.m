//
//  ItemListDelegate.m
//  Project Tracker
//
//  Created by Ferat Capar on 24/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemListDelegate.h"
#import "RestClient.h"
#import "RtcItem.h"
#import "RtcQueryList.h"

@implementation ItemListDelegate
@synthesize controller=_controller;

-(void) retriveFromUrl:(NSString *) url{
    [[RestClient sharedClient] getObjectsFrom:url delegate:self];
}

-(NSString *) getLiterelFromUrl:(NSString *) url{
    NSArray *components=[url componentsSeparatedByString:@"/"];
    return [components objectAtIndex:components.count-1];
}

- (void)didLoadObjects:(NSArray*)objects {
    NSMutableArray *defects=[[NSMutableArray alloc] init];
    RtcQueryList *queryList;
    for(NSObject *object in objects){
        if([object isMemberOfClass:[RtcItem class]])
            [defects addObject:object];
        else
            queryList=(RtcQueryList *)object;   
    }
    [self.controller setValue:queryList forKey:@"queryResult"];
    [self.controller setValue:defects forKey:@"defects"];
}

- (id)   initWithController:(UIViewController *)controller {
    self=[super init];
    self.controller=controller;
    return self; 
}
@end
