//
//  RecordDrawingViewController.m


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
    
    
    [super viewDidLoad];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doDoubleTap)] ;
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
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
    
    self.prevImage = self.tempImageView.image;
    
}

- (void)setImage:(UIImage*)currentImage fromImage:(UIImage*)preImage
{
    // Prepare undo-redo
    [[self.undoManager prepareWithInvocationTarget:self] setImage:preImage fromImage:currentImage];
    self.mainImageView.image = currentImage;
    self.tempImageView.image = currentImage;
    self.prevImage = currentImage;
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
     UIImage *currentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
   
    [self setImage:currentImage fromImage:self.prevImage];
}

//http://code.tutsplus.com/tutorials/ios-9-an-introduction-to-replaykit--cms-25458
-(void)startRecording
{
    RPScreenRecorder *screenRecorder = [RPScreenRecorder sharedRecorder];
    screenRecorder.delegate = self;
    
    if (screenRecorder.available) {
       // [self stopUpdates];
        self.helpButton.enabled = false;
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
            self.helpButton.enabled = YES;
            [self.recordButton setBackgroundImage:[UIImage imageNamed:@"redcircle2.png"] forState:UIControlStateNormal];
        
            if (previewViewController != nil)
            {
                [self stopUpdates];
                previewViewController.previewControllerDelegate = self;
                
                if ( [previewViewController respondsToSelector:@selector(popoverPresentationController)] ) {
                    // iOS8
                    previewViewController.popoverPresentationController.sourceView =
                    self.view;
                }
                

                [self presentViewController:previewViewController animated:YES completion:nil];
       
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
    
    [self clearAll];
   
}

-(void)clearAll
{
    while ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

-(void)undoAction
{
    if ([self.undoManager canUndo]) {
        [self.undoManager undo];
    }
}

-(void)redoAction
{
    if ([self.undoManager canRedo]) {
        [self.undoManager redo];
    }
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
        [self clearAll];
    }
    
        [super motionEnded:motion withEvent:event];
}



- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController
{
    
    [self startUpdatesWithSliderValue:15];
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
            
            if (deviceMotion.attitude.roll <= -3 && downMotionTriggered == NO) {
                [self toggleRecording];
                downMotionTriggered = YES;
                
            }
            
            if (deviceMotion.attitude.roll >= 0.9 && downMotionTriggered == YES) {
                downMotionTriggered = NO;
            }
            
        }];
    }

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
    self.helpButton.enabled = YES;
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
    
    if (isBarsHidden == NO) {
        self.markerView.hidden = YES;
        self.markerBackgroundView.hidden = YES;
        
        self.bottomBarView.hidden = YES;
        self.bottomBarBackgroundView.hidden = YES;
        [self hideSizePicker];
        isBarsHidden = YES;
    }
    else
    {
        self.markerView.hidden = NO;
        self.markerBackgroundView.hidden = NO;
        
        self.bottomBarView.hidden = NO;
        self.bottomBarBackgroundView.hidden = NO;
        isBarsHidden = NO;
    }
    
  
}


- (IBAction)undoButtonAction:(id)sender {
    [self undoAction];
}
@end
