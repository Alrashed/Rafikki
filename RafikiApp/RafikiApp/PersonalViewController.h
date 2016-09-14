//
//  PersonalViewController.h
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProffesionalViewController.h"
#import "MBProgressHUD.h"
#import "HomeViewController.h"
#import "SocialSecurityVC.h"
@import Firebase;

@interface PersonalViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    
    IBOutlet UITextField *TxtFirstName;
    IBOutlet UITextField *TxtLastName;
    IBOutlet UIButton *maleRedButton;
    IBOutlet UIButton *femaleRedButton;
    
    NSString *imageReturnString;
    UIImage *currentImage;
    IBOutlet UIImageView *userPictureImageview;
    NSString *ganderStr;
    IBOutlet UITextField *aboutMeTxt;
    IBOutlet UIButton *dateOfbirthButton;
    IBOutlet UIDatePicker *birthDatepicker;
    IBOutlet UIView *dateView;
    
    NSString *dateStr;
    IBOutlet UITextField *nickNameTxt;
    
    IBOutlet UITextField *ans1Txt;
    IBOutlet UITextField *ans2Txt;
    IBOutlet UITextField *ans3Txt;
    
    IBOutlet UIView *privacyView;
    NSString *questionString;
    NSString *answerString;
    IBOutlet UIView *genderView;
    IBOutlet UIButton *privecyButton;
    IBOutlet UIView *firstNameView;
    IBOutlet UIView *lastNameView;
    IBOutlet UITextField *petNameTxt;
    IBOutlet UITextField *birthPlaceTxt;
    IBOutlet UITextField *schoolNameTxt;
}
@property(strong, nonatomic) FIRDatabaseReference *ref;

- (IBAction)privacyAction:(id)sender;
@property(nonatomic,retain)NSString *signupFlag;
- (IBAction)nextAction:(id)sender;
- (IBAction)maleAction:(id)sender;
- (IBAction)feMaleAction:(id)sender;
- (IBAction)imageAction:(id)sender;
- (IBAction)birthDateAction:(id)sender;
- (IBAction)datepickerAction:(id)sender;
- (IBAction)setAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

- (IBAction)submitAction:(id)sender;
- (IBAction)skipAction:(id)sender;

@end
