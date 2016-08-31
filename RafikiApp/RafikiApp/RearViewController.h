/*

 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
*/

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "PaychackViewController.h"
#import "HelpViewController.h"
#import "SelectAndAddPaymentVC.h"


@interface RearViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UIAlertViewDelegate>
{
    NSString *userTypeStr;
    IBOutlet UISwitch *modeSwitch;
    IBOutlet UILabel *modeLbl;
    IBOutlet UIButton *modeButton;
    IBOutlet UIView *modeView;
    IBOutlet UIImageView *modeDropDownImg;
    IBOutlet UIImageView *modeUserImageView;
}
- (IBAction)rafikkiModeAction:(id)sender;
- (IBAction)userModeAction:(id)sender;


- (IBAction)modeAction:(id)sender;
- (IBAction)modeSwitchAction:(id)sender;
@property (nonatomic, retain) IBOutlet UITableView *rearTableView;
@property (strong, nonatomic) IBOutlet UIImageView *userImageview;
@property (strong, nonatomic) IBOutlet UILabel *userNameLbl;
@property(nonatomic,retain)NSMutableArray *upperArray;
@property(nonatomic,retain)NSMutableArray *lowerArray;
@property(nonatomic,retain)NSMutableArray *iconArray;
@property(nonatomic,retain)NSMutableArray *ExpertUpperArray;
@property(nonatomic,retain)NSMutableArray *ExpertIconArray;
@property(nonatomic,retain)UISwitch *mode;

- (IBAction)userProfileAction:(id)sender;


@end