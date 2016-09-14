//
//  check&DiclosesVC.h
//  RafikiApp
//
//  Created by CI-05 on 3/25/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocialSecurityVC.h"
#import "ExpertSignupVC.h"
@interface check_DiclosesVC : UIViewController
{
    
    IBOutlet UIButton *agreeBtn;
}
- (IBAction)backAction:(id)sender;
- (IBAction)agreeAction:(id)sender;
- (IBAction)nextAction:(id)sender;
@end
