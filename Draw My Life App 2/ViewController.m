//
//  ViewController.m
//  Draw My Life App 2
//
//  Created by Owner on 2/21/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lastDrawMyLifeButtonAction:(id)sender {
    
   // RPPreviewViewController *previewViewController = nil;
    
//    NSString *savedClassName = [[NSUserDefaults standardUserDefaults] objectForKey:@"previewViewController"];
//   
//    previewViewController = (RPPreviewViewController *)NSClassFromString(savedClassName);
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:@"pvController"];
     RPPreviewViewController *previewViewController =  [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    
    
    
    if(previewViewController != nil)
    {
        NSLog(@"preview controller not nil");
        //previewViewController.previewControllerDelegate = self;
        [self presentViewController:previewViewController animated:YES completion:nil];
    }
    
    
    
    
    
}
@end
