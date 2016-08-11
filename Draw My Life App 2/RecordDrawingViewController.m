//
//  RecordDrawingViewController.m
//  Draw My Life App 2
//
//  Created by Owner on 2/21/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//
//TO DO ADD PENCIL RESIZING FUNCTIONALITY
//TO DO ADD MARKER CHOOSER BAR HORIZONTAL SCROLLING
//TO DO LOOK AT WHAT ELSE OLD APP HAD
//TO DO ADD SCREEN RECORDING
//TO DO
//TO DO
//TO DO

enum {
    BLACK = 1000,
    BLUE,
    RED ,
    GREEN,
    PURPLE,
    ORANGE,
    MAGENTA,
    BROWN,
    CYAN,
    YELLOW,
    WHITE
    
};

///////// Put in drawing code
#import "RecordDrawingViewController.h"

const NSUInteger BAR_ANIMATION_LENGTH = 200;

@interface RecordDrawingViewController ()
{
    BOOL downMotionTriggered;
    BOOL isBarsHidden;
}

@end

@implementation RecordDrawingViewController

- (void)viewDidLoad
{
    
    
  //  self.recordIndicator.hidden = YES;
   
    
    
    [super viewDidLoad];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doDoubleTap)] ;
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
   // [singleTap requireGestureRecognizerToFail:doubleTap];
    
    isBarsHidden = NO;
    
    self.sizePickViewBackground.hidden = YES;
    self.sizePickerView.hidden = YES;
    
    
    self.markerScrollView.contentSize = self.markerView.frame.size;
    self.mainImageView.backgroundColor = self.boardColor;
    
    red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
    brush = 10.0;
    opacity = 1.0;
    
    NSInteger myNumber = WHITE;
    
    NSLog(@"%ld", (long)myNumber);
    
    self.recordIndicator.hidden = YES;
    
    
    downMotionTriggered = NO;
    
    isBarsHidden = NO;
    
    
    
//    self.window2 = [[UIWindow alloc] initWithFrame:self.view.frame];
//    
//    [self.window2.rootViewController.view addSubview:self.recordIndicator];
//    [self.window2 setMultipleTouchEnabled:YES];
//    
//    [self.window2 makeKeyAndVisible];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    [self startUpdatesWithSliderValue:15];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (IBAction)eraserPressed:(id)sender {
    
    red = 255.0/255.0;
    green = 255.0/255.0;
    blue = 255.0/255.0;
    opacity = 1.0;
}

- (IBAction)reset:(id)sender {
    
    self.mainImageView.image = nil;
    
}

- (IBAction)settings:(id)sender {
}

- (IBAction)save:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
                                                             delegate:self
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save to Camera Roll", @"Tweet it!", @"Cancel", nil];
    [actionSheet showInView:self.view];
}

//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1)
//    {
//        Class tweeterClass = NSClassFromString(@"TWTweetComposeViewController");
//        
//        if(tweeterClass != nil) {   // check for Twitter integration
//            
//            // check Twitter accessibility and at least one account is setup
//            if([TWTweetComposeViewController canSendTweet]) {
//                
//                UIGraphicsBeginImageContextWithOptions(self.mainImage.bounds.size, NO,0.0);
//                [self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
//                UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
//                UIGraphicsEndImageContext();
//                
//                TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
//                // set initial text
//                [tweetViewController setInitialText:@"Check out this drawing I made from a tutorial on raywenderlich.com:"];
//                
//                // add image
//                [tweetViewController addImage:SaveImage];
//                tweetViewController.completionHandler = ^(TWTweetComposeViewControllerResult result) {
//                    if(result == TWTweetComposeViewControllerResultDone) {
//                        // the user finished composing a tweet
//                    } else if(result == TWTweetComposeViewControllerResultCancelled) {
//                        // the user cancelled composing a tweet
//                    }
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                };
//                
//                [self presentViewController:tweetViewController animated:YES completion:nil];
//            } else {
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You can't send a tweet right now, make sure you have at least one Twitter account setup and your device is using iOS5" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                [alertView show];
//            }
//        } else {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You must upgrade to iOS5.0 in order to send tweets from this application" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alertView show];
//        }
//        
//    } else if(buttonIndex == 0) {
//        
//        UIGraphicsBeginImageContextWithOptions(self.mainImage.bounds.size, NO, 0.0);
//        [self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
//        UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
//    }
//}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempImageView setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImageView.frame.size);
    [self.mainImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempImageView.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:opacity];
    self.mainImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempImageView.image = nil;
    UIGraphicsEndImageContext();
}

