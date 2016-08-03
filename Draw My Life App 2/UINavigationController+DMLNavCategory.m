//
//  UINavigationController+DMLNavCategory.m
//  YouTube
//
//  Created by Joshua Akins on 12/2/13.
//  Copyright (c) 2013 Joshua Akins. All rights reserved.
//

#import "UINavigationController+DMLNavCategory.h"

@implementation UINavigationController (DMLNavCategory)
-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}
@end
