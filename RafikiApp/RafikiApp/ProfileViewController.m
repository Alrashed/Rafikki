//
//  ProfileViewController.m
//  RafikiApp
//
//  Created by CI-05 on 12/29/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "ProfileViewController.h"
#import "AboutJobViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "AFNetworking/AFNetworking.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize expertIdStr,chackviewFlagStr,userFlag,skillId;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    whatCanITeachArray=[[NSMutableArray alloc] init];
    
    hintArray=[[NSMutableArray alloc] initWithObjects:@"Location :",@"Sesson Time:",@"Ages:",@"Must Have:",@"Cost:", nil];
    
    dayNameArray=[[NSMutableArray alloc] initWithObjects:@"mon",@"tue",@"wed",@"thu",@"fri",@"sat",@"sun", nil];
    
    if ([chackviewFlagStr isEqualToString:@"ExpertOwner"])
    {
        [back setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
        [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
        messageButton.hidden=YES;
        inviteButton.hidden=YES;
        editButton.hidden=NO;
        logoutButton.hidden=NO;
        logoutLbl.hidden=NO;
        segmentView.hidden=NO;
        mainSegmentView.hidden=NO;

         [back addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        //profileTbl.frame=CGRectMake(0, activeLbl.frame.origin.y+activeLbl.frame.size.height+20,profileTbl.frame.size.width, profileTbl.frame.size.height);
    }
    else
    {
        messageButton.hidden=NO;
        inviteButton.hidden=NO;
        editButton.hidden=YES;
        logoutButton.hidden=YES;
        logoutLbl.hidden=YES;
        
        segmentView.layer.cornerRadius=5;
        segmentView.clipsToBounds=YES;
        
        [segment setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.5 alpha:0.2]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [segment setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1.0 alpha:1.0]] forState:UIControlStateSelected  barMetrics:UIBarMetricsDefault];
        
       /* int margin=30;
        self.switcher = [[DVSwitch alloc] initWithStringsArray:@[@"Basic info",@"Training Detail", @"Job history"]];
        self.switcher.frame = CGRectMake(20,margin*6,[[UIScreen mainScreen] bounds].size.width - 20 * 3, 30);
        self.switcher.font = [UIFont fontWithName:@"Roboto-Regular" size:16];//2 113 151
        self.switcher.backgroundColor = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0];
        self.switcher.sliderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        self.switcher.labelTextColorInsideSlider = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0];
        [self.view addSubview:self.switcher];
        [self.switcher setPressedHandler:^(NSUInteger index)
         {
             if (index==0)
             {
                 TblValue=@"Basic Info";
                 [profileTbl reloadData];
             }
             else
             {
                 TblValue=@"Job History";
                 [profileTbl reloadData];
             }
             NSLog(@"Did press position on first switch at index: %lu", (unsigned long)index);
         }];*/
    }
    
    
    [self setNeedsStatusBarAppearanceUpdate];
    infoiconImage=[[NSMutableArray alloc] initWithObjects:@"port",@"about",@"quali", nil];
    
    [self.view addSubview:loginPopview];
    
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    loginPopview.hidden=YES;
    
    segment.selectedSegmentIndex=0;
    TblValue=@"Basic Info";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passGetdetailExpertApi];
}
-(void)viewDidAppear:(BOOL)animated
{
    userImageView.layer.cornerRadius=userImageView.frame.size.height/2;
    userImageView.layer.borderWidth=2;
    userImageView.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:177.0/255.0 blue:162.0/255.0 alpha:1.0].CGColor;
    userImageView.clipsToBounds=YES;
}
-(void)passGetdetailExpertApi
{
    NSString *urlStr;
    urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_user_profile.php"];
    NSDictionary *dictParams;
    if ([skillId isEqualToString:@""]||skillId.length==0)
    {
        dictParams = @{@"userid":expertIdStr,@"user_type":userFlag};
    }
    else
    {
        dictParams = @{@"userid":expertIdStr,@"user_type":userFlag,@"skill_id":skillId};
    }
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        expertAllArray  =(NSMutableArray *)responseObject;
        NSLog(@"expert dics :%@",expertAllArray);
        NSLog(@"Data is:%@",[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"what_i_teach"]);
        
        NSLog(@"day's string:%@",[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"available_days"]);
        
        daysArray = [[[expertAllArray valueForKey:@"user_profile"]valueForKey:@"available_days"] componentsSeparatedByString:@","];
       whatCanITeachArray=(NSMutableArray *)[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"what_i_teach"];
        requestArray=(NSMutableArray *)[expertAllArray valueForKey:@"job_request"];
        [self setValue];
        [profileTbl reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
-(void)signInApiCall
{
    //    NSString *tocken=[[NSUserDefaults standardUserDefaults] objectForKey:@"Tocken"];
    //   NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/login.php?email=%@&password=%@",TxtemailAddress.text,Txtpassword.text];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/login.php"];//?email=%@&password=%@",TxtemailAddress.text,Txtpassword.text];
    NSDictionary *dictParams = @{
                                 @"email":txtEmail.text,
                                 @"password":txtPassword.text
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        if (responseObject)
        {
            NSDictionary  *resposeDics= (NSDictionary *) responseObject;
            if ([[resposeDics valueForKey:@"staus"] integerValue]==1)
            {
                NSString *userTypeStr=[[resposeDics valueForKey:@"data"] valueForKey:@"user_type"];
                if ([userTypeStr isEqualToString:@"1"])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"username"]  forKey:@"userName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"]valueForKey:@"email"] forKey:@"userEmail"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"password"] forKey:@"userPassword"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"] valueForKey:@"phone_no"] forKey:@"userPhone"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"] valueForKey:@"user_id"] forKey:@"userId"];
                    NSLog(@"my data is:%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"userId"]);
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"user_type"] forKey:@"userType"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"firstname"] forKey:@"firstName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"lastname"] forKey:@"lastName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"gender"] forKey:@"gender"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"user_image"] forKey:@"profilePic"];
                    
                    [self passUpdateDeviceToken];
                    
                  /*  HomeViewController *home=[[HomeViewController alloc] init];
                    [self.navigationController pushViewController:home animated:YES];*/
                }
                else
                {
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"username"]  forKey:@"userName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"]valueForKey:@"email"] forKey:@"userEmail"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"password"] forKey:@"userPassword"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"] valueForKey:@"phone_no"] forKey:@"userPhone"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"] valueForKey:@"user_id"] forKey:@"userId"];
                    NSLog(@"my data is:%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"userId"]);
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"user_type"] forKey:@"userType"];
                    
                    
                    //expert personal data
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"firstname"] forKey:@"firstName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"lastname"] forKey:@"lastName"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"gender"] forKey:@"gender"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"user_image"] forKey:@"profilePic"];
                    
                    //expert proff data
                  /*  [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"experience"] forKey:@"expiriance"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"designation"] forKey:@"designation"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"qulification"] forKey:@"qualification"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"hour_rate"] forKey:@"rate"];
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"skill"] forKey:@"skill"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"session_time"] forKey:@"session"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"ages"] forKey:@"ages"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"must_have"] forKey:@"mustHave"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"cost"] forKey:@"cost"];*/
                    
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"about_me"] forKey:@"aboutMe"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"goverment_id"] forKey:@"photoId"];
                    
                    //
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"social_security_number"] forKey:@"socialSecurityNumber"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"birthdate"] forKey:@"birthDate"];
                    
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"catIds"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"subcatIds"];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"skillIds"];
                    
                    [self passUpdateDeviceToken];
                }
            }
            else
            {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertController * alert=[UIAlertController
                                           alertControllerWithTitle:@"Invalid username and password!!"
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
            
        }
    }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         }];
}
-(void)passUpdateDeviceToken
{
    //http://cricyard.com/iphone/rafiki_app/service/update_device_token.php?userid=1&device_token=123456&device_type=1
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *tockenStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"Tocken"];
    
    if ([tockenStr isEqualToString:@""]||tockenStr.length==0)
    {
        tockenStr=@"123456789789456123";
    }
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/update_device_token.php"];
    NSDictionary *dictParams = @{@"userid":useridStr,@"device_token":tockenStr,@"device_type":@"1"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         
         NSString *userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
         if ([userTypeStr isEqualToString:@"1"])
         {
             loginPopview.hidden=YES;
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }
         else
         {
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             ExpertHomeViewController *Exhome=[[ExpertHomeViewController alloc] init];
             [self.navigationController pushViewController:Exhome animated:YES];
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
-(void)setValue
{
    titleLbl.text=[NSString stringWithFormat:@"%@ %@",[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"firstname"],[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"lastname"]];
    designationLbl.text=[[expertAllArray valueForKey:@"user_profile"]  valueForKey:@"designation"];
    NSString *genderStr=[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"gender"];
    NSString *loginStatusStr=[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"login_status"];
    if ([loginStatusStr isEqualToString:@"0"])
    {
        loginStatusStr=@"Active";
    }
    else
    {
        loginStatusStr=@"Unactive";
    }
    if ([genderStr isEqualToString:@"1"])
    {
        genderStr=@"Male";
    }
    else
    {
        genderStr=@"Female";
    }
    NSString *dateofBirth=[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"birthdate"];
    if (dateofBirth.length==0)
    {
        dateofBirth=@"not added";
    }
    activeLbl.text=[NSString stringWithFormat:@"%@ | %@ ",loginStatusStr,genderStr];
    
//    activeLbl.text=[NSString stringWithFormat:@"%@ | %@ | %@",loginStatusStr,genderStr,dateofBirth];
    [userImageView setImageWithURL:[NSURL URLWithString:[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark Tableview Delegate methods -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([TblValue isEqualToString:@"Basic Info"])
    {
        return 2;
    }
    else if ([TblValue isEqualToString:@"Training Detail"])
    {
        return [whatCanITeachArray count];
    }
    else if ([TblValue isEqualToString:@"Request"])
    {
        return [requestArray count];
    }
    else
    {
        return  [[expertAllArray valueForKey:@"data"]  count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([TblValue isEqualToString:@"Basic Info"])
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [profileTbl dequeueReusableCellWithIdentifier:CellIdentifier];
        cell=nil;
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        if (indexPath.row==0)
        {
            UILabel *aboutTitlLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, [[UIScreen mainScreen] bounds].size.width-10, 22)];
            aboutTitlLbl.text=@"About :";
            aboutTitlLbl.font=[UIFont boldSystemFontOfSize:15.0];
            [cell addSubview:aboutTitlLbl];
            
            UILabel *aboutDesLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 25, [[UIScreen mainScreen] bounds].size.width-10, 22)];
            aboutDesLbl.text=[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"about_me"];
            //[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"available_days"];
            aboutDesLbl.font=[UIFont fontWithName:@"Roboto-Medium" size:12.0];
            [cell addSubview:aboutDesLbl];
        }
        else
        {
            
            UILabel *aboutTitlLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, [[UIScreen mainScreen] bounds].size.width-10, 22)];
            aboutTitlLbl.text=@"Availability :";
            aboutTitlLbl.font=[UIFont boldSystemFontOfSize:15.0];
            [cell addSubview:aboutTitlLbl];
            
            //Horizontal Line 1
            UILabel *horiUpLbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 40, [[UIScreen mainScreen] bounds].size.width, 1)];
            [horiUpLbl setBackgroundColor:[UIColor lightGrayColor]];
            [cell addSubview:horiUpLbl];
            
            //Horizontal Line 2 days Name line
            UILabel *horiUpSecLbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 70, [[UIScreen mainScreen] bounds].size.width, 1)];
            [horiUpSecLbl setBackgroundColor:[UIColor lightGrayColor]];
            [cell addSubview:horiUpSecLbl];
            
            float contLblx=0;
            
            float lineLblx=[[UIScreen mainScreen] bounds].size.width/7;
            for (int a=0; a<7; a++)
            {
                UILabel *lineLbl=[[UILabel alloc] initWithFrame:CGRectMake(lineLblx, 40, 1, 210)];
                [lineLbl setBackgroundColor:[UIColor lightGrayColor]];
                [cell addSubview:lineLbl];
                
                UILabel *dayNameLbl=[[UILabel alloc] initWithFrame:CGRectMake(contLblx+1, 40, [[UIScreen mainScreen] bounds].size.width/7-2, 30)];
                dayNameLbl.text=[dayNameArray objectAtIndex:a];
                dayNameLbl.textAlignment=NSTextAlignmentCenter;
                [cell addSubview:dayNameLbl];
                
                
                UILabel *dayValueLbl=[[UILabel alloc] initWithFrame:CGRectMake(contLblx+1, 45, [[UIScreen mainScreen] bounds].size.width/7-2, 200)];
                if (![daysArray containsObject:@""])
                {
                    dayValueLbl.text=[daysArray objectAtIndex:a];
                }
                dayValueLbl.numberOfLines=0;
                [cell addSubview:dayValueLbl];
                
                lineLblx+=[[UIScreen mainScreen] bounds].size.width/7;
                contLblx+=[[UIScreen mainScreen] bounds].size.width/7;
            }
        }
        return cell;
    }
    else if ([TblValue isEqualToString:@"Training Detail"])
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [profileTbl dequeueReusableCellWithIdentifier:CellIdentifier];
        cell=nil;
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        UILabel *expiriance=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width-10, 22)];
        expiriance.text=[NSString stringWithFormat:@"Expiriance: %@",[[whatCanITeachArray objectAtIndex:indexPath.row] valueForKey:@"expiriance"]];
        [cell addSubview:expiriance];
        
        UILabel *skill_nameLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 32, [[UIScreen mainScreen] bounds].size.width-10, 22)];
        
        skill_nameLbl.text=[NSString stringWithFormat:@"Skill: %@",[[whatCanITeachArray objectAtIndex:indexPath.row] valueForKey:@"skill_name"]];
        [cell addSubview:skill_nameLbl];
        
        UILabel *avg_session_timeLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 54, [[UIScreen mainScreen] bounds].size.width-10, 22)];
        
        avg_session_timeLbl.text=[NSString stringWithFormat:@"Avg Session: %@",[[whatCanITeachArray objectAtIndex:indexPath.row] valueForKey:@"avg_session_time"]];
        [cell addSubview:avg_session_timeLbl];
        
        UILabel *price_per_sessionLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 76, [[UIScreen mainScreen] bounds].size.width-10, 22)];
        
        price_per_sessionLbl.text=[NSString stringWithFormat:@"Price per session: %@",[[whatCanITeachArray objectAtIndex:indexPath.row] valueForKey:@"price_per_session"]];
        [cell addSubview:price_per_sessionLbl];
        
        UILabel *ages=[[UILabel alloc] initWithFrame:CGRectMake(10, 98, [[UIScreen mainScreen] bounds].size.width-10, 22)];
        ages.text=[NSString stringWithFormat:@"Ages: %@",[[whatCanITeachArray objectAtIndex:indexPath.row] valueForKey:@"ages"]];
        [cell addSubview:ages];
        
        UILabel *qulification=[[UILabel alloc] initWithFrame:CGRectMake(10, 120, [[UIScreen mainScreen] bounds].size.width-10, 22)];
        
        qulification.text=[NSString stringWithFormat:@"Qulification: %@",[[whatCanITeachArray objectAtIndex:indexPath.row] valueForKey:@"qulification"]];
        [cell addSubview:qulification];
        
        expiriance.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
        expiriance.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
        skill_nameLbl.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
        skill_nameLbl.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
        avg_session_timeLbl.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
        avg_session_timeLbl.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
        price_per_sessionLbl.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
        price_per_sessionLbl.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
        ages.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
        ages.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
        qulification.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
        qulification.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
        return cell;
    }
    else
    {
        static NSString *simpleTableIdentifier = @"jobHistoryTableViewCell";
        jobHistoryTableViewCell *cell = (jobHistoryTableViewCell *)[profileTbl dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        cell=nil;
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"jobHistoryTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        if ([[expertAllArray valueForKey:@"data"] count]!=0)
        {
            cell.jobTitleLbl.text=[NSString stringWithFormat:@"%@ %@",[[[expertAllArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[[expertAllArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
            cell.jobDetailLbl.text=[[[expertAllArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"email"];
            
            [cell.userimgView setImageWithURL:[NSURL URLWithString:[[[expertAllArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            cell.userimgView.layer.cornerRadius=cell.userimgView.frame.size.height/2;
            cell.userimgView.clipsToBounds=YES;
            
            float ratestar=[[[[expertAllArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"ratting"] floatValue];
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
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
        
        if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
        [profileTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([TblValue isEqualToString:@"Job History"])
    {
       /* CommonShowJobView *commo=[[CommonShowJobView alloc] init];
        commo.jobDetailStr=[[[expertAllArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"job_detail"];
        commo.priceStr=[[[expertAllArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"price"];
        commo.priceTypeStr=[[[expertAllArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"price_type"];
        [self.navigationController pushViewController:commo  animated:YES];*/
    }
    else
    {
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([TblValue isEqualToString:@"Basic Info"])
    {
        if (indexPath.row==0)
        {
            return 50;
        }
        else
        {
            return 250;
        }
    }
    else
    {
        if ([TblValue isEqualToString:@"Training Detail"])
        {
            return 170;
        }
        else
        {
            return 65;
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextAction:(id)sender
{
    [userImageView setImageWithURL:[NSURL URLWithString:[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"goverment_id"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

- (IBAction)previusAction:(id)sender
{
   [userImageView setImageWithURL:[NSURL URLWithString:[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];   
}
- (IBAction)inviteExpertAction:(id)sender
{
    /*UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"What you Can Do?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Invite Expert",nil];
    [self parentViewController];
    [action showInView:self.view];*/
    NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    if ([userIdStr isEqualToString:@""]||userIdStr==nil ||userIdStr==(id)[NSNull null])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"you need to sign in" message:@"you want to sign in ?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        alert.tag=1000;
        [alert show];
        return ;
    }
    else
    {
        AboutJobViewController *about=[[AboutJobViewController alloc] init];
        about.expertIdStr=expertIdStr;
        about.expertDetailArray=[expertAllArray valueForKey:@"user_profile"];
        [self.navigationController pushViewController:about animated:YES];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000)
    {
        if (buttonIndex ==1)
        {
            
        }
        else
        {
            loginPopview.hidden=NO;
        }
    }
}
- (IBAction)messageAction:(id)sender
{
    NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    if ([userIdStr isEqualToString:@""]||userIdStr==nil ||userIdStr==(id)[NSNull null])
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"you need to sign in" message:@"you want to sign in ?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
        alert.tag=1000;
        [alert show];
        return ;
    }
    else
    {
        ChatViewController *chat=[[ChatViewController alloc] init];
        chat.fromUserIdStr=[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"user_id"];
        chat.fromUserName=[NSString stringWithFormat:@"%@ %@",[[expertAllArray valueForKey:@"user_profile"]valueForKey:@"firstname"],[[expertAllArray valueForKey:@"user_profile"]valueForKey:@"lastname"]];
        chat.fromUserDesignation=[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"designation"];
        chat.fromUserProfilepicStr=[[expertAllArray valueForKey:@"user_profile"] valueForKey:@"user_image"];
        [self.navigationController pushViewController:chat animated:YES];
    }
}
- (IBAction)segmentAction:(id)sender
{
    NSLog(@"Segment Index:%ld",segment.selectedSegmentIndex);
    if (segment.selectedSegmentIndex==0)
    {
        TblValue=@"Basic Info";
        [profileTbl reloadData];
    }
    else if (segment.selectedSegmentIndex==1)
    {
        TblValue =@"Training Detail";
        [profileTbl reloadData];

    }
    else if (segment.selectedSegmentIndex==2)
    {
        TblValue=@"Job History";
        [profileTbl reloadData];
    }
    else
    {
        if ([chackviewFlagStr isEqualToString:@"ExpertOwner"])
        {
            //Request Owner Login
        }
        else
        {
            NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
            if ([userIdStr isEqualToString:@""]||userIdStr==nil ||userIdStr==(id)[NSNull null])
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"you need to sign in" message:@"you want to sign in ?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                alert.tag=1000;
                [alert show];
                return ;
            }
            else
            {
                AboutJobViewController *about=[[AboutJobViewController alloc] init];
                about.expertIdStr=expertIdStr;
                about.expertDetailArray=[expertAllArray valueForKey:@"user_profile"];
                [self.navigationController pushViewController:about animated:YES];
            }
        }
    }
}

- (IBAction)editAction:(id)sender
{
    ExpertEditVC *edit=[[ExpertEditVC alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
}
- (IBAction)loginAction:(id)sender
{
    if (([txtEmail.text isEqualToString:@""]||txtEmail.text.length==0)||([txtPassword.text isEqualToString:@""]||txtPassword.text.length==0))
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Please enter username and password"
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
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self signInApiCall];
    }
}

- (IBAction)signUpAction:(id)sender
{
    /*SignupViewController *sign=[[SignupViewController alloc] init];
    [self.navigationController pushViewController:sign animated:YES];*/
}
- (IBAction)cancelAction:(id)sender
{
    loginPopview.hidden=YES;
}
- (IBAction)logoutAction:(id)sender
{
    NSString *jobStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"startJob"];
    if ([jobStr isEqualToString:@""]||jobStr.length==0)
    {
        [self passStatusApi];
       
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Opps" message:@"One job already started if you want logout you have to complete this job in Ongoing Section" delegate:self cancelButtonTitle:@"Ok git it" otherButtonTitles:nil, nil];
        alert.tag=5000;
        [alert show];
    }
}
-(void)passStatusApi
{
    NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    //http://cricyard.com/iphone/rafiki_app/service/update_login_status.php?userid=1&status=0
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/update_login_status.php"];
    NSDictionary *dictParams = @{@"userid":userIdStr,@"status":@"1"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        [self removeNSUserValue];
        HomeViewController *frontViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];//frantview
        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [revealController.navigationController setNavigationBarHidden:YES];
        app.window.rootViewController = revealController;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"problem");
     }];
}
-(void)removeNSUserValue
{
    //common Nsuser value
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userEmail"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPhone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userType"];
    //Expert Personal Nsuser value
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"firstName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lastName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"gender"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"profilePic"];
    
    //proffesnal info Nsuser Value
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"expiriance"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"designation"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"qualification"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"rate"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"skill"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"birthDate"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"aboutMe"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickName"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"is_filledValue"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"home"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"location"];
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"session"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ages"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mustHave"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cost"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginCheck"];
}
@end
