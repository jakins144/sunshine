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
    self.messagesArray = @[@"Welcome to Draw My Life App 2!  You will begin by turning your device to what orientation you want your canvas to be in which can be in Portrait or Landscape Mode. Then choose which color you want your background to be from a range of colors.", @"You can practice drawing before you start recording. Swipe the marker color bar at the top to reveal even more colors to choose from for your marker. The black circle icon at the bottom left controls the thickness of your marker.", @"Tap the red circle icon on the bottom bar to begin recording. This app uses Apple Replaykit technology to record the audio and video. You may choose to record both video and audio at the same time or only video. It is recommended that you choose record video and audio for the fullest and easiest Draw My Life experience.", @"Once you are finished, tap the black square icon at the bottom bar to stop recording. The preview screen will appear where you can review your video, save to camera roll by tapping save, or share to social media such as to Youtube by tapping the share button on the bottom left.", @"Several ways to share your Draw My Life video with your friends!", @"Enjoy! =)"].mutableCopy;
    self.mainImageTitleArray = @[@"choosebackgroundT",@"pencilthicknessT",@"realRecordT",@"previewscreenT", @"shareT", @"ytpic"].mutableCopy;
    
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


- (RecordScreenControlsViewController *)rviewControllerAtIndex:(NSUInteger)index
{
    
    
    RecordScreenControlsViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"controls"];
    //  pageContentViewController.mainImageTitle = self.mainImageTitleArray[index];
    //pageContentViewController.labelMessageText = self.messagesArray[index];
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
    if (index == [self.messagesArray count]) {
        return [self rviewControllerAtIndex:index];
    }
    else
    return [self viewControllerAtIndex:index];
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((TutorialTourPageContentViewController*) viewController).pageIndex;
    
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == [self.messagesArray count] + 1) {
        return nil;
    }
    
    
    if (index == [self.messagesArray count]) {
        return [self rviewControllerAtIndex:index];
    }
    else
    return [self viewControllerAtIndex:index];
    
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    
    return [self.messagesArray count] + 1;
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
