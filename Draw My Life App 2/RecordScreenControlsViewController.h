//
//  RecordScreenControlsViewController.h
//  Draw My Life App 2
//
//  Created by Owner on 8/12/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordScreenControlsViewController : UIViewController

@property NSUInteger pageIndex;
@property (weak, nonatomic) IBOutlet UIView *controlsView;
@property (weak, nonatomic) IBOutlet UIScrollView *controlsScrollView;

@end
