//
//  JMPropertySearchDelegate.m
//  JazzMobile
//
//  Created by Ferat Capar on 25.03.2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JMPropertySearchDelegate.h"
#import "RestClient.h"

@implementation JMPropertySearchDelegate


-(void) getUsers:(NSString *)searchCriteria{
    [[RestClient sharedClient] getObjectsFrom:[NSString stringWithFormat:@"%@%@%@",@"service/com.ibm.team.process.internal.common.service.IProcessRestService/contributors?sortBy=name&searchTerm=%25",searchCriteria,@"%25&searchField=name&pageSize=20&hideAdminGuest=false&hideUnassigned=true&hideArchivedUsers=true&pageNum=0"] delegate:self];
}

- (void)didLoadObjects:(NSArray*)objects {
    [self.controller setValue:objects forKey:@"searchResult"];
}

@end
