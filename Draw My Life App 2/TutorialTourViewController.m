//
//  TutorialTourViewController.m
//  Draw My Life App 2
//
//  Created by Owner on 8/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "TutorialTourViewController.h"

@interface TutorialTourViewController ()

@end

@implementation TutorialTourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.messagesArray = @[@"Be rewarded with Notes, the Joox currency, by interacting with your favorite artists. Earn by following, promoting, listening and attending shows.", @"Win experiences by cashing in Notes or earn them by helping promote your favorite artists and their shows.", @"Show your loyalty by helping your artists and be rewarded with unique and individualized rewards.", @"Check-In to shows: Let everyone know you are there and earn chances to get on the spot upgrades, like backstage passes."].mutableCopy;
    self.mainImageTitleArray = @[@"choosebackgroundT",@"pencilthicknessT",@"realRecordT",@"previewscreenT"].mutableCopy;
    
    //self.smallImageTitleArray = @[@"smalltutpic1",@"smalltutpic1",@"smalltutpic3",@"smalltutpic4"].mutableCopy;
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutPageViewController"];
    self.pageViewController.dataSource = self;
    
    TutorialTourPageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (TutorialTourPageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.messagesArray count] == 0) || (index >= [self.messagesArray count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    TutorialTourPageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutPageContentViewController"];
    pageContentViewController.mainImageTitle = self.mainImageTitleArray[index];
    pageContentViewController.labelMessageText = self.messagesArray[index];
  //  pageContentViewController.smallImageTitle = self.smallImageTitleArray[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((TutorialTourPageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((TutorialTourPageContentViewController*) viewController).pageIndex;
    
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == [self.messagesArray count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    
    return [self.messagesArray count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)getStartedButtonAction:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"Start Button Pressed" forKey:@"Closed_Tutorial"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
   // [[AppDelegate sharedDelegate] showMainScreen];
    
}
@end
