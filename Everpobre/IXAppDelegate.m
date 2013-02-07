//
//  IXAppDelegate.m
//  Everpobre
//
//  Created by Javier García Gallego on 26/01/13.
//  Copyright (c) 2013 ixavy. All rights reserved.
//

#import "IXAppDelegate.h"
#import "ATCoreDataStack.h"
#import <CoreData/NSEntityDescription.h>
#import <CoreData/NSManagedObject.h>
#import "Notebook.h"
#import "Note.h"
#import "IXNotebookViewController.h"
#import "UIViewController+Navigation.h"

@implementation IXAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.model = [ATCoreDataStack coreDataStackWithModelName:@"Everpobre"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Fetched request
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:[Notebook entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    
    
    // Fetched request Controller
    NSFetchedResultsController *fetched = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.model.context sectionNameKeyPath:nil cacheName:nil];
    
    // Nuestro root vc será una tabla de libretas
    
    IXNotebookViewController *nbVC = [[IXNotebookViewController alloc] initWithFetchedResultsController:fetched style:UITableViewStylePlain];
    
    self.window.rootViewController = [nbVC wrappedInNavigationVC];
    
    // Auto Save
    if (AUTO_SAVE) {
        [self performSelector:@selector(autoSave) withObject:nil afterDelay:AUTO_SAVE_DELAY];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)autoSave{
    NSLog(@"Autoguardando");
    
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"La cagamos: %@", error);
    }];
    [self performSelector:@selector(autoSave) withObject:nil afterDelay:AUTO_SAVE_DELAY];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"La cagamos! %@",error);
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
