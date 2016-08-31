//
//  AboutMeVC.h
//  RafikiApp
//
//  Created by CI-05 on 4/19/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AvailabilityDaysCell.h"
#import "SkillView.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "AFNetworking/AFNetworking.h"
@interface AboutMeVC : UIViewController
{
    
    IBOutlet UITextView *tellUsAboutTxtview;
    NSMutableArray *DaysNameArray;
    IBOutlet UICollectionView *availabilityCollectionView;
    IBOutlet UIView *skillView;
    IBOutlet UIButton *addSkillButton;
    IBOutlet UILabel *plusLbl;
    
    NSMutableArray *DayTimeArray;
    IBOutlet UIDatePicker *startTimePikerView;
    IBOutlet UIView *timeView;
    IBOutlet UIButton *timeDoneButton;
    IBOutlet UIDatePicker *endTimeDatepickerView;
    
    NSInteger daysTag;
}
- (IBAction)timeDoneAction:(id)sender;
- (IBAction)AddSkillAction:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)nextAction:(id)sender;
@end
