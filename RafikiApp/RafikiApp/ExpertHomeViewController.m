//
//  ExpertHomeViewController.m
//  RafikiApp
//
//  Created by CI-05 on 1/8/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "ExpertHomeViewController.h"
#import "CommonShowJobView.h"
#import "UserProfileViewcontroller.h"

#import "AFNetworking/AFNetworking.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ExpertHomeViewController ()

@end

@implementation ExpertHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;

    changeTimePopView.hidden=YES;
    changeButton.layer.cornerRadius=changeButton.frame.size.height/2;
    changeButton.layer.borderColor=[UIColor whiteColor].CGColor;
    changeButton.layer.borderWidth=1;
    changeButton.clipsToBounds=YES;
    [self getCurrentLoc];
    
    segmentView.layer.cornerRadius=5;
    segmentView.clipsToBounds=YES;
    [segment setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.5 alpha:0.2]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segment setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1.0 alpha:1.0]] forState:UIControlStateSelected  barMetrics:UIBarMetricsDefault];
   /* self.switcher = [[DVSwitch alloc] initWithStringsArray:@[@"Past job", @"Hire request",@"Upcoming job",@"Ongoing job"]];
    self.switcher.frame = CGRectMake(5,82, [[UIScreen mainScreen]bounds].size.width -10, 30);
    self.switcher.font = [UIFont fontWithName:@"Roboto-Regular" size:12];//2 113 151
    self.switcher.backgroundColor = [UIColor colorWithRed:2/255.0 green:113/255.0 blue:151/255.0 alpha:1.0];
    self.switcher.sliderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.switcher.labelTextColorInsideSlider = [UIColor colorWithRed:0/255.0 green:161/255.0 blue:217/255.0 alpha:1.0];//0 161 217
    [self.view addSubview:self.switcher];
    [self.switcher setPressedHandler:^(NSUInteger index)
     {
         if (index==0)
         {
             chackDeskFlag=@"Past job";
             [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             [self passPastjobApi];
         }
         else if (index==1)
         {
             chackDeskFlag=@"Hire request";
             [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             [self passHireRquestApi];
         }
         else if (index==2)
         {
             chackDeskFlag=@"Upcoming job";
             [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             [self passUpcomingJobApi];
         }
         else
         {
             chackDeskFlag=@"Ongoing job";
             [MBProgressHUD showHUDAddedTo:self.view animated:YES];
             [self passOngoingJobApi];
         }
         NSLog(@"Did press position on first switch at index: %lu", (unsigned long)index);
     }];*/
    [sliderButton addTarget:self.revealViewController action:@selector(revealToggle:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
    [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
    
    [self.view addSubview:dateView];
    dateView.frame=CGRectMake(dateView.frame.origin.x, [[UIScreen mainScreen] bounds].size.height+100, dateView.frame.size.width, dateView.frame.size.height);
//    chackDeskFlag=@"Past job";
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [self passPastjobApi];
}
#pragma mark Custome Date picker
-(void)createCustomDatepicker
{
    CGRect frame;
    if([UIScreen mainScreen].bounds.size.width == 375)
    {
        frame = CGRectMake(20, 80, 320, 200);
    }
    else if ([UIScreen mainScreen].bounds.size.width == 414)
    {
        frame = CGRectMake(40, 80, 320, 200);
    }
    else
    {
        frame = CGRectMake(0, 80, 320, 200);
    }
    
    UUDatePicker *datePicker
    = [[UUDatePicker alloc]initWithframe:frame
                             PickerStyle:0//UUDateStyle_YearMonthDayHourMinute//0//a[i]
                             didSelected:^(NSString *year,
                                           NSString *month,
                                           NSString *day,
                                           NSString *hour,
                                           NSString *minute,
                                           NSString *weekDay){
                                 [self uuDatePicker:datePicker year:year month:month day:day hour:hour minute:minute weekDay:weekDay];
                                 //                                 [setScheduleButton setTitle:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute] forState:UIControlStateNormal];
                                 
                             }];
    [dateView addSubview:datePicker];
    
    /*//FOR MAX LIMIT SET
     //delegate
     NSDate *now = [NSDate date];
     UUDatePicker *datePicker1= [[UUDatePicker alloc]initWithframe:CGRectMake(0, 50, 320, 200)
     Delegate:self
     PickerStyle:UUDateStyle_YearMonthDayHourMinute];
     datePicker1.ScrollToDate = now;
     datePicker1.maxLimitDate = now;
     datePicker1.minLimitDate = [now dateByAddingTimeInterval:-111111111];
     [EventDatePickerView addSubview:datePicker1];
     */
}
#pragma mark - UUDatePicker's delegate
- (void)uuDatePicker:(UUDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay
{
    //    [setScheduleButton setTitle:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute] forState:UIControlStateNormal];
    
    dateAndTimeStr=[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
}
- (NSInteger)numberOfComponentsInPickerView:(UUDatePicker *)pickerView
{
    return 5;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 0;
}
-(IBAction)setTimeAction:(id)sender
{
    [newTimeButton setTitle:@"New Time" forState:UIControlStateNormal];
    dateAndTimeStr=@"";
    NSLog(@"my tag is:%ld",(long)[sender tag]);
    [oldTimeButton setTitle:[[[hireReqarray valueForKey:@"data"] objectAtIndex:[sender tag]] valueForKey:@"start_time"] forState:UIControlStateNormal];
    inviteIdStr=[[[hireReqarray valueForKey:@"data"] objectAtIndex:[sender tag]] valueForKey:@"invite_id"];
    changeTimePopView.hidden=NO;
}
- (IBAction)doneAction:(id)sender
{
    if ([dateAndTimeStr isEqualToString:@""]||dateAndTimeStr.length==0)
    {
        [newTimeButton setTitle:@"New Time" forState:UIControlStateNormal];
    }
    else
    {
        [newTimeButton setTitle:dateAndTimeStr forState:UIControlStateNormal];
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    dateView.frame=CGRectMake(dateView.frame.origin.x, [[UIScreen mainScreen] bounds].size.height+10, dateView.frame.size.width, dateView.frame.size.height);
    [UIView commitAnimations];
}
- (IBAction)datePickerCancelAction:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    dateView.frame=CGRectMake(dateView.frame.origin.x, [[UIScreen mainScreen] bounds].size.height+10, dateView.frame.size.width, dateView.frame.size.height);
    [UIView commitAnimations];
}
- (IBAction)changeTimeAction:(id)sender
{
    if ([dateAndTimeStr isEqualToString:@""]||dateAndTimeStr.length==0)
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Please set new time"
                                      message:nil
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        //Handel your yes please button action here
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [self passUpdateTimeApi];
    }
}
- (IBAction)newTimeAction:(id)sender
{
    [self createCustomDatepicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    dateView.frame=CGRectMake(dateView.frame.origin.x, [[UIScreen mainScreen] bounds].size.height - dateView.frame.size.height, dateView.frame.size.width, dateView.frame.size.height);
    [UIView commitAnimations];
}
- (IBAction)pastJobAction:(id)sender
{
    JobHistoryViewController *job=[[JobHistoryViewController alloc] init];
    [self.navigationController pushViewController:job animated:YES];
}
- (IBAction)segmentAction:(id)sender
{
    /*if (segment.selectedSegmentIndex==0)
    {
        chackDeskFlag=@"Past job";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passPastjobApi];
    }*/
    if (segment.selectedSegmentIndex==0)
    {
        if (upcomingContDown ||[upcomingContDown isValid])
        {
            [upcomingContDown invalidate];
            upcomingContDown=nil;
        }
        chackDeskFlag=@"Hire request";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passHireRquestApi];
    }
    else
    {
        chackDeskFlag=@"Upcoming job";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passUpcomingJobApi];
        upcomingContDown=[NSTimer scheduledTimerWithTimeInterval:50.0 target:self selector:@selector(passUpcomingJobApi) userInfo:nil repeats:YES];
    }
   /* else
    {
        chackDeskFlag=@"Ongoing job";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passOngoingJobApi];
    }*/
}
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (upcomingContDown ||[upcomingContDown isValid])
    {
        [upcomingContDown invalidate];
        upcomingContDown=nil;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (segment.selectedSegmentIndex==1)
    {
          upcomingContDown=[NSTimer scheduledTimerWithTimeInterval:50.0 target:self selector:@selector(passUpcomingJobApi) userInfo:nil repeats:YES];
    }
//    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
//    if ([app.appReviewStr isEqualToString:@"Yes"])
//    {
//        [segment setSelectedSegmentIndex:0];
//        app.appReviewStr=@"No";
//        chackDeskFlag=@"Past job";
//        [self passPastjobApi];
//        [self.switcher forceSelectedIndex:0 animated:YES];
//    }
}
-(void)getCurrentLoc
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
    [self passUpdateLocationApiWithLat:[NSString stringWithFormat:@"%f",lat] Withlong:[NSString stringWithFormat:@"%f",longi]];
}
-(void)passUpdateTimeApi
{
    //cricyard.com/iphone/rafiki_app/service/counter_request.php?invite_id=&newtime=
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/counter_request.php"];
    NSDictionary *dictParams = @{@"invite_id":inviteIdStr,@"newtime":[NSString stringWithFormat:@"%@:00",dateAndTimeStr]};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@",responseObject);
        if ([[responseObject valueForKey:@"msg"]isEqualToString:@"Job counted Successfully "])
        {
            dateView.hidden=YES;
            changeTimePopView.hidden=YES;
            chackDeskFlag=@"Hire request";
            [self passHireRquestApi];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
    
}
-(void)passPastjobApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_job_history.php?userid=%@&user_type=expert",useridStr];
    
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_job_history.php"];
    NSDictionary *dictParams = @{@"userid":useridStr,@"user_type":@"expert"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        
        pastReqArray  =(NSMutableArray *) responseObject;
        chackDeskFlag=@"Past job";
        //        hireReqarray=[hireReqarray valueForKey:@"data"];
        NSLog(@"past job dics :%@",pastReqArray);
        [deskTbl reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == changeTimePopView)
        {
            NSLog(@"Ok");
            changeTimePopView.hidden=YES;
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
}
-(void)passUpdateLocationApiWithLat:(NSString *)lat Withlong:(NSString *)longi
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    //make request to the server
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/update_user_location.php?userid=%@&latitude=%f&longitude=%f",useridStr,lat,longi];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/update_user_location.php"];
    NSDictionary *dictParams = @{@"latitude":lat,
                                 @"longitude":longi,
                                 @"userid":useridStr
                                 };
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@",responseObject);
        NSDictionary *cat=(NSDictionary *)responseObject;
        if ([[cat valueForKey:@"msg"]isEqualToString:@"update success"])
        {
            chackDeskFlag=@"Hire request";
             [self passHireRquestApi];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
-(void)passHireRquestApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    // http://cricyard.com/iphone/rafiki_app/service/get_invitation.php?userid=5&user_type=expert
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_invitation.php?userid=%@&user_type=expert",useridStr];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_invitation.php"];
    NSDictionary *dictParams = @{@"userid":useridStr,@"user_type":@"expert"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        hireReqarray  =(NSMutableArray *)responseObject;
        NSLog(@"hire job dics :%@",hireReqarray);
        [deskTbl reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
-(void)passUpcomingJobApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_upcoming_job.php?userid=%@&user_type=expert",useridStr];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_upcoming_job.php"];
    NSDictionary *dictParams = @{@"userid":useridStr,@"user_type":@"expert"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        upCommingReqarray  =(NSMutableArray *)responseObject;
        NSLog(@"upcommingReqArray job dics :%@",upCommingReqarray);
        [deskTbl reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
-(void)passOngoingJobApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_current_job.php?userid=%@&user_type=expert",useridStr];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_current_job.php"];
    NSDictionary *dictParams = @{@"userid":useridStr,@"user_type":@"expert"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        ongoingReqarray  =(NSMutableArray *)responseObject;
        NSLog(@"ongoingReqarray job dics :%@",ongoingReqarray);
        [deskTbl reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
-(void)passCancelRequestApiWithInviteId:(NSString *)inviteId
{
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/accept_reject_invite.php?invite_id=%@&type=reject&user_type=expert",inviteId];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/accept_reject_invite.php"];
    NSDictionary *dictParams = @{@"invite_id":inviteId,@"type":@"reject",@"user_type":@"expert"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSDictionary *cancelDics=(NSDictionary *)responseObject;
        NSLog(@"Cancel dics :%@",cancelDics);
        [self passHireRquestApi];
//        [[hireReqarray valueForKey:@"data"] removeObjectAtIndex:cancelTag];
        [deskTbl reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
-(void)passAcceptRequestApiWithInviteId:(NSString *)inviteId
{
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/accept_reject_invite.php?invite_id=%@&type=accept&user_type=expert",inviteId];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/accept_reject_invite.php"];
    NSDictionary *dictParams = @{@"invite_id":inviteId,@"type":@"accept",@"user_type":@"expert"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSDictionary *cancelDics=(NSDictionary *)responseObject;
        NSLog(@"hire dics :%@",cancelDics);
        [self passHireRquestApi];
//        [[hireReqarray valueForKey:@"data"] removeObjectAtIndex:cancelTag];
        [deskTbl reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
    
}
-(void)passStartJobApiWithInviteId:(NSString *)inviteId WithstartTag:(NSUInteger)startTag
{
    //    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/accept_reject_invite.php?invite_id=%@&user_type=user&type=start",inviteId];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/accept_reject_invite.php"];
    NSDictionary *dictParams = @{@"invite_id":inviteId,@"type":@"start",@"user_type":@"expert"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        NSDictionary *startDics= (NSDictionary *)responseObject;
        NSLog(@"Start dics :%@",startDics);
        [[NSUserDefaults standardUserDefaults] setObject:@"start" forKey:@"startJob"];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        TreckerViewController *treck=[[TreckerViewController alloc] init];
        treck.getperamArray=[upCommingReqarray valueForKey:@"data"];
        [self.navigationController pushViewController:treck animated:YES];
        /* NSDate *startDate=[NSDate date];
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
         NSTimeZone *tz = [NSTimeZone systemTimeZone];
         // NSTimeZone *tz1 = [NSTimeZone timeZoneWithName:@"GMT +5:30"];
         [dateFormatter setTimeZone:tz];
         [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
         NSString *startDateStr = [dateFormatter stringFromDate:startDate];
         [[NSUserDefaults standardUserDefaults] setObject:startDateStr forKey:@"startDate"];*/
        /*chackDeskFlag=@"Ongoing job";
         [segment setSelectedSegmentIndex:3];
         [self passOngoingJobApi];*/
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([chackDeskFlag isEqualToString:@"Past job"])
    {
        return [[pastReqArray valueForKey:@"data"] count];
    }
    else if ([chackDeskFlag isEqualToString:@"Hire request"])
    {
        return [[hireReqarray valueForKey:@"data"]count];
    }
    else if ([chackDeskFlag isEqualToString:@"Ongoing job"])
    {
        return [[ongoingReqarray valueForKey:@"data"]count];
    }
    else
    {
        return [[upCommingReqarray valueForKey:@"data"]count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*if ([chackDeskFlag isEqualToString:@"Past job"])
    {
        static NSString *simpleTableIdentifier = @"PastJobCell";
        PastJobCell *cell = (PastJobCell *)[deskTbl dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        cell=nil;
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PastJobCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell.pastjobUserimageView setImageWithURL:[NSURL URLWithString:[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.pastjobUserimageView.layer.cornerRadius=cell.pastjobUserimageView.frame.size.height/2;
        cell.pastjobUserimageView.clipsToBounds=YES;
        
        cell.pastjobTitleLbl.text=[NSString stringWithFormat:@"%@ %@",[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
        
        cell.pastjobDesignationLbll.text=[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"job_detail"];
        
        cell.pastjobDetailLbl.text=[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"review_text"];
        cell.profilePictureButton.tag=indexPath.row;
        [cell.profilePictureButton addTarget:self action:@selector(profilePictureAction:) forControlEvents:UIControlEventTouchUpInside];
        
        float ratestar=[[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"ratting"] floatValue];
        ratestar=floorf(ratestar);
        
        if (ratestar==1.0)
        {
            cell.img1.image=[UIImage imageNamed:@"star_s"];
        }
        else if(ratestar==2.0)
        {
            cell.img1.image=[UIImage imageNamed:@"star_s"];
            cell.img2.image=[UIImage imageNamed:@"star_s"];
        }
        else if(ratestar==3.0)
        {
            cell.img1.image=[UIImage imageNamed:@"star_s"];
            cell.img2.image=[UIImage imageNamed:@"star_s"];
            cell.img3.image=[UIImage imageNamed:@"star_s"];
        }
        else if(ratestar==4.0)
        {
            cell.img1.image=[UIImage imageNamed:@"star_s"];
            cell.img2.image=[UIImage imageNamed:@"star_s"];
            cell.img3.image=[UIImage imageNamed:@"star_s"];
            cell.img4.image=[UIImage imageNamed:@"star_s"];
        }
        else if(ratestar==5.0)
        {
            cell.img1.image=[UIImage imageNamed:@"star_s"];
            cell.img2.image=[UIImage imageNamed:@"star_s"];
            cell.img3.image=[UIImage imageNamed:@"star_s"];
            cell.img4.image=[UIImage imageNamed:@"star_s"];
            cell.img5.image=[UIImage imageNamed:@"star_s"];
        }
        else
        {
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }*/
    if ([chackDeskFlag isEqualToString:@"Hire request"])
    {
        static NSString *simpleTableIdentifier = @"hireRequestCell";
        hireRequestCell *cell = (hireRequestCell *)[deskTbl dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        cell=nil;
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"hireRequestCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell.hireUserimageview setImageWithURL:[NSURL URLWithString:[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.hireUserimageview.layer.cornerRadius=cell.hireUserimageview.frame.size.height/2;
        cell.hireUserimageview.clipsToBounds=YES;
        
        cell.profilePictureButton.tag=indexPath.row;
        [cell.profilePictureButton addTarget:self action:@selector(profilePictureAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.hireTitleLbl.text=[NSString stringWithFormat:@"%@ %@",[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
        
        cell.jobStatusLbl.text=[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"status"];
        
        if ([[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"status"]isEqualToString:@"pending"])
        {
            cell.timeButton.hidden=NO;
            cell.acceptBtn.hidden=NO;
            cell.cancelBtn.hidden=NO;
        }
        else
        {
            cell.timeButton.hidden=YES;
            cell.acceptBtn.hidden=YES;
            cell.cancelBtn.hidden=YES;
        }
        cell.timeButton.tag=indexPath.row;
        [cell.timeButton addTarget:self action:@selector(setTimeAction:) forControlEvents:UIControlEventTouchUpInside];
        
//          cell.hireTitleLbl.text=[NSString stringWithFormat:@"%@",[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"username"]];
        cell.hireDesignationLbl.text=[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"start_time"];
        cell.hireDetailLbl.text=[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"skill"];
        cell.cancelBtn.tag=[indexPath row];
        cell.acceptBtn.tag=[indexPath row];

        [cell.cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.acceptBtn addTarget:self action:@selector(acceptAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    /*else if ([chackDeskFlag isEqualToString:@"Ongoing job"])
    {
        static NSString *MyIdentifier = @"MyIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        cell=nil;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
        }
        UIImageView *image=[[UIImageView alloc] init];
        image.frame=CGRectMake(5, 10, 50, 50);
        [image setImageWithURL:[NSURL URLWithString:[[[ongoingReqarray valueForKey:@"data"]objectAtIndex:indexPath.row]valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        image.layer.cornerRadius=image.frame.size.height/2;
        image.clipsToBounds=YES;
        [cell addSubview:image];
        
        UIButton *profilePictureButton =[UIButton buttonWithType:UIButtonTypeCustom];
        profilePictureButton.frame=CGRectMake(5,10,50,50);
        profilePictureButton.tag=indexPath.row;
        [profilePictureButton addTarget:self action:@selector(profilePictureAction:) forControlEvents:UIControlEventTouchUpInside];
        profilePictureButton.clipsToBounds=YES;
        [cell addSubview:profilePictureButton];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:14];
        titleLabel.frame = CGRectMake(60,10,[[UIScreen mainScreen] bounds].size.width,20);
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textColor = [UIColor colorWithRed:2/255 green:113/255 blue:151/255 alpha:0.7];
//        titleLabel.text=[[[ongoingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"username"];
       titleLabel.text=[NSString stringWithFormat:@"%@ %@",[[[ongoingReqarray valueForKey:@"data"]objectAtIndex:indexPath.row]valueForKey:@"firstname"],[[[ongoingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
        [cell addSubview:titleLabel];
        
     
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        detailLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:12];
        detailLabel.frame = CGRectMake(60,28,[[UIScreen mainScreen] bounds].size.width-90,30);
        detailLabel.backgroundColor=[UIColor clearColor];
        detailLabel.textColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.4];
        detailLabel.text=[[[ongoingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"job_detail"];
        detailLabel.numberOfLines=2;
        [cell addSubview:detailLabel];
        
        if ([[[[ongoingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"status"]isEqualToString:@"completed"])
        {
            UIButton *reviewBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            reviewBtn.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 20, 80, 35);
            reviewBtn.backgroundColor=[UIColor colorWithRed:2.0/255 green:113.0/255 blue:151.0/255 alpha:1.0];
            reviewBtn.layer.cornerRadius=reviewBtn.frame.size.height/2;
            reviewBtn.titleLabel.textColor=[UIColor whiteColor];
            [reviewBtn setTitle:@"Review" forState:UIControlStateNormal];
            reviewBtn.titleLabel.font=[UIFont fontWithName:@"Roboto-Medium" size:15];
            reviewBtn.tag=indexPath.row;
            [reviewBtn addTarget:self action:@selector(reviewAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:reviewBtn];
        }
               cell.selectionStyle=UITableViewCellSelectionStyleNone;
        //        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }*/
    else
    {
        static NSString *MyIdentifier = @"MyIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        cell=nil;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
        }
        UIImageView *image=[[UIImageView alloc] init];
        image.frame=CGRectMake(5, 10, 50, 50);
        image.image=[UIImage imageNamed:@"photo"];
        [image setImageWithURL:[NSURL URLWithString:[[[upCommingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        image.layer.cornerRadius=image.frame.size.height/2;
        image.clipsToBounds=YES;
        [cell addSubview:image];
        
        UIButton *profilePictureButton =[UIButton buttonWithType:UIButtonTypeCustom];
        profilePictureButton.frame=CGRectMake(5,10,50,50);
        profilePictureButton.tag=indexPath.row;
        [profilePictureButton addTarget:self action:@selector(profilePictureAction:) forControlEvents:UIControlEventTouchUpInside];
        profilePictureButton.clipsToBounds=YES;
        [cell addSubview:profilePictureButton];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:14];
        titleLabel.frame = CGRectMake(60,10,[[UIScreen mainScreen] bounds].size.width,20);
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.textColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.7];
        titleLabel.text=[NSString stringWithFormat:@"%@ %@",[[[upCommingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[[upCommingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
        [cell addSubview:titleLabel];
        
        //status//accepted
        
        if ([[[[upCommingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"status"]isEqualToString:@"accepted"])
        {
            UIButton *startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            startBtn.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 20, 80, 35);
            startBtn.backgroundColor=[UIColor colorWithRed:2.0/255 green:113.0/255 blue:151.0/255 alpha:1.0];
            startBtn.layer.cornerRadius=startBtn.frame.size.height/2;
            startBtn.titleLabel.textColor=[UIColor whiteColor];
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
            NSString *dateString = [dateFormatter stringFromDate: [NSDate date]];
            [startBtn setTitle:[self getTimeDifferenceOf:dateString withCurrentdate:[[[upCommingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"start_time"] ] forState:UIControlStateNormal];
//            [startBtn setTitle:@"Start" forState:UIControlStateNormal];
            startBtn.titleLabel.font=[UIFont fontWithName:@"Roboto-Medium" size:15];
            startBtn.tag=indexPath.row;
            [startBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:startBtn];
//            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        detailLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:12];
        detailLabel.frame = CGRectMake(60,30,[[UIScreen mainScreen] bounds].size.width-90,30);
        detailLabel.backgroundColor=[UIColor clearColor];
        detailLabel.textColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.4];
        detailLabel.text=[[[upCommingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"skill"];
        detailLabel.numberOfLines=3;
        [cell addSubview:detailLabel];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}
#pragma mark - getTimeDifference method.
- (NSString *)getTimeDifferenceOf:(NSString *)strDate withCurrentdate:(NSString *)strCurDate
{
    NSDateFormatter *curDateFormatter = [[NSDateFormatter alloc] init];
    //    NSTimeZone *tz1 = [NSTimeZone timeZoneWithName:@"GMT +5:30"];
    NSTimeZone *tz1 = [NSTimeZone systemTimeZone];
    [curDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [curDateFormatter setTimeZone:tz1];
    NSDate *curDate = [[NSDate alloc] init];
    curDate = [curDateFormatter dateFromString:strCurDate];
    
    NSTimeInterval timer= 1000.0*[curDate timeIntervalSince1970];
    double current = timer;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
    //    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"GMT +5:30"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:tz];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:strDate];
    
    NSTimeInterval timer1 = 1000.0*[date timeIntervalSince1970];
    double past = timer1;
    
    double SE,MI,HR,DY,MN;//YR;
    SE = 1000;
    MI = SE * 60;
    HR = MI * 60;
    DY = HR * 24;
    MN = DY * 30;
    //YR=MN*12;
    
    double RemailingMil = current-past;
    //NSLog(@"%f",RemailingMil);
    
    //double Year=RemailingMil/YR;
    //double Month=RemailingMil/MN;
    double days = RemailingMil / DY;
    double hours = fmod(RemailingMil, DY) / HR;
    double mint = fmod(RemailingMil, HR) / MI;
    double sec = fmod(RemailingMil, MI) / SE;
    
    //int years=floor(Year);
    // int month=floor(Month);
    int dayss = floor(days);
    int hors = floor(hours);
    int mintt = floor(mint);
    int secc = floor(sec);
    if (hours<0 && mint<0)
    {
        return @"Start Job";
    }
    
    NSLog(@"%d",dayss);
    if (hours<10)
    {
        //        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"0%d:%d",hors,mintt] forKey:@"lastTime"];
        //        [[NSUserDefaults standardUserDefaults] synchronize];
        return [NSString stringWithFormat:@"0%d:%d",hors,mintt];
    }
    else
    {
        //        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d:%d",hors,mintt] forKey:@"lastTime"];
        //        [[NSUserDefaults standardUserDefaults] synchronize];
        return [NSString stringWithFormat:@"%d:%d",hors,mintt];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonShowJobView *commo=[[CommonShowJobView alloc] init];
    if ([chackDeskFlag isEqualToString:@"Hire request"])
    {
        commo.jobDetailArray=[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row];
    }
    else if([chackDeskFlag isEqualToString:@"Ongoing job"])
    {
        commo.jobDetailArray=[[ongoingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row];
    }
    else
    {
        commo.jobDetailArray=[[upCommingReqarray valueForKey:@"data"] objectAtIndex:indexPath.row];

    }
    [self.navigationController pushViewController:commo  animated:YES];
}
-(IBAction)profilePictureAction:(id)sender
{
    NSLog(@"past job%@",pastReqArray);
    UserProfileViewcontroller *pr=[[UserProfileViewcontroller alloc] init];
    if ([chackDeskFlag isEqualToString:@"Past job"])
    {
        pr.idStr=[[[pastReqArray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"user_id"];
        pr.userFlag=@"user";
        pr.viewTypeStr=@"guest";
    }
    else if ([chackDeskFlag isEqualToString:@"Hire request"])
    {
        pr.idStr=[[[hireReqarray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"user_id"];
        pr.userFlag=@"user";
        pr.viewTypeStr=@"guest";
    }
    else if([chackDeskFlag isEqualToString:@"Ongoing job"])
    {
        pr.idStr=[[[ongoingReqarray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"user_id"];
        pr.userFlag=@"user";
        pr.viewTypeStr=@"guest";
    }
    else
    {
        pr.idStr=[[[upCommingReqarray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"user_id"];
        pr.userFlag=@"user";
        pr.viewTypeStr=@"guest";
    }
    [self.navigationController pushViewController:pr animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    [deskTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([chackDeskFlag isEqualToString:@"Hire request"])
    {
        return 100;
    }
    else
    {
        return 75;
    }
}
-(IBAction)startAction:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if ([btn.currentTitle isEqualToString:@"Start Job"])
    {
        NSString *jobStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"startJob"];
        if ([jobStr isEqualToString:@""]||jobStr.length==0)
        {
            NSString *inviteId=[[[upCommingReqarray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"invite_id"];
            [[NSUserDefaults standardUserDefaults] setObject:@"start" forKey:@"startJob"];
            [self passStartJobApiWithInviteId:inviteId WithstartTag:[sender tag]];
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Opps" message:@"One job already started if you want start another job you have to stop current job" delegate:self cancelButtonTitle:@"Ok git it" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Your job is not ready to start at time"] message:nil delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(IBAction)cancelAction:(id)sender
{
    NSLog(@"cancel tag is :%ld",[sender tag]);
    cancelTag=[sender tag];
    NSString *inviteId=[[[hireReqarray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"invite_id"];
    
    NSLog(@"here is :%@",hireReqarray);
    [self passCancelRequestApiWithInviteId:inviteId];
}
-(IBAction)reviewAction:(id)sender
{
    ExpertRateViewController *rate=[[ExpertRateViewController alloc] init];
    int mytag=(int)[sender tag];
    rate.getperamArray=(NSMutableArray *)[[ongoingReqarray valueForKey:@"data"] objectAtIndex:mytag];
    [self.navigationController pushViewController:rate animated:YES];
}
-(IBAction)acceptAction:(id)sender
{
    NSLog(@"cancel tag is :%ld",[sender tag]);
    acceptTag=[sender tag];
    NSString *inviteId=[[[hireReqarray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"invite_id"];
    [self passAcceptRequestApiWithInviteId:inviteId];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
