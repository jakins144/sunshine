//
//  TutorialTourPageViewController.m
//  Draw My Life App 2
//
//  Created by Owner on 8/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "TutorialTourPageViewController.h"

@interface TutorialTourPageViewController ()

@end

@implementation TutorialTourPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPageControl *pageControl = [UIPageControl appearance];
     pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
