//
//  SkillDisplayView.h
//  RafikiApp
//
//  Created by CI-05 on 5/12/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFNetworking/AFNetworking.h"
#import "FilterListViewController.h"
@interface SkillDisplayView : UIViewController
{
    
    IBOutlet UILabel *titleLbl;
    IBOutlet UITableView *skillTbl;
    NSMutableDictionary *skillDics;

}
- (IBAction)backAction:(id)sender;
@property(nonatomic,retain)NSString *SkillName;
@property(nonatomic,retain)NSString *SubCatId;
- (IBAction)homeAction:(id)sender;

@end
