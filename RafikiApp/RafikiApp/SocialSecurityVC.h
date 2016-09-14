//
//  SocialSecurityVC.h
//  RafikiApp
//
//  Created by CI-05 on 4/9/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoIdVC.h"
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
@interface SocialSecurityVC : UIViewController
{
    
    IBOutlet UILabel *roundLbl1;
    IBOutlet UILabel *roundLbl2;
    IBOutlet UILabel *roundLbl3;
    IBOutlet UILabel *roundLbl4;
    IBOutlet UITextField *fullNameTxt;
    IBOutlet UITextField *ageTxt;
    IBOutlet UITextField *SocialSecurityTxt;
    IBOutlet UIButton *nectButton;
}
@property(nonatomic,retain)NSString *chakEditFlag;
@property(nonatomic,retain)NSString *filedFlag;
- (IBAction)backAction:(id)sender;
- (IBAction)nextAction:(id)sender;
@end
