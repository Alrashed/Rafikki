//
//  ViewController.h
//  RafikiApp
//
//  Created by CI-05 on 12/24/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignupViewController.h"
#import "ExpertHomeViewController.h"
@import Firebase;
@interface ViewController : UIViewController
{
    
    IBOutlet UITextField *TxtemailAddress;
    IBOutlet UITextField *Txtpassword;
    IBOutlet UIButton *signinButton;
    IBOutlet UIButton *homeBtn;
}
@property(strong, nonatomic) FIRDatabaseReference *ref;

- (IBAction)signInAction:(id)sender;
- (IBAction)signUpAction:(id)sender;
- (IBAction)homeAction:(id)sender;
@end

