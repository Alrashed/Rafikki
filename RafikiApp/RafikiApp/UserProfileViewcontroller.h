//
//  UserProfileViewcontroller.h
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "PastJobCell.h"

#import "SDImageCache.h"
#import "MBProgressHUD.h"
#import "CommonShowJobView.h"
#import "ChatViewController.h"
#import "EditViewController.h"
#import "HomeViewController.h"
@interface UserProfileViewcontroller : UIViewController
{
    
    IBOutlet UIButton *sliderButton;
    IBOutlet UIImageView *userimageview;
    IBOutlet UILabel *titleLbl;
    IBOutlet UILabel *cityLbl;
    IBOutlet UIButton *messageButton;
    IBOutlet UITableView *profileTbl;
    NSMutableArray *pastReqArray;
    IBOutlet UIButton *editButton;
    
    IBOutlet UILabel *aboutMeLbl;
    IBOutlet UILabel *nickNameLbl;
    
    IBOutlet UIImageView *img1;
    IBOutlet UIImageView *img2;
    IBOutlet UIImageView *img3;
    IBOutlet UIImageView *img4;
    IBOutlet UIImageView *img5;
    IBOutlet UIButton *logoutButton;
    IBOutlet UILabel *logoutLbl;
}
- (IBAction)logOutAction:(id)sender;
- (IBAction)editAction:(id)sender;
- (IBAction)messageAction:(id)sender;
@property(nonatomic,retain)NSString *viewTypeStr;
@property(nonatomic,retain)NSString *userFlag;
@property(nonatomic,retain)NSString *idStr;
@end
