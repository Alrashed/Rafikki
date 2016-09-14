//
//  MessageViewController.h
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageListCell.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"

#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"

#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "ChatViewController.h"

#import "ProfileViewController.h"
#import "UserProfileViewcontroller.h"
@interface MessageViewController : UIViewController
{
    IBOutlet UITableView *messageListTbl;
    IBOutlet UIButton *sliderButtton;
    NSMutableArray *historyArray;

}
@end
