//
//  AboutJobViewController.h
//  RafikiApp
//
//  Created by CI-05 on 1/6/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVSwitch.h"
#import "MBProgressHUD.h"
#import "UUDatePicker.h"
#import "IQKeyboardManager.h"
#import "HomeViewController.h"

#import "SelectAndAddPaymentVC.h"
@interface AboutJobViewController : UIViewController<UIAlertViewDelegate,UUDatePickerDelegate>
{
    
    IBOutlet UIView *priceview;
    IBOutlet UITextField *priceTxt;
    IBOutlet UITextView *jobDetailTxtview;
    IBOutlet UIButton *inviteBtn;
    NSString *priceSwitchText;
    IBOutlet UIView *dateView;
    IBOutlet UIButton *setScheduleButton;
    
    NSString *dateAndTimeStr;
    IBOutlet UITextField *locationTxt;
    
    IBOutlet UITableView *skillTbl;
    IBOutlet UIButton *selectLocButton;
    IBOutlet UITextView *addSpecialInsTxtview;
    IBOutlet UIScrollView *skillScrollview;
    
    int x ,y;
    IBOutlet UIScrollView *mainScrollView;
    IBOutlet UIView *locationPopview;
    IBOutlet UITableView *locationTbl;
    NSMutableArray *locationArray;
    IBOutlet UIButton *nowButton;
    
    NSMutableArray *selectSkillArray;
    
    NSString *skillIDStr;
}
@property(nonatomic,retain)NSMutableArray *expertDetailArray;
- (IBAction)homeAction:(id)sender;

- (IBAction)nowAction:(id)sender;
- (IBAction)selectLocAction:(id)sender;
- (IBAction)doneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
@property (retain, nonatomic) DVSwitch *switcher;
@property(retain,nonatomic)NSString *expertIdStr;
- (IBAction)backAction:(id)sender;
- (IBAction)inviteAction:(id)sender;
- (IBAction)setScheduleAction:(id)sender;
@end
