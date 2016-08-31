//
//  ExpertEditVC.h
//  RafikiApp
//
//  Created by CI-05 on 2/19/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking/AFNetworking.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "MBProgressHUD.h"
#import "AddCatViewController.h"

#import "SocialSecurityVC.h"
#import "PhotoIdVC.h"
#import "EditShowSkill.h"
@interface ExpertEditVC : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    IBOutlet UIScrollView *editScrollview;
    IBOutlet UITextField *aboutTxtview;
    IBOutlet UITextField *firstNameTxt;
    IBOutlet UITextField *lastNameTxt;
    IBOutlet UITextField *nickNameTxt;
    IBOutlet UITextField *dateOfBirthTxt;
    IBOutlet UIButton *maleButton;
    IBOutlet UIButton *femaleButton;
    NSString *ganderStr;
    IBOutlet UIImageView *profilePicImageview;
    UIImage *currentImage;
    IBOutlet UIView *dateView;
    IBOutlet UIDatePicker *datePicker;
    NSString *dateStr;
    NSString *imageStr;
    IBOutlet UIView *aboutView;
    IBOutlet UIButton *passwordButton;
    IBOutlet UIView *PassWordView;
    IBOutlet UITextField *oldPasswordTxt;
    IBOutlet UITextField *newPasswordTxt;
    IBOutlet UITextField *confirmPasswordTxt;
    IBOutlet UIButton *submitButton;
    NSString *oldPasswordStr;
    
    IBOutlet UITextField *homeTxt;
    IBOutlet UITextField *locationTxt;
    IBOutlet UITextField *sessionTxt;
    IBOutlet UITextField *agesTxt;
    IBOutlet UITextField *mustHavesTxt;
    IBOutlet UITextField *costTxt;
    
    IBOutlet UIButton *editCatButton;
    
    IBOutlet UITextField *expirianceTxt;
    IBOutlet UITextField *qualificationTxt;
    IBOutlet UITextField *designationTxt;
    IBOutlet UITextField *rateTxt;
    
    
    IBOutlet UIButton *editSkillButton;
    
}
- (IBAction)editSkillButtonAction:(id)sender;
- (IBAction)editPhotoIdAction:(id)sender;
- (IBAction)editSocialInfoAction:(id)sender;
- (IBAction)editCatAction:(id)sender;
- (IBAction)imageButtonAction:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)maleAction:(id)sender;
- (IBAction)femaleAction:(id)sender;
- (IBAction)passwordAction:(id)sender;
- (IBAction)dateOfBirthAction:(id)sender;
- (IBAction)doneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)setAction:(id)sender;
- (IBAction)submitAction:(id)sender;
@end
