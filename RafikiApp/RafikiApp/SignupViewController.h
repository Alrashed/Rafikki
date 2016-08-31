//
//  SignupViewController.h
//  RafikiApp
//
//  Created by CI-05 on 12/24/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVSwitch.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "PersonalViewController.h"


#import "ProffesionalViewController.h"
#import "MBProgressHUD.h"
#import "VeryficationVC.h"
#import "BecomeRafikkiVC.h"
@interface SignupViewController : UIViewController
{
    
    IBOutlet UITextField *TxtUsername;
    IBOutlet UITextField *TxtEmail;
    IBOutlet UITextField *TxtPassword;
    IBOutlet UITextField *TxtPhoneNumber;
    IBOutlet UIButton *signUpButton;
    IBOutlet UIScrollView *signupScrollview;
    
    NSString *typeUserStr;
}
@property (retain, nonatomic) DVSwitch *switcher;
- (IBAction)signUpAction:(id)sender;
- (IBAction)loginAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end
