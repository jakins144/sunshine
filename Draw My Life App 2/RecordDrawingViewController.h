//
//  RecordDrawingViewController.h
//  Draw My Life App 2
//
//  Created by Owner on 2/21/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecordDrawingViewController : UIViewController
{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
}

@property (strong, nonatomic) UIColor *boardColor;
@property (weak, nonatomic) IBOutlet UIButton *blackMarkerButton;
@property (weak, nonatomic) IBOutlet UIButton *blueMarkerButton;
@property (weak, nonatomic) IBOutlet UIButton *cyanMarkerButton;
@property (weak, nonatomic) IBOutlet UIButton *greenMarkerButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;






@end
