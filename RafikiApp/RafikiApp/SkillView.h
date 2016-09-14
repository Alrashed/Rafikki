//
//  SkillView.h
//  RafikiApp
//
//  Created by CI-05 on 4/20/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentInfoVC.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
@interface SkillView : UIViewController
{
    
    IBOutlet UIButton *categoryAndSubcatButton;
    IBOutlet UIButton *checkAllSkillButton;
    
    IBOutlet UIButton *agesButton;
    IBOutlet UITextField *agesTxtfiled;
    
    IBOutlet UIButton *qualificationButton;
    IBOutlet UITextField *qualificationTxtfiled;
    
    IBOutlet UIButton *experianceButton;
    IBOutlet UITextField *experianceTxtfiled;
    
    IBOutlet UIButton *mustHaveButton;
    IBOutlet UITextField *mustHaveTextfiled;
    
    IBOutlet UIButton *anythingElseButton;
    IBOutlet UITextField *anythingTextfiled;
    
    IBOutlet UIButton *addressButton;
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
}
- (IBAction)addAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)nextAction:(id)sender;

- (IBAction)agesAction:(id)sender;
- (IBAction)qualificationAction:(id)sender;
- (IBAction)experianceAction:(id)sender;
- (IBAction)mustHaveAction:(id)sender;
- (IBAction)anyThingElseAction:(id)sender;
- (IBAction)addressAction:(id)sender;

- (IBAction)skillAction:(id)sender;
- (IBAction)subcategoryAction:(id)sender;
- (IBAction)categoryAction:(id)sender;


- (IBAction)checkAllSkillAction:(id)sender;
- (IBAction)backAction:(id)sender;
@end
