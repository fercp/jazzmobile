//
//  HttpUtil.m
//  Project Tracker
//
//  Created by Ferat Capar on 31/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectListDelegate.h"
#import "Project.h"
#import "RestClient.h"

@implementation ProjectListDelegate


- (void) getProjects {  
    [[RestClient sharedClient] getObjectsFrom:@"/oslc/workitems/catalog" delegate:self];
}  

- (void)didLoadObjects:(NSArray*)objects {
    NSDictionary *projects=[[NSMutableDictionary alloc] init];
    for (Project *project in objects) {
        NSArray *urlItems=[project.projectId componentsSeparatedByString:@"/"];
        [project setProjectId:[urlItems objectAtIndex:6]];
        [projects setValue:project.projectName forKey:project.projectId];
    }
    [self.controller setValue:projects forKey:@"projects"];
     
}

@end
