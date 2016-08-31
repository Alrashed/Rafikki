//
//  AppDelegate.m
//  RafikiApp
//
//  Created by CI-05 on 12/24/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "HomeViewController.h"
#import "ExpertHomeViewController.h"

#import "PayPalMobile.h"
#import "AboutMeVC.h"
#import "BraintreeCore.h"
#import "PaymentInfoVC.h"

#import "ExpertSignupVC.h"//scree1
#import "VeryficationVC.h"//screen2
#import "PersonalViewController.h"//screen3
#import "SocialSecurityVC.h"//screen4
#import "PhotoIdVC.h"//screen5
#import "AboutMeVC.h"//screen6
#import "PaymentInfoVC.h"//screen7



#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface AppDelegate ()<SWRevealViewControllerDelegate>

@end

@implementation AppDelegate
@synthesize trecker,skillCountTag;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Stripe setDefaultPublishableKey:@"pk_test_ecZONuPBHFsDKqp0yswOnCNV"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    NSLog(@"my screen size:%f",[UIScreen mainScreen].bounds.size.height);
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil)
    {
        NSDictionary * aPush =[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        NSLog(@"Disct is : %@",aPush);
        [self application:application didReceiveRemoteNotification:aPush];
    }
    skillCountTag=1;
    [self getloc];
    [BTAppSwitch setReturnURLScheme:@"com.indiachat.payments"];
    [PayPalMobile initializeWithClientIdsForEnvironments:@{PayPalEnvironmentProduction : @"YOUR_CLIENT_ID_FOR_PRODUCTION",
                                                           PayPalEnvironmentSandbox : @"Ac50mpQK2xYX9Is9y1alchldpZ6aIKQfayCoZZj5No2JKHNRpDQKn5KWER7G7mQMvF0VSPptfaYbDJTX"}];
    
    NSString *userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    NSString *email=[[NSUserDefaults standardUserDefaults] objectForKey:@"userEmail"];
    NSString *password=[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    if (([email isEqualToString:@""]||email.length==0)&&([password isEqualToString:@""]||password.length==0))
    {
        HomeViewController *frontViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];//frantview
        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
        
        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
        revealController.delegate = self;
        self.window.rootViewController = revealController;
        
      /*  SkillView *view=[[SkillView alloc] init];
        nav=[[UINavigationController alloc] initWithRootViewController:view];
        self.window.rootViewController=nav;*/
        
       /* PaymentInfoVC *view=[[PaymentInfoVC alloc] init];
        nav=[[UINavigationController alloc] initWithRootViewController:view];
        self.window.rootViewController=nav;*/
    }
    else
    {
        if ([userTypeStr isEqualToString:@"1"])
        {
            NSString *jobFlag=[[NSUserDefaults standardUserDefaults] objectForKey:@"startJob"];
            if ([jobFlag isEqualToString:@"start"])
            {
                TreckerViewController *treck=[[TreckerViewController alloc] init];
                nav=[[UINavigationController alloc] initWithRootViewController:treck];
                self.window.rootViewController=nav;
            }
            else
            {
                if ([[[NSUserDefaults standardUserDefaults]  objectForKey:@"loginCheck"]isEqualToString:@"Yes"])
                {
                    HomeViewController *frontViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];//frantview
                    RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                    
                    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                    
                    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                    revealController.delegate = self;
                    
                    self.window.rootViewController = revealController;
                }
                else
                {
                    NSString *screen1=[[NSUserDefaults standardUserDefaults] objectForKey:@"screen1_basic"];
                    NSString *screen2=[[NSUserDefaults standardUserDefaults] objectForKey:@"screen2_verify"];
                    NSString *screen3=[[NSUserDefaults standardUserDefaults] objectForKey:@"screen3_personal"];
                    
                    if (![screen1 isEqualToString:@"save"])
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen1_basic"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen2_verify"];
                        [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen3_personal"];
                        
                        SignupViewController *frontViewController = [[SignupViewController alloc] initWithNibName:@"SignupViewController" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                    }
                    else if (![screen2 isEqualToString:@"save"])
                    {
                        VeryficationVC *frontViewController = [[VeryficationVC alloc] initWithNibName:@"VeryficationVC" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                        
                        self.window.rootViewController = revealController;
                    }
                    else if (![screen3 isEqualToString:@"save"])
                    {
                        PersonalViewController *frontViewController = [[PersonalViewController alloc] initWithNibName:@"PersonalViewController" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                        
                        self.window.rootViewController = revealController;
                    }
                    else
                    {
                        HomeViewController *frontViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                        
                        self.window.rootViewController = revealController;
                    }
                }
            }
        }
        else
        {
            NSString *jobFlag=[[NSUserDefaults standardUserDefaults] objectForKey:@"startJob"];
            if ([jobFlag isEqualToString:@"start"])
            {
                TreckerViewController *treck=[[TreckerViewController alloc] initWithNibName:@"TreckerViewController" bundle:nil];
                nav=[[UINavigationController alloc] initWithRootViewController:treck];
                self.window.rootViewController=nav;
            }
            else
            {
                
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"loginCheck"]isEqualToString:@"Yes"])
                {
                    ExpertHomeViewController *frontViewController = [[ExpertHomeViewController alloc] initWithNibName:@"ExpertHomeViewController" bundle:nil];//frantview
                    RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                    
                    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                    
                    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                    revealController.delegate = self;
                    
                    self.window.rootViewController = revealController;
                }
                else
                {
                    NSString *screen1=[[NSUserDefaults standardUserDefaults] objectForKey:@"screen1_basic"];
                    NSString *screen2=[[NSUserDefaults standardUserDefaults] objectForKey:@"screen2_verify"];
                    NSString *screen3=[[NSUserDefaults standardUserDefaults] objectForKey:@"screen3_personal"];
                    NSString *screen4=[[NSUserDefaults standardUserDefaults] objectForKey:@"screen4_Socail"];
                    NSString *screen5=[[NSUserDefaults standardUserDefaults] objectForKey:@"screen5_photoId"];
                    NSString *screen6=[[NSUserDefaults standardUserDefaults] objectForKey:@"screen6_Aboutme"];
                    NSString *screen7=[[NSUserDefaults standardUserDefaults] objectForKey:@"screen7_payment"];
                    
                    if (![screen1 isEqualToString:@"save"])
                    {
                        ExpertSignupVC *frontViewController = [[ExpertSignupVC alloc] initWithNibName:@"ExpertSignupVC" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                    }
                    else if (![screen2 isEqualToString:@"save"])
                    {
                        VeryficationVC *frontViewController = [[VeryficationVC alloc] initWithNibName:@"VeryficationVC" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                        self.window.rootViewController = revealController;
                    }
                    else if (![screen3 isEqualToString:@"save"])
                    {
                        PersonalViewController *frontViewController = [[PersonalViewController alloc] initWithNibName:@"PersonalViewController" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                        
                        self.window.rootViewController = revealController;
                    }
                    else if (![screen4 isEqualToString:@"save"])
                    {
                        SocialSecurityVC *frontViewController = [[SocialSecurityVC alloc] initWithNibName:@"SocialSecurityVC" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                        self.window.rootViewController = revealController;
                    }
                    else if (![screen5 isEqualToString:@"save"])
                    {
                        PhotoIdVC *frontViewController = [[PhotoIdVC alloc] initWithNibName:@"PhotoIdVC" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                        self.window.rootViewController = revealController;
                    }
                    else if (![screen6 isEqualToString:@"save"])
                    {
                        
                        AboutMeVC *frontViewController = [[AboutMeVC alloc] initWithNibName:@"AboutMeVC" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                        self.window.rootViewController = revealController;
                    }
                    else if (![screen7 isEqualToString:@"save"])
                    {
                        PaymentInfoVC *frontViewController = [[PaymentInfoVC alloc] initWithNibName:@"PaymentInfoVC" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                        self.window.rootViewController = revealController;
                    }
                    else
                    {
                        ExpertHomeViewController *frontViewController = [[ExpertHomeViewController alloc] initWithNibName:@"ExpertHomeViewController" bundle:nil];//frantview
                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                        
                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                        
                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                        revealController.delegate = self;
                        
                        self.window.rootViewController = revealController;
                    }
                }
            }
        }
    }
    [self.window makeKeyAndVisible];
    return YES;
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    if ([url.scheme localizedCaseInsensitiveCompare:@"com.indiachat.payments"] == NSOrderedSame) {
        return [BTAppSwitch handleOpenURL:url sourceApplication:sourceApplication];
    }
    return NO;
}
-(void)getloc
{
    locationManager=[[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    if(IS_OS_8_OR_LATER)
    {        [locationManager requestAlwaysAuthorization];
        //[locationManagerApp requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    CLLocation *location1 = [locationManager location];
    CLLocationCoordinate2D coordinate = [location1 coordinate];
    float lat =coordinate.latitude;
    float longi = coordinate.longitude;
    NSLog(@"Latitude  = %f", lat);
    NSLog(@"Longitude = %f", longi);
}
#pragma mark Push Notification Methods -
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
   NSString *tokenString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSLog(@"APN device token: %@", tokenString);
    NSLog(@"Push Notification tokenstring is %@",tokenString);
    
    tokenString = [[[[deviceToken description]
                      stringByReplacingOccurrencesOfString: @"<" withString: @""]
                     stringByReplacingOccurrencesOfString: @">" withString: @""]
                    stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"Push Notification tokenstring is %@",tokenString);
    [[NSUserDefaults standardUserDefaults]setObject:tokenString forKey:@"Tocken"];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
     //call from lounchingOption method
    NSLog(@"%@",userInfo);
    NSString *chack=[[userInfo objectForKey:@"aps"]objectForKey:@"title"];
    
    if ([chack isEqualToString:@"Job Start"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"start" forKey:@"startJob"];
        TreckerViewController *treck=[[TreckerViewController alloc] init];
        nav=[[UINavigationController alloc] initWithRootViewController:treck];
        self.window.rootViewController=nav;
    }
    else if ([chack isEqualToString:@"Job Completed"])
    {
        NSString *userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
        if ([userTypeStr isEqualToString:@"1"])
        {
            if (trecker||[trecker isValid])
            {
                [trecker invalidate];
            }
            
            RateViewController *rate=[[RateViewController alloc] init];
            rate.NotiDataflag=@"Yes";
            rate.getperamArray=(NSMutableArray *)[userInfo objectForKey:@"aps"];
            nav=[[UINavigationController alloc] initWithRootViewController:rate];
            self.window.rootViewController=nav;
        }
        else
        {
            ExpertRateViewController *rate=[[ExpertRateViewController alloc] init];
            rate.NotiDataflag=@"Yes";
            rate.getperamArray=(NSMutableArray *)[userInfo objectForKey:@"aps"];
            nav=[[UINavigationController alloc] initWithRootViewController:rate];
            self.window.rootViewController=nav;
        }
    }
     if ([UIApplication sharedApplication].applicationState==UIApplicationStateActive)
     {
        NSLog(@"Notification recieved by running app");
     }
     else
     {
        NSLog(@"App opened from Notification");
     }
}
#pragma mark End Push Methods
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
