//
//  ChatViewController.h
//  RafikiApp
//
//  Created by CI-05 on 1/23/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "IQKeyboardManager.h"
#import "IQUIView+IQKeyboardToolbar.h"
#import "ProfileViewController.h"
#import "UserProfileViewcontroller.h"
#import "ExpertHomeViewController.h"
@interface ChatViewController : UIViewController
{
    
    IBOutlet UILabel *designationLbl;
    IBOutlet UILabel *userTitleLbl;
    IBOutlet UIImageView *userImageView;
    IBOutlet UITableView *chatTbl;
    NSMutableArray *messageArray;
    NSString *useridStr;
    IBOutlet UITextField *messageTxt;
    BOOL setFirstTime;
    NSTimer *getAllmessageTimer;
    IBOutlet UIButton *profileButton;
    IBOutlet UIView *messageTxtView;
    IBOutlet UIButton *homeBtn;
}
- (IBAction)profileAction:(id)sender;
@property(nonatomic,retain)NSString *profileClickFlag;
@property(retain,nonatomic)NSString *fromUserIdStr;
@property(retain,nonatomic)NSString *fromUserName;
@property(retain,nonatomic)NSString *fromUserDesignation;
@property(retain,nonatomic)NSString *fromUserProfilepicStr;
- (IBAction)backAction:(id)sender;
- (IBAction)sendAction:(id)sender;
- (IBAction)homeAction:(id)sender;
@end
