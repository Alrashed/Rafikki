//
//  SubCategoryVC.h
//  RafikiApp
//
//  Created by CI-05 on 2/17/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "MapViewController.h"
#import "FilterListViewController.h"
#import "SkillDisplayView.h"
@interface SubCategoryVC : UIViewController
{
    
    IBOutlet UITableView *subCatTbl;
    NSMutableDictionary *subCatDics;
    IBOutlet UILabel *titleLbl;
}
- (IBAction)homeAction:(id)sender;
@property(nonatomic,retain)NSString *catIdStr;
@property(nonatomic,retain)NSString *catName;
- (IBAction)backAction:(id)sender;
@end
