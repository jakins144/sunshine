//
//  TutorialTourViewController.h
//  Draw My Life App 2
//
//  Created by Owner on 8/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TutorialTourPageContentViewController.h"
#import "TutorialTourPageViewController.h"
#import "AppDelegate.h"

@interface TutorialTourViewController : UIViewController<UIPageViewControllerDataSource>
@property (strong, nonatomic)  TutorialTourPageViewController *pageViewController;
@property (strong, nonatomic)NSMutableArray *messagesArray;
@property (strong, nonatomic)NSMutableArray *mainImageTitleArray;

- (IBAction)getStartedButtonAction:(id)sender;

@end
