//
//  ProfileViewController.h
//  RafikiApp
//
//  Created by CI-05 on 12/29/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVSwitch.h"
#import "BasicInfoTableViewCell.h"
#import "jobHistoryTableViewCell.h"

#import "MBProgressHUD.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "CommonShowJobView.h"
#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "ChatViewController.h"
#import "ExpertEditVC.h"

#import "AvibilityCell.h"
@interface ProfileViewController : UIViewController<UIActionSheetDelegate>
{
    IBOutlet UIImageView *userImageView;
    IBOutlet UILabel *titleLbl;
    IBOutlet UILabel *designationLbl;
    IBOutlet UILabel *activeLbl;
    
    IBOutlet UITableView *profileTbl;
    NSMutableArray *infoiconImage;
    NSString *TblValue;
    NSMutableArray *expertAllArray;
    IBOutlet UIButton *back;
    IBOutlet UIButton *messageButton;
    IBOutlet UIButton *inviteButton;
    IBOutlet UIView *loginPopview;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtPassword;
    IBOutlet UIButton *editButton;
    
    IBOutlet UIButton *logoutButton;
    IBOutlet UIView *segmentView;
    IBOutlet UISegmentedControl *segment;
    IBOutlet UIView *mainSegmentView;
        
    
    NSMutableArray *hintArray;
    NSMutableArray *detailArray;
    
    NSMutableArray *whatCanITeachArray;
    NSMutableArray *requestArray;
    NSArray *daysArray;
    NSMutableArray *dayNameArray;
    IBOutlet UILabel *logoutLbl;
}
- (IBAction)segmentAction:(id)sender;
- (IBAction)editAction:(id)sender;
- (IBAction)loginAction:(id)sender;
- (IBAction)signUpAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)logoutAction:(id)sender;

@property(nonatomic,retain)NSString *skillId;

@property(nonatomic,retain)NSString *expertIdStr;
@property(nonatomic,retain)NSString *chackviewFlagStr;
@property(nonatomic,retain)NSString *userFlag;
- (IBAction)inviteExpertAction:(id)sender;
- (IBAction)messageAction:(id)sender;

@property (retain, nonatomic) DVSwitch *switcher;
- (IBAction)backAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)previusAction:(id)sender;
@end
