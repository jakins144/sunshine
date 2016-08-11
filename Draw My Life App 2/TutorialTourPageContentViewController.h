//
//  TutorialTourPageContentViewController.h
//  Draw My Life App 2
//
//  Created by Owner on 8/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialTourPageContentViewController : UIViewController
@property NSUInteger pageIndex;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageImageView;
//@property (weak, nonatomic) IBOutlet UIImageView *smallImageImageView;
@property (strong,nonatomic) NSString *labelMessageText;

@property (strong,nonatomic) NSString *mainImageTitle;

//@property (strong,nonatomic) NSString *smallImageTitle;
@end
