//
//  Mapper.m
//  Project Tracker
//
//  Created by Ferat Capar on 23/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Mapper.h"
#import <RestKit/RestKit.h>
#import "Project.h"
#import "RtcEnumeration.h"
#import "RtcItem.h"
#import "RtcQueryList.h"
#import "User.h"
#import "Comment.h"
#import "ItemHistory.h"
#import "JMError.h"
#import "JMSearchResult.h"
#import "JMWorkItemModifier.h"
#import "JMResourceRepresentation.h"
#import "JMLink.h"


@implementation Mapper

static NSDictionary *mappings;

+(NSDictionary*) mappings{
    return mappings;
}

+(void) initMappings{
    mappings=[[NSMutableDictionary alloc] init];
    
    //Project
    RKObjectMapping *projectMapping = [RKObjectMapping mappingForClass:[Project class]];
    [projectMapping addAttributeMappingsFromDictionary:@{@"title": @"projectName",@"resource":@"projectId"}];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:projectMapping pathPattern:nil keyPath:@"ServiceProviderCatalog.entry.ServiceProvider" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    [mappings setValue:projectMapping forKey:NSStringFromClass([Project class])];
    
    //RtcEnumeration
    RKObjectMapping *enumMapping = [RKObjectMapping mappingForClass:[RtcEnumeration class]];
    [projectMapping addAttributeMappingsFromDictionary:@{@"dc:identifier":@"identifier",@"dc:title":@"title",
     @"rtc_cm:iconUrl":@"iconUrl",@"rdf:resource":@"resource",@"rtc_cm:resultState.dc:title":@"extraInfo"}];
    [mappings setValue:enumMapping forKey:NSStringFromClass([RtcEnumeration class])];
    [[RKObjectManager sharedManager] setAcceptHeaderWithMIMEType:@"application/json"];
    
    
    //User
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[User class]];
    [userMapping addAttributeMappingsFromDictionary:@{@"rtc_cm:userId":@"userId",
     @"rtc_cm:emailAddress":@"email",@"dc:title":@"title",@"rdf:resource":@"resource"}];
    [mappings setValue:userMapping forKey:NSStringFromClass([User class])];
    
    //Comment
    RKObjectMapping *commentMapping = [RKObjectMapping mappingForClass:[Comment class]];
    [commentMapping addAttributeMappingsFromDictionary:@{@"dc:description":@"description",@"dc:created":@"creationDate"}];
    [commentMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"dc:creator"
                                                                                   toKeyPath:@"creator"
                                                                                 withMapping:userMapping]];
    [mappings setValue:commentMapping forKey:NSStringFromClass([Comment class])];
   /* RKObjectMapping* commentSerializationMapping = [commentMapping inverseMapping];
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:commentSerializationMapping forClass:[Comment class] ];
    */
   
    //JMLink
    RKObjectMapping *linkMapping = [RKObjectMapping mappingForClass:[JMLink class]];
    [linkMapping addAttributeMappingsFromDictionary:@{@"dc:title":@"title",@"dc:created":@"creationDate",
     @"dc:creator.dc:title":@"creator",
     @"dc:format":@"format",@"dc:identifier":@"identifier",
     @"rdf:resource":@"resource",@"oslc_cm:label":@"label"}];
    
    
    //RtcItem
    RKObjectMapping *itemMapping = [RKObjectMapping mappingForClass:[RtcItem class]];
    [itemMapping addAttributeMappingsFromDictionary:@{
@"dc:identifier":@"identifier",@"dc:title":@"title",@"dc:created":@"creationDate",@"rtc_cm:due":@"dueDate"}];
    [itemMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"oslc_cm:severity" toKeyPath:@"severity"withMapping:enumMapping]];
    [itemMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"oslc_cm:priority" toKeyPath:@"priority"withMapping:enumMapping]];
    [itemMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rtc_cm:state"
        toKeyPath:@"state"withMapping:enumMapping]];
    [itemMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rtc_cm:ownedBy" toKeyPath:@"owner"withMapping:userMapping]];
    [itemMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"dc:creator" toKeyPath:@"creator"withMapping:userMapping]];
    [itemMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"dc:type" toKeyPath:@"type"withMapping:enumMapping]];
    [itemMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rtc_cm:comments" toKeyPath:@"comments"withMapping:commentMapping]];
    [itemMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rtc_cm:com.ibm.team.workitem.linktype.attachment.attachment" toKeyPath:@"attachedLinks"withMapping:linkMapping]];
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:itemMapping pathPattern:nil keyPath:@"oslc_cm:results" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    [mappings setValue:itemMapping forKey:NSStringFromClass([RtcItem class])];
    
    //JMError
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[JMError class]];
    [errorMapping addAttributeMappingsFromDictionary:@{@"message":@"message",@"status":@"status"}];
    [mappings setValue:errorMapping forKey:NSStringFromClass([JMError class])];
    
    //RtcQueryList
    RKObjectMapping *queryMapping = [RKObjectMapping mappingForClass:[RtcQueryList class]];
    [queryMapping addAttributeMappingsFromDictionary:@{
         @"oslc_cm:next":@"url",@"oslc_cm:totalCount":@"count",@"message":@"message",@"status":@"status"}];
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:queryMapping pathPattern:nil keyPath:@"" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];    
    [mappings setValue:queryMapping forKey:NSStringFromClass([RtcQueryList class])];
    
    //ItemHistory
    RKObjectMapping *itemHistoryMapping = [RKObjectMapping mappingForClass:[ItemHistory class]];
    [itemHistoryMapping addAttributeMappingsFromDictionary:@{
     @"modifiedDate":@"modificationDate",@"modifiedBy.name":@"modifier",@"content":@"content"}];
    [mappings setValue:itemHistoryMapping forKey:NSStringFromClass([ItemHistory class])];
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:itemHistoryMapping pathPattern:nil keyPath:@"Envelope.Body.response.returnValue.value.changes" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
   
    //SearchResult
    RKObjectMapping *searchResultMapping = [RKObjectMapping mappingForClass:[JMSearchResult class]];
    [searchResultMapping addAttributeMappingsFromDictionary:@{
     @"itemId":@"resource",@"name":@"title"}];
    [mappings setValue:searchResultMapping forKey:NSStringFromClass([JMSearchResult class])];
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:searchResultMapping pathPattern:nil keyPath:@"Envelope.Body.response.returnValue.value.elements" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    
    //UpdateMapping
    RKObjectMapping* resourceMapping = [RKObjectMapping mappingForClass:[JMResourceRepresentation class] ];
    [resourceMapping addAttributeMappingsFromDictionary:@{@"rdf:resource":@"value"}];
    
    RKObjectMapping* updateMapping = [RKObjectMapping mappingForClass:[JMWorkItemModifier class] ];
    [updateMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rtc_cm:ownedBy" toKeyPath:@"owner" withMapping:resourceMapping]];
    [updateMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"oslc_cm:severity" toKeyPath:@"severity" withMapping:resourceMapping]];
    [updateMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"oslc_cm:priority" toKeyPath:@"priority" withMapping:resourceMapping]];
    [updateMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"rtc_cm:com.ibm.team.workitem.linktype.attachment.attachment" toKeyPath:@"attachedLinks" withMapping:resourceMapping]];
    [updateMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"_action" toKeyPath:@"state" withMapping:resourceMapping]];

 /*   RKObjectMapping* updateSerializationMapping = [updateMapping inverseMapping];
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:updateSerializationMapping forClass:[JMWorkItemModifier class] ]; 
    [mappings setValue:updateSerializationMapping forKey:NSStringFromClass([JMWorkItemModifier class])];
   */ 
  
}
@end
