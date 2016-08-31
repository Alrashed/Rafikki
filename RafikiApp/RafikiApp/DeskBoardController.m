//
//  DeskBoardController.m
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "DeskBoardController.h"
#import "RateViewController.h"
#import "ProfileViewController.h"

#import "AFNetworking/AFNetworking.h"
#define  ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define  ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface DeskBoardController ()

@end

@implementation DeskBoardController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    paymentPopView.frame = CGRectMake(ScreenWidth*20/320, ScreenHeight*177/568, ScreenWidth*280/320, ScreenHeight*215/568);
    paymentTitleLb.frame=CGRectMake(ScreenWidth*43/320, ScreenHeight*14/568, ScreenWidth*193/320, ScreenHeight*26/568);
    lineImg.frame=CGRectMake(ScreenWidth*0/320, ScreenHeight*50/568, ScreenWidth*280/320, ScreenHeight*1/568);
    paymentIconImg.frame=CGRectMake(ScreenWidth*8/320, ScreenHeight*70/568, ScreenWidth*24/320, ScreenHeight*22/568);
    paymentBtn.frame=CGRectMake(ScreenWidth*10/320, ScreenHeight*166/568, ScreenWidth*261/320, ScreenHeight*42/568);
    paymentBg.frame=CGRectMake(ScreenWidth*0/320, ScreenHeight*0/568, ScreenWidth*280/320, ScreenHeight*215/568);
    self.paymentDetailTxt = [[STPPaymentCardTextField alloc] initWithFrame:CGRectMake(ScreenWidth*40/320, ScreenHeight*60/568, ScreenWidth*235/320, ScreenHeight*40/568)];
    self.paymentDetailTxt.delegate = self;
    self.paymentDetailTxt.backgroundColor=[UIColor whiteColor];
    self.paymentDetailTxt.layer.cornerRadius=self.paymentDetailTxt.frame.size.height/2;
    self.paymentDetailTxt.layer.borderColor=[UIColor colorWithRed:55.0/255.0 green:166.0/255.0 blue:145.0/255.0 alpha:1.0].CGColor;
    self.paymentDetailTxt.layer.borderWidth=1;
    [paymentPopView addSubview:self.paymentDetailTxt];
    paymentDiscripLbl.frame=CGRectMake(ScreenWidth*8/320, ScreenHeight*108/568, ScreenWidth*272/320, ScreenHeight*52/568);
    
    
    paymentBtn.layer.cornerRadius=paymentBtn.frame.size.height/2;
    paymentBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    paymentBtn.layer.borderWidth=1;
    paymentBtn.clipsToBounds=YES;

    
    paymentView.hidden=YES;
    
    chackDeskFlag=@"Hire request";
    totalCountedLbl.layer.cornerRadius=totalCountedLbl.frame.size.height/2;
    totalCountedLbl.clipsToBounds=YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passHireRquestApi];
    
    segmentView.layer.cornerRadius=5;
    segmentView.clipsToBounds=YES;
    
    [segment setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.5 alpha:0.2]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segment setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1.0 alpha:1.0]] forState:UIControlStateSelected  barMetrics:UIBarMetricsDefault];
    [sliderButton addTarget:self.revealViewController action:@selector(revealToggle:)forControlEvents:UIControlEventTouchUpInside];
        
    [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
    [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
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
    if (upcomingContDown ||[upcomingContDown isValid])
    {
        [upcomingContDown invalidate];
        upcomingContDown =nil;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (segment.selectedSegmentIndex==2)
    {
        upcomingContDown=[NSTimer scheduledTimerWithTimeInterval:50.0 target:self selector:@selector(passUpcomingJobApi) userInfo:nil repeats:YES];
    }
}
/*-(void)passCountedJobApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_counted_request.php"];
    NSDictionary *dictParams = @{@"userid":useridStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         countedReqArray=(NSMutableArray *)responseObject;
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
}*/
-(void)passHireRquestApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_invitation.php?userid=%@&user_type=user",useridStr];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_invitation.php"];
    NSDictionary *dictParams = @{@"userid":useridStr,@"user_type":@"user"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        hireReqarray  =(NSMutableArray *)responseObject;
        NSLog(@"hire job dics :%@",hireReqarray);
//        totalCountedLbl.text=[NSString stringWithFormat:@"%@",[hireReqarray valueForKey:@"counted"]];
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
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_upcoming_job.php?userid=%@&user_type=user",useridStr];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_upcoming_job.php"];
    NSDictionary *dictParams = @{@"userid":useridStr,@"user_type":@"user"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        NSLog(@"Response: %@",responseObject);
        upcommingReqArray  =(NSMutableArray *)responseObject;
        NSLog(@"upcommingReqArray job dics :%@",upcommingReqArray);
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
    
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_current_job.php?userid=%@&user_type=user",useridStr];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_current_job.php"];
    NSDictionary *dictParams = @{@"userid":useridStr,@"user_type":@"user"};
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
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/accept_reject_invite.php?invite_id=%@&type=reject&user_type=user",inviteId];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/accept_reject_invite.php"];
    NSDictionary *dictParams = @{@"invite_id":inviteId,@"type":@"reject",@"user_type":@"user"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        NSDictionary *cancelDics=(NSDictionary *)responseObject;
        NSLog(@"Cancel dics :%@",cancelDics);
        [self passHireRquestApi];
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
    NSDictionary *dictParams = @{@"invite_id":inviteId,@"type":@"accept",@"user_type":@"user"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSDictionary *cancelDics=(NSDictionary *)responseObject;
        NSLog(@"hire dics :%@",cancelDics);
        //[self passCountedJobApi];
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
    NSDictionary *dictParams = @{@"invite_id":inviteId,@"type":@"start",@"user_type":@"user"};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@",responseObject);
        NSDictionary *startDics= (NSDictionary *)responseObject;
        NSLog(@"Start dics :%@",startDics);
        [[NSUserDefaults standardUserDefaults] setObject:@"start" forKey:@"startJob"];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        TreckerViewController *treck=[[TreckerViewController alloc] init];
        treck.getperamArray=[upcommingReqArray valueForKey:@"data"];
        [self.navigationController pushViewController:treck animated:YES];
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
    if ([chackDeskFlag isEqualToString:@"Hire request"])
    {
        return [[hireReqarray valueForKey:@"data"]count];
    }
    else
    {
        return [[upcommingReqArray valueForKey:@"data"]count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
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
        
        cell.hireTitleLbl.text=[NSString stringWithFormat:@"%@ %@",[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
        cell.hireDesignationLbl.text=[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"start_time"];
        cell.hireDetailLbl.text=[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"skill"];
        cell.jobStatusLbl.text=[[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"status"];
        
        cell.profilePictureButton.tag=indexPath.row;
        [cell.profilePictureButton addTarget:self action:@selector(profilePictureAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.acceptBtn.hidden=YES;
        cell.cancelBtn.tag=[indexPath row];
        [cell.cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    /*else if ([chackDeskFlag isEqualToString:@"Counted"])
    {
        static NSString *simpleTableIdentifier = @"hireRequestCell";
        hireRequestCell *cell = (hireRequestCell *)[deskTbl dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        cell=nil;
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"hireRequestCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        [cell.hireUserimageview setImageWithURL:[NSURL URLWithString:[[[countedReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        cell.hireUserimageview.layer.cornerRadius=cell.hireUserimageview.frame.size.height/2;
        cell.hireUserimageview.clipsToBounds=YES;
        
        cell.hireTitleLbl.text=[NSString stringWithFormat:@"%@ %@",[[[countedReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[[countedReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
        cell.hireDesignationLbl.text=[[[countedReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"start_time"];
        cell.hireDetailLbl.text=[[[countedReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"skill"];
        cell.jobStatusLbl.text=[[[countedReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"status"];
        cell.cancelBtn.tag=[indexPath row];
        [cell.cancelBtn addTarget:self action:@selector(countedCancelAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.acceptBtn.tag=[indexPath row];
        [cell.acceptBtn addTarget:self action:@selector(countedAcceptAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
        [image setImageWithURL:[NSURL URLWithString:[[[upcommingReqArray valueForKey:@"data"]objectAtIndex:indexPath.row]valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
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
        titleLabel.text=[NSString stringWithFormat:@"%@ %@",[[[upcommingReqArray valueForKey:@"data"]objectAtIndex:indexPath.row]valueForKey:@"firstname"],[[[upcommingReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
        [cell addSubview:titleLabel];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        detailLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:12];
        detailLabel.frame = CGRectMake(60,30,[[UIScreen mainScreen] bounds].size.width-90,30);
        detailLabel.backgroundColor=[UIColor clearColor];
        detailLabel.textColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.4];
        detailLabel.text=[[[upcommingReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"skill"];
        detailLabel.numberOfLines=2;
        [cell addSubview:detailLabel];
        
       /* UIButton *startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        startBtn.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 20, 80, 35);
        startBtn.backgroundColor=[UIColor colorWithRed:2.0/255 green:113.0/255 blue:151.0/255 alpha:1.0];
        startBtn.layer.cornerRadius=startBtn.frame.size.height/2;
        startBtn.titleLabel.textColor=[UIColor whiteColor];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
        NSString *dateString = [dateFormatter stringFromDate: [NSDate date]]; //Put whatever date you want to convert

        [startBtn setTitle:[self getTimeDifferenceOf:dateString withCurrentdate:[[[upcommingReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"start_time"] ] forState:UIControlStateNormal];
//        [startBtn setTitle:@"Start" forState:UIControlStateNormal];
        startBtn.titleLabel.font=[UIFont fontWithName:@"Roboto-Medium" size:15];
        startBtn.tag=indexPath.row;
        [startBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:startBtn];*/
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonShowJobView *commo=[[CommonShowJobView alloc] init];
    if ([chackDeskFlag isEqualToString:@"Hire request"])
    {
        commo.jobDetailArray=[[hireReqarray valueForKey:@"data"] objectAtIndex:indexPath.row];
    }
   /* else if ([chackDeskFlag isEqualToString:@"Counted"])
    {
        commo.jobDetailArray=[[countedReqArray valueForKey:@"data"] objectAtIndex:indexPath.row];
    }*/
    else
    {
        commo.jobDetailArray=[[upcommingReqArray valueForKey:@"data"] objectAtIndex:indexPath.row];
    }
    [self.navigationController pushViewController:commo  animated:YES];
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
        return [NSString stringWithFormat:@"0%d:%d",hors,mintt];
    }
    else
    {
        return [NSString stringWithFormat:@"%d:%d",hors,mintt];
    }
}
-(IBAction)profilePictureAction:(id)sender
{
    ProfileViewController *pr=[[ProfileViewController alloc] init];
    if ([chackDeskFlag isEqualToString:@"Hire request"])
    {
        pr.expertIdStr =[[[hireReqarray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"expert_id"];
        pr.userFlag=@"expert";
        pr.chackviewFlagStr=@"guest";
    }
    else
    {
        pr.expertIdStr =[[[upcommingReqArray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"expert_id"];
        pr.userFlag=@"expert";
        pr.chackviewFlagStr=@"guest";
    }
    [self.navigationController pushViewController:pr animated:YES];
}
-(IBAction)completeAction:(id)sender
{
    TreckerViewController *rate=[[TreckerViewController alloc] init];
    int mytag=(int)[sender tag];
    rate.getperamArray=(NSMutableArray *)[[ongoingReqarray valueForKey:@"data"] objectAtIndex:mytag];
    [self.navigationController pushViewController:rate animated:YES];
}
-(IBAction)startAction:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if ([btn.currentTitle isEqualToString:@"Start Job"])
    {
        NSString *jobStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"startJob"];
        if ([jobStr isEqualToString:@""]||jobStr.length==0)
        {
            NSString *inviteId=[[[upcommingReqArray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"invite_id"];
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
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(IBAction)cancelAction:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Rafikki App"
                                  message:@"If you want to cancel job request then you have to pay penalty charge,would you like to pay penalty ?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    NSLog(@"cancel tag is :%ld",[sender tag]);
                                    cancelTag=[sender tag];
                                    paymentView.hidden=NO;
                                }];
    [alert addAction:yesButton];
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"No"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action)
                               {
                                   [alert dismissViewControllerAnimated:YES completion:nil];
                               }];
    [alert addAction:noButton];
    [self presentViewController:alert animated:YES completion:nil];
}
-(IBAction)countedCancelAction:(id)sender
{
    NSLog(@"cancel tag is :%ld",[sender tag]);
    NSString *inviteId=[[[countedReqArray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"invite_id"];
    cancelTag=[sender tag];
    [self passCancelRequestApiWithInviteId:inviteId];
}
-(IBAction)countedAcceptAction:(id)sender
{
    NSLog(@"cancel tag is :%ld",[sender tag]);
    acceptTag=[sender tag];
    NSString *inviteId=[[[countedReqArray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"invite_id"];
    [self passAcceptRequestApiWithInviteId:inviteId];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)paymentAction:(id)sender
{
    [[STPAPIClient sharedClient] createTokenWithCard:self.paymentDetailTxt.cardParams
                                          completion:^(STPToken *token, NSError *error)
     {
         if (error)
         {
             [self paymentView:self didFinish:error];
         }
         NSLog(@"Stripe Tocken is:%@",token);
         [self createBackendChargeWithToken:token
                                 completion:^(STPBackendChargeResult result, NSError *error)
          {
              if (error)
              {
                  [self paymentView:self didFinish:error];
                  return;
              }
              [self paymentView:self didFinish:nil];
          }];
     }];
}
- (IBAction)jobHistoryAction:(id)sender
{
    JobHistoryViewController *job=[[JobHistoryViewController alloc] init];
    [self.navigationController pushViewController:job animated:YES];
}
- (IBAction)activityAction:(id)sender
{
    if (segment.selectedSegmentIndex==0)
     {
         totalCountedLbl.textColor=[UIColor colorWithRed:69.0/255 green:172.0/255 blue:141.0/255 alpha:1];
         totalCountedLbl.backgroundColor=[UIColor whiteColor];
         chackDeskFlag=@"Hire request";
         [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         [self passHireRquestApi];
     }
    else
    {
        totalCountedLbl.textColor=[UIColor colorWithRed:69.0/255 green:172.0/255 blue:141.0/255 alpha:1];
        totalCountedLbl.backgroundColor=[UIColor whiteColor];
        
        chackDeskFlag=@"Upcoming job";
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passUpcomingJobApi];
        upcomingContDown=[NSTimer scheduledTimerWithTimeInterval:50.0 target:self selector:@selector(passUpcomingJobApi) userInfo:nil repeats:YES];
    }
}
#pragma StripMethod
- (void)paymentCardTextFieldDidChange:(STPPaymentCardTextField *)textField
{
    NSLog(textField.isValid ? @"Yes" : @"No");
    
    if (textField.isValid)
    {
        paymentBtn.enabled=YES;
        paymentBtn.alpha=1.0;
    }
    else
    {
        paymentBtn.enabled=NO;
        paymentBtn.alpha=0.5;
    }
}
- (void)paymentView:(DeskBoardController *)controller didFinish:(NSError *)error
{
    if (error) {
        [self presentError:error];
    } else {
        [self paymentSucceeded];
    }
}
- (void)presentError:(NSError *)error
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
}
- (void)paymentSucceeded {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Payment successfully created!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    });
}
- (void)createBackendChargeWithToken:(STPToken *)token completion:(STPTokenSubmissionHandler)completion
{
    if(token.tokenId.length != 0 && token.tokenId != (id)[NSNull null])
    {
        //        [self.activityIndicator startAnimating];
        NSLog(@"my token is :-> %@",token.tokenId);
        AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
        
        if (app.trecker||[app.trecker isValid])
        {
            [app.trecker invalidate];
        }
        int price=2;
        [MBProgressHUD showHUDAddedTo:paymentView animated:YES];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSURL *url = [NSURL URLWithString:@"http://cricyard.com/iphone/rafiki_app/service/stripe_payments.php"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        
        NSLog(@"Payment Token is : %@",token.tokenId);
        
        NSString *postBody = [NSString stringWithFormat:@"amount=%d&token=%@",price,token.tokenId];
        NSLog(@"Url is :- %@",postBody);
        NSData *data = [postBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)
         {
             NSMutableDictionary *dictData  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &connectionError];
             NSLog(@"dictData === %@",dictData);
             
             NSString *Message = [dictData objectForKey:@"msg"];
             if ([Message isEqualToString:@"sucess"])
             {
                 dispatch_sync(dispatch_get_main_queue(), ^{
                     [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                    
                     // what ever you want after payment.
                     NSString *inviteId=[[[hireReqarray valueForKey:@"data"] objectAtIndex:cancelTag]valueForKey:@"invite_id"];
                     [self passCancelRequestApiWithInviteId:inviteId];
                     [MBProgressHUD hideHUDForView:paymentView animated:YES];
                     paymentView.hidden=YES;

                 });
                 
             }
             else
             {
                 [MBProgressHUD hideHUDForView:paymentView animated:YES];
             }
         }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Rafikki" message:@"invalid token,please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == paymentView)
        {
            NSLog(@"Ok");
            paymentView.hidden=YES;
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
}
@end
