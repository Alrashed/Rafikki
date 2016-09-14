//
//  FilterListViewController.h
//  RafikiApp
//
//  Created by CI-05 on 3/8/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "PastJobCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "ProfileViewController.h"
@interface FilterListViewController : UIViewController<CLLocationManagerDelegate>
{
    
    IBOutlet UITableView *expertListTbl;
    CLLocationManager *locationManager;
    
    float  latPub;
    float  longiPub;
    NSMutableDictionary *nearDics;
}
- (IBAction)homeAction:(id)sender;
@property(retain,nonatomic)NSString *catIdStr;
- (IBAction)backAction:(id)sender;
@end
