//
//  ExpertSignupVC.h
//  RafikiApp
//
//  Created by CI-05 on 4/21/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFNetworking/AFNetworking.h"
#import "VeryficationVC.h"
@import Firebase;
@interface ExpertSignupVC : UIViewController
{
    IBOutlet UITextField *TxtUsername;
    IBOutlet UITextField *TxtEmail;
    IBOutlet UITextField *TxtPassword;
    IBOutlet UITextField *TxtPhoneNumber;
    IBOutlet UIButton *signUpButton;
    IBOutlet UIScrollView *signupScrollview;
    NSString *typeUserStr;
}
@property(strong, nonatomic) FIRDatabaseReference *ref;
- (IBAction)signUpAction:(id)sender;
- (IBAction)backAction:(id)sender;
@end
