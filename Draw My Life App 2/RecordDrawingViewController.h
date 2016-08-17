//
//  RecordDrawingViewController.h
//  Draw My Life App 2
//
//  Created by Owner on 2/21/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReplayKit/ReplayKit.h>
#import "UINavigationController+DMLNavCategory.h"
#import <CoreMotion/CoreMotion.h>
#import "AppDelegate.h"

@interface RecordDrawingViewController : UIViewController <RPPreviewViewControllerDelegate,RPScreenRecorderDelegate, UIAccelerometerDelegate >
{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
}



- (IBAction)handelDoubleTap:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *helpButton;

@property (weak, nonatomic) IBOutlet UIView *bottomBarBackgroundView;

@property (weak, nonatomic) IBOutlet UIView *bottomBarView;
@property (weak, nonatomic) IBOutlet UIView *markerBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
- (IBAction)undoButtonAction:(id)sender;





@property (weak, nonatomic) IBOutlet UIButton *recordIndicator;

@property (weak, nonatomic) IBOutlet UIView *markerView;
@property (weak, nonatomic) IBOutlet UIScrollView *markerScrollView;
@property (strong, nonatomic) UIColor *boardColor;
@property (weak, nonatomic) IBOutlet UIButton *blackMarkerButton;
@property (weak, nonatomic) IBOutlet UIButton *blueMarkerButton;
@property (weak, nonatomic) IBOutlet UIButton *cyanMarkerButton;
@property (weak, nonatomic) IBOutlet UIButton *greenMarkerButton;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;

@property (weak, nonatomic) IBOutlet UIImage *prevImage;

@property (nonatomic, strong) NSMutableArray *stack;
@property (nonatomic, strong) NSMutableArray *pointsArray;
@property (weak, nonatomic) IBOutlet UIView *sizePickerView;
@property (weak, nonatomic) IBOutlet UIView *sizePickViewBackground;

@property (strong, nonatomic) UIWindow *window2;

- (IBAction)size1Action:(id)sender;
- (IBAction)size2Action:(id)sender;
- (IBAction)size3Action:(id)sender;
- (IBAction)size4Action:(id)sender;
- (IBAction)recordButtonAction:(id)sender;
- (IBAction)sizePicButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *recordButtonAction;

- (IBAction)clearButtonAction:(id)sender;




- (IBAction)pencilButtonAction:(UIButton *)sender;





@end
