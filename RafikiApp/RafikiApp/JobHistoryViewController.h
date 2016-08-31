//
//  JobHistoryViewController.h
//  RafikiApp
//
//  Created by CI-05 on 2/20/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "PastJobCell.h"

#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

#import "CommonShowJobView.h"
#import "ProfileViewController.h"
#import "UserProfileViewcontroller.h"

#import "SWRevealViewController.h"
#import "RearViewController.h"

#import "ExpertHomeViewController.h"
@interface JobHistoryViewController : UIViewController
{
    
    IBOutlet UITableView *tblJobHistory;
    NSMutableArray *pastReqArray;
}
@property(nonatomic,retain)NSString *chackRootStr;
- (IBAction)backAction:(id)sender;

@end
