//
//  EditShowSkill.h
//  RafikiApp
//
//  Created by CI-05 on 5/18/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFNetworking/AFNetworking.h"
#import "HomeViewController.h"

@interface EditShowSkill : UIViewController
{
    
    IBOutlet UITableView *skillTbl;
    NSMutableArray *skillDics;
}
- (IBAction)addSkillAction:(id)sender;
- (IBAction)homeAction:(id)sender;
- (IBAction)backAction:(id)sender;
@end
