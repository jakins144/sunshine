//
//  RecordScreenControlsViewController.m
//  Draw My Life App 2
//
//  Created by Owner on 8/12/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "RecordScreenControlsViewController.h"

@interface RecordScreenControlsViewController ()

@end

@implementation RecordScreenControlsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.controlsScrollView.contentSize = self.controlsView.frame.size;
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
