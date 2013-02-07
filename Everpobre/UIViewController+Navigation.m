//
//  UIViewController+Navigation.m
//  Everpobre
//
//  Created by Javier García Gallego on 27/01/13.
//  Copyright (c) 2013 ixavy. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

-(UIViewController *)wrappedInNavigationVC{
    UINavigationController *navVC = [[UINavigationController alloc] init];
    [navVC pushViewController:self animated:NO];
    return navVC;
}

@end
