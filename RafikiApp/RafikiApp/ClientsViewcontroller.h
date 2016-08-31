//
//  ClientsViewcontroller.h
//  RafikiApp
//
//  Created by CI-05 on 2/8/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "PastJobCell.h"
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"

#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "UserProfileViewcontroller.h"
@interface ClientsViewcontroller : UIViewController
{
    
    IBOutlet UIButton *sliderButton;
    IBOutlet UITableView *clientsTbl;
    
    
    IBOutlet UIView *addClientView;
    IBOutlet UITextField *nameTxt;
    IBOutlet UITextField *emailTxt;
    IBOutlet UITextField *phoneTxt;
    IBOutlet UIButton *addClientButton;
    
    NSMutableArray *clientArray;
    NSMutableArray *menualClientArray;
    IBOutlet UISegmentedControl *segment;
    IBOutlet UIView *segmentView;
    IBOutlet UIButton *addButton;
    
    NSString *clientFlag;
}
- (IBAction)addClientAction:(id)sender;
- (IBAction)addAction:(id)sender;
- (IBAction)clientSegmentAction:(id)sender;
@end
