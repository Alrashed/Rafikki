//
//  EditSkillVC.h
//  RafikiApp
//
//  Created by CI-05 on 5/18/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AFNetworking/AFNetworking.h"

@interface EditSkillVC : UIViewController
{
    IBOutlet UIButton *categoryAndSubcatButton;
    IBOutlet UIButton *checkAllSkillButton;
    
    IBOutlet UITextField *agesTxtfiled;
    
    IBOutlet UITextField *qualificationTxtfiled;
    
    IBOutlet UITextField *experianceTxtfiled;
    
    IBOutlet UITextField *mustHaveTextfiled;
    
    IBOutlet UITextField *anythingTextfiled;
    
    IBOutlet UITextField *addressTextfiled;
    
    
    IBOutlet UIScrollView *skillScrollView;
    IBOutlet UILabel *titleLbl;
    IBOutlet UIButton *subCategoryButton;
    IBOutlet UIButton *skillButton;
    
    IBOutlet UIView *catSubcatSkillPopup;
    IBOutlet UITableView *commonTbl;
    IBOutlet UIButton *addButton;
    
    IBOutlet UILabel *popTitleLbl;
    
    NSMutableArray *MainCatarray;
    NSMutableArray *subCatearray;
    NSMutableArray *skillarray;
    NSString *cateIdStr;
    NSString *subcatIdStr;
    NSString *skillIdStr;
    
    NSString *skillAllStr;
    
    NSString *typeStr;
    IBOutlet UITextField *avgSessionPerTimeTxt;
    IBOutlet UITextField *pricePerSessionTxt;
    IBOutlet UITextField *milesTxt;
    IBOutlet UIImageView *allSkillImgView;
    IBOutlet UIButton *nextButton;
}
@property(nonatomic,retain)NSString *ViewtypeStr;
- (IBAction)catAction:(id)sender;
- (IBAction)subCatAction:(id)sender;
- (IBAction)skillAction:(id)sender;
@property(nonatomic,retain)NSMutableArray *detailSkillArray;
- (IBAction)nextAction:(id)sender;
- (IBAction)backAction:(id)sender;
@end
