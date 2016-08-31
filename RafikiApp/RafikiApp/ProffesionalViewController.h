//
//  ProffesionalViewController.h
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "MBProgressHUD.h"
#import "AddCatViewController.h"
#import "HomeViewController.h"
@interface ProffesionalViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
    IBOutlet UITextField *txtExpiriance;
    IBOutlet UITextField *txtQualification;
    IBOutlet UITextField *txtDesignation;
    IBOutlet UITextField *txtRate;
    IBOutlet UITextField *txtSkill;
    IBOutlet UIButton *addServiceButton;
    IBOutlet UITableView *catTbl;
    
    NSMutableDictionary *catDics;
    NSString *catIdStr;
    IBOutlet UIButton *cancelButton;
}
- (IBAction)cancelAction:(id)sender;
@property(nonatomic,retain)NSString *filedFlag;
- (IBAction)submitAction:(id)sender;
- (IBAction)SkipAction:(id)sender;
- (IBAction)addServiceAction:(id)sender;
@end