//http://code.tutsplus.com/tutorials/ios-9-an-introduction-to-replaykit--cms-25458
-(void)startRecording
{
    RPScreenRecorder *screenRecorder = [RPScreenRecorder sharedRecorder];
    screenRecorder.delegate = self;
    
    if (screenRecorder.available) {
       // [self stopUpdates];
        
        [self.recordButton setBackgroundImage:[UIImage imageNamed:@"stop-512-sm.png"] forState:UIControlStateNormal];
        [[self navigationController] setNavigationBarHidden:YES animated:YES];
        [screenRecorder startRecordingWithMicrophoneEnabled:YES handler:^(NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"lets break this down");
              //  self.recordIndicator.hidden = NO;
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recording error"
                                                                message:error.description
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recording unavailable"
                                                        message:@"Please make sure that your device supports Replay Kit and that AirPlay and TV-Out is not in use."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


-(void)stopRecording
{
    
    RPScreenRecorder *screenRecorder = [RPScreenRecorder sharedRecorder];
    if (screenRecorder.available) {
        [screenRecorder stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
            [[self navigationController] setNavigationBarHidden:NO animated:YES];
            self.recordIndicator.hidden = YES;
            [self.recordButton setBackgroundImage:[UIImage imageNamed:@"redcircle2.png"] forState:UIControlStateNormal];
        
            if (previewViewController != nil)
            {
                previewViewController.previewControllerDelegate = self;
                [self presentViewController:previewViewController animated:YES completion:nil];
                
                NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:previewViewController];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:encodedObject forKey:@"pvController"];
                [defaults synchronize];
            }
        }];
    }
    
    
}
- (IBAction)size1Action:(id)sender {
    brush = 10.0;
    [self hideSizePicker];
}

- (IBAction)size2Action:(id)sender {
    brush = 20.0;
    [self hideSizePicker];
}

- (IBAction)size3Action:(id)sender {
    brush = 30.0;
    [self hideSizePicker];
}

- (IBAction)size4Action:(id)sender {
    brush = 40.0;
    [self hideSizePicker];
}

- (IBAction)recordButtonAction:(id)sender {
    [self toggleRecording];
}

-(void)toggleRecording
{
    RPScreenRecorder *screenRecorder = [RPScreenRecorder sharedRecorder];
    if (!screenRecorder.isRecording) {
        [self startRecording];
    }
    else
        [self stopRecording];
}

- (IBAction)sizePicButtonAction:(id)sender {
    
    if (self.sizePickerView.hidden) {
        [self showSizePicker];
    }
    else
        [self hideSizePicker];
    
    
}

- (IBAction)clearButtonAction:(id)sender {
    
    self.mainImageView.image = nil;
    
}

- (IBAction)pencilButtonAction:(UIButton *)sender {
    UIButton *colorButton  = sender;
    
    switch (colorButton.tag) {
        case BLACK:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            break;
        case BLUE:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            break;
        case RED:
            red = 255.0/255.0;
            green = 0/255.0;
            blue = 0.0/255.0;
            break;
        case GREEN:
            red = 0.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            
            break;
        case PURPLE:
            red = 127.0/255.0;
            green = 0.0/255.0;
            blue = 127.0/255.0;
            break;
        case ORANGE:
            red = 255.0/255.0;
            green = 127.0/255.0;
            blue = 0.0/255.0;
            break;
        case MAGENTA:
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            
            break;
        case BROWN:
            red = 153.0/255.0;
            green = 102.0/255.0;
            blue = 51.0/255.0;
            
            break;
        case CYAN:
            red = 0.0/255.0;
            green = 255.0/255.0;
            blue = 255.0/255.0;
            
            break;
        case YELLOW:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            break;
        case WHITE:
            red = 255.0/255.0;
            green = 255.0/255.0;
            blue = 255.0/255.0;
            break;
            
        default:
            break;
    }
}

-(void)showSizePicker
{
    
    self.sizePickViewBackground.alpha = 0.5;
    self.sizePickerView.alpha = 1.0;
    
    self.sizePickViewBackground.hidden = NO;
    self.sizePickerView.hidden = NO;
    
    
   
}

-(void)hideSizePicker
{
   
    [UIView animateWithDuration:0.45 animations:^{self.sizePickerView.alpha = 0.0;}completion:^(BOOL finished) {
        
        //fade out
        self.sizePickerView.hidden = YES;
        
    }];
    
    [UIView animateWithDuration:0.45 animations:^{self.sizePickViewBackground.alpha = 0.0;}completion:^(BOOL finished) {
        
        //fade out
        self.sizePickViewBackground.hidden = YES;
        
    }];

    
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        // Put in code here to handle shake
        self.mainImageView.image = nil;
    }
    
    //if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}



- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController
{
    
    
    [previewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- Acceleration Start and Stop ----------------------------

- (void)startUpdatesWithSliderValue:(int)sliderValue {
    
    NSTimeInterval deviceMotionMin = 0.01;
    NSTimeInterval delta = 0.005;
    NSTimeInterval updateInterval = deviceMotionMin + delta * sliderValue;
    
    CMMotionManager *mManager = [(AppDelegate *)[[UIApplication sharedApplication] delegate] sharedManager];
    
    
    if ([mManager isDeviceMotionAvailable] == YES) {
        [mManager setDeviceMotionUpdateInterval:updateInterval];
        [mManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *deviceMotion, NSError *error) {
            // attitude
            // [[weakSelf.graphViews objectAtIndex:kDeviceMotionGraphTypeAttitude] addX:deviceMotion.attitude.roll y:deviceMotion.attitude.pitch z:deviceMotion.attitude.yaw];
            //            //rotationRate
            //            [[weakSelf.graphViews objectAtIndex:kDeviceMotionGraphTypeRotationRate] addX:deviceMotion.rotationRate.x y:deviceMotion.rotationRate.y z:deviceMotion.rotationRate.z];
            //            // gravity
            //            [[weakSelf.graphViews objectAtIndex:kDeviceMotionGraphTypeGravity] addX:deviceMotion.gravity.x y:deviceMotion.gravity.y z:deviceMotion.gravity.z];
            //            // userAcceleration
            //            [[weakSelf.graphViews objectAtIndex:kDeviceMotionGraphTypeUserAcceleration] addX:deviceMotion.userAcceleration.x y:deviceMotion.userAcceleration.y z:deviceMotion.userAcceleration.z];
            // NSLog(@"roll is: %f", deviceMotion.attitude.roll);
            
            if (deviceMotion.attitude.roll <= -3 && downMotionTriggered == NO) {
                [self toggleRecording];
                downMotionTriggered = YES;
                
            }
            
            if (deviceMotion.attitude.roll >= 0.9 && downMotionTriggered == YES) {
                downMotionTriggered = NO;
            }
            
        }];
    }
    
    //    self.graphLabel.text = [self.graphTitles objectAtIndex:[self.segmentedControl selectedSegmentIndex]];
    //    self.updateIntervalLabel.text = [NSString stringWithFormat:@"%f", updateInterval];
}

- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}

- (void)stopUpdates {
    
    CMMotionManager *mManager = [(AppDelegate *)[[UIApplication sharedApplication] delegate] sharedManager];
    
    if ([mManager isDeviceMotionActive] == YES) {
        
        [mManager stopDeviceMotionUpdates];
        
    }
    
}


- (void)screenRecorder:(RPScreenRecorder *)screenRecorder
didStopRecordingWithError:(NSError *)error
 previewViewController:(RPPreviewViewController *)previewViewController
{
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recording stopped due to error"
                                                        message:error.description
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    [self.recordButton setBackgroundImage:[UIImage imageNamed:@"redcircle2.png"] forState:UIControlStateNormal];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.recordIndicator.hidden = YES;
}

- (BOOL)canBecomeFirstResponder
{ return YES; }


- (BOOL)shouldAutorotate
{
    return NO;
}


- (void)doDoubleTap
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         if (isBarsHidden == NO) {
                             [self hideSizePicker];
                             self.markerView.center = CGPointMake(self.markerView.center.x, self.markerView.center.y - BAR_ANIMATION_LENGTH);
                             self.markerBackgroundView.center = CGPointMake(self.markerBackgroundView.center.x, self.markerBackgroundView.center.y - BAR_ANIMATION_LENGTH);
                             
                             
                             
                             self.bottomBarView.center = CGPointMake(self.bottomBarView.center.x, self.bottomBarView.center.y + BAR_ANIMATION_LENGTH);
                             self.bottomBarBackgroundView.center = CGPointMake(self.bottomBarBackgroundView.center.x, self.bottomBarBackgroundView.center.y + BAR_ANIMATION_LENGTH);
                             isBarsHidden = YES;
                             [self hideSizePicker];
                             
                         }
                         else
                         {
                             self.markerView.center = CGPointMake(self.markerView.center.x, self.markerView.center.y + BAR_ANIMATION_LENGTH);
                             self.markerBackgroundView.center = CGPointMake(self.markerBackgroundView.center.x, self.markerBackgroundView.center.y + BAR_ANIMATION_LENGTH);
                             
                             
                             self.bottomBarView.center = CGPointMake(self.bottomBarView.center.x, self.bottomBarView.center.y - BAR_ANIMATION_LENGTH);
                             self.bottomBarBackgroundView.center = CGPointMake(self.bottomBarBackgroundView.center.x, self.bottomBarBackgroundView.center.y - BAR_ANIMATION_LENGTH);
                             isBarsHidden = NO;
                         }
                         
                         
                         
                     }];
}


@end
