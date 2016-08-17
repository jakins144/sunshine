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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //UIViewController *vc = nil;
    
    if (![defaults objectForKey:@"Closed_Tutorial"])
    {
        [self performSegueWithIdentifier:@"toTutorial" sender:self];
        
      //  vc = [[UIStoryboard storyboardWithName:JXStoryboardNameLogin bundle:nil] instantiateViewControllerWithIdentifier:@"JXTutorialTourViewController"];
        //  [defaults setObject:@"Guitar Sound" forKey:@"BoardSoundName"];
        //   [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)lastDrawMyLifeButtonAction:(id)sender {
//    
//   // RPPreviewViewController *previewViewController = nil;
//    
////    NSString *savedClassName = [[NSUserDefaults standardUserDefaults] objectForKey:@"previewViewController"];
////   
////    previewViewController = (RPPreviewViewController *)NSClassFromString(savedClassName);
//    
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSData *encodedObject = [defaults objectForKey:@"pvController"];
//     RPPreviewViewController *previewViewController =  [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
//    
//    
//    
//    if(previewViewController != nil)
//    {
//        NSLog(@"preview controller not nil");
//        //previewViewController.previewControllerDelegate = self;
//        [self presentViewController:previewViewController animated:YES completion:nil];
//    }
//    
//    
//}

-(void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (IBAction)feedbackButtonAction:(id)sender {
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Feedback!"
                                 message:@"Would you like to email your feedback directly to the developer?"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes, please"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    
                                    if (![MFMailComposeViewController canSendMail]) {
                                        NSLog(@"Mail services are not available.");
                                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Mail services are not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                        [alertView show];
                                    }
                                    else
                                    {
                                        
                                        
                                        MFMailComposeViewController* composeVC = [[MFMailComposeViewController alloc] init];
                                        composeVC.mailComposeDelegate = self;
                                        
                                        // Configure the fields of the interface.
                                        [composeVC setToRecipients:@[@"drawmylifeapp@mail.com"]];
                                        [composeVC setSubject:@"Feedback!"];
                                        [composeVC setMessageBody:@"Hello here is my feedback!" isHTML:NO];
                                        
                                        // Present the view controller modally.
                                        [self presentViewController:composeVC animated:YES completion:nil];

                                        
                                    }

                                    
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No, thanks"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle no, thanks button
                               }];
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}


- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    // Check the result or perform other tasks.
    
    // Dismiss the mail compose view controller.
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
