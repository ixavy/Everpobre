//
//  IXAppDelegate.h
//  Everpobre
//
//  Created by Javier García Gallego on 26/01/13.
//  Copyright (c) 2013 ixavy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ATCoreDataStack;

@interface IXAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)  ATCoreDataStack *model;

@end
