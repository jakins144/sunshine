//
//  ViewController.h
//  Draw My Life App 2
//
//  Created by Owner on 2/21/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReplayKit/ReplayKit.h>
#import "TutorialTourViewController.h"
@import MessageUI;

@interface ViewController : UIViewController<RPPreviewViewControllerDelegate,MFMailComposeViewControllerDelegate>
- (IBAction)lastDrawMyLifeButtonAction:(id)sender;

- (IBAction)feedbackButtonAction:(id)sender;


@end

