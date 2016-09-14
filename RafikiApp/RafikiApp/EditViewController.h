//
//  EditViewController.h
//  RafikiApp
//
//  Created by CI-05 on 1/29/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"

@interface EditViewController : UIViewController<UIActionSheetDelegate>
{
    
    IBOutlet UITextField *homeTxt;
    IBOutlet UITextField *locationTxt;
    IBOutlet UIScrollView *editScrollview;
    IBOutlet UITextField *aboutTxtview;
    IBOutlet UITextField *firstNameTxt;
    IBOutlet UITextField *lastNameTxt;
    IBOutlet UITextField *nickNameTxt;
    IBOutlet UITextField *dateOfBirthTxt;
    IBOutlet UIButton *maleButton;
    IBOutlet UIButton *femaleButton;
    IBOutlet UITextField *aboutMeTxtview;
    NSString *ganderStr;
    IBOutlet UIImageView *profilePicImageview;
    IBOutlet UIButton *editButton;
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
    
}
- (IBAction)passwordAction:(id)sender;
- (IBAction)submitAction:(id)sender;
- (IBAction)datepickerAction:(id)sender;
- (IBAction)setAction:(id)sender;
- (IBAction)cancelAction:(id)sender;


- (IBAction)dateAction:(id)sender;
- (IBAction)updateAction:(id)sender;
- (IBAction)imageButton:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)maleAction:(id)sender;
- (IBAction)femaleAction:(id)sender;
@end
