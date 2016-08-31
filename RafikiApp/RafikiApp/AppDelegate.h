//
//  AppDelegate.h
//  RafikiApp
//
//  Created by CI-05 on 12/24/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <MapKit/MapKit.h>
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "TreckerViewController.h"

#import "RateViewController.h"
#import "ExpertRateViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    UINavigationController *nav;
    CLLocationManager *locationManager;
}
@property(assign)int skillCountTag;
@property(nonatomic,retain)NSString *skillIdStr;
@property(nonatomic,retain)NSTimer *trecker;
@property(nonatomic,retain)NSString *userLatStr;
@property(nonatomic,retain)NSString *userLongStr;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SWRevealViewController *viewController;
@property(nonatomic,retain)NSString *appReviewStr;
@end

