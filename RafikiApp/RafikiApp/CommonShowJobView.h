//
//  CommonShowJobView.h
//  RafikiApp
//
//  Created by CI-05 on 1/12/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVSwitch.h"

@interface CommonShowJobView : UIViewController
{
    IBOutlet UITextView *jobDetailTxtview;
    IBOutlet UITextField *locationTxt;
    IBOutlet UITextField *specialInstructionTxt;
}
- (IBAction)backAction:(id)sender;
@property(nonatomic,retain)NSMutableArray *jobDetailArray;
@property (retain, nonatomic) DVSwitch *switcher;
@property(retain,nonatomic)NSString *jobDetailStr;
@property(retain,nonatomic)NSString *priceStr;
@property(retain,nonatomic)NSString *priceTypeStr;
@end
