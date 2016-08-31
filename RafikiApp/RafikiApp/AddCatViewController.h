//
//  AddCatViewController.h
//  RafikiApp
//
//  Created by CI-05 on 2/12/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
@interface AddCatViewController : UIViewController
{
    
    IBOutlet UILabel *cateNameLbl;
    IBOutlet UILabel *subCatNameLbl;
    IBOutlet UILabel *skillNameLbl;
    IBOutlet UIView *optionView;
    IBOutlet UITableView *optionTbl;
    
    NSMutableArray *MainCatarray;
    NSMutableArray *subCatMainArray;
    NSMutableArray *skillMainArray;
    
    IBOutlet UIView *popview;
    
    NSMutableArray *catSelectArray;
    NSMutableArray *subCatSelectArray;
    NSMutableArray *skillSelectArray;
    
    NSString *chackCatTypeStr;
    IBOutlet UITableView *subCatTbl;
    IBOutlet UITableView *skillTbl;
    IBOutlet UILabel *titleLbl;
    
    NSString *subCatConcatStr;
    NSString *skillConcateStr;
    
    NSString *catConcatStr;
}
@property(nonatomic,retain)NSString *chackEditFlag;
- (IBAction)okAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)selectCatAction:(id)sender;
- (IBAction)subCatAction:(id)sender;
- (IBAction)skillAction:(id)sender;
- (IBAction)doneAction:(id)sender;
- (IBAction)backAction:(id)sender;
@end
