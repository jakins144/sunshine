//
//  TutorialTourPageContentViewController.m
//  Draw My Life App 2
//
//  Created by Owner on 8/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "TutorialTourPageContentViewController.h"

@interface TutorialTourPageContentViewController ()

@end

@implementation TutorialTourPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.messageLabel.text = self.labelMessageText;
    //  [self.view setNeedsLayout];
    
    //  UIImage *thatImage = [UIImage imageNamed:self.mainImageTitle];
    
    self.mainImageImageView.image = [UIImage imageNamed:self.mainImageTitle];
    
  //  self.smallImageImageView.image = [UIImage imageNamed:self.smallImageTitle];
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
