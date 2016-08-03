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

#import <ReplayKit/ReplayKit.h>

@interface RecordDrawingViewController ()

@end

@implementation RecordDrawingViewController

- (void)viewDidLoad
{
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
    
    [super viewDidLoad];
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
    
    if (screenRecorder.available) {
        [screenRecorder startRecordingWithMicrophoneEnabled:YES handler:^(NSError * _Nullable error) {
            if (error == nil) {
                NSLog(@"lets break this down");
            }
            else
            {
                NSLog(@"there was an error recording");
            }
        }];
    }
}


- (IBAction)size1Action:(id)sender {
    brush = 10.0;
}

- (IBAction)size2Action:(id)sender {
    brush = 20.0;
}

- (IBAction)size3Action:(id)sender {
    brush = 30.0;
}

- (IBAction)size4Action:(id)sender {
    brush = 40.0;
}

- (IBAction)sizePicButtonAction:(id)sender {
    
    if (self.sizePickerView.hidden) {
        [self showSizePicker];
    }
    else
        [self hideSizePicker];
    
    
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

- (BOOL)canBecomeFirstResponder
{ return YES; }


- (BOOL)shouldAutorotate
{
    return NO;
}


@end
