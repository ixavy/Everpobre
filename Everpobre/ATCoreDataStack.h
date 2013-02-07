//
//  ATCoreDataStack.h
//
//  Created by Fernando Rodríguez Romero on 1/24/13.
//  Copyright (c) 2013 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NSManagedObjectContext;

@interface ATCoreDataStack : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *context;

+(NSString *) persistentStoreCoordinatorErrorNotificationName;

+(ATCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                               databaseFilename:(NSString*) aDBName;

+(ATCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName;

+(ATCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                                    databaseURL:(NSURL*) aDBURL;

-(id) initWithModelName:(NSString *)aModelName
            databaseURL:(NSURL*) aDBURL;

-(void) zapAllData;

-(void) saveWithErrorBlock: (void(^)(NSError *error))errorBlock;

@end
