//
//  UserProfileViewcontroller.m
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "UserProfileViewcontroller.h"
#import "AFNetworking/AFNetworking.h"
@interface UserProfileViewcontroller ()

@end

@implementation UserProfileViewcontroller
@synthesize idStr,userFlag,viewTypeStr;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    pastReqArray=[[NSMutableArray alloc] init];
    
    if ([viewTypeStr isEqualToString:@"owner"])
    {
          [sliderButton addTarget:self.revealViewController action:@selector(revealToggle:)forControlEvents:UIControlEventTouchUpInside];
        messageButton.hidden=YES;
        
        editButton.hidden=NO;
        logoutButton.hidden=NO;
        
        [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
        [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
    }
    else
    {
        [sliderButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        [sliderButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        messageButton.hidden=NO;
        editButton.hidden=YES;
        logoutButton.hidden=YES;

        messageButton.layer.cornerRadius=messageButton.frame.size.height/2;
        messageButton.layer.borderColor=[UIColor colorWithRed:46.0/255 green:139.0/255 blue:111.0/255 alpha:1].CGColor;
        messageButton.layer.borderWidth=1;
        
        messageButton.clipsToBounds=YES;
    }
    userimageview.layer.cornerRadius=userimageview.frame.size.width/2;
    userimageview.clipsToBounds=YES;
}
-(IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passPastjobApi];
//    titleLbl.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
//    NSString *profileStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"profilePic"];
}
-(void)passPastjobApi
{
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_user_profile.php"];
    NSDictionary *dictParams = @{@"userid":idStr,@"user_type":userFlag};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        
        pastReqArray  =(NSMutableArray *) responseObject;
        //        hireReqarray=[hireReqarray valueForKey:@"data"];
        NSLog(@"past job dics :%@",pastReqArray);
        titleLbl.text=[NSString stringWithFormat:@"%@ %@",[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"firstname"],[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"lastname"]];
        NSString *profileStr=[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"user_image"];
        NSString *birthdate=[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"birthdate"];
        if ([birthdate isEqualToString:@""]||birthdate==nil)
        {
            cityLbl.text=@"Birth Date not added!!";
        }
        else
        {
            cityLbl.text=[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"birthdate"];
        }
        NSString *aboutStr=[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"about_me"];
        if ([aboutStr isEqualToString:@""]||aboutStr==nil)
        {
            aboutMeLbl.text=@"About me not Added!";
        }
        else
        {
            aboutMeLbl.text=aboutStr;
        }
        NSString *nicknameStr=[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"nikename"];
       /* if ([nicknameStr isEqualToString:@""]||nicknameStr==nil)
        {
            nickNameLbl.text=@"nick name not Added!";
        }
        else
        {
            nickNameLbl.text=nicknameStr;
        }*/
        NSString *ratestar=[NSString stringWithFormat:@"%@",[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"ratings"]];
        if ([ratestar isEqualToString:@"1"])
        {
            img1.hidden=NO;
        }
        else if([ratestar isEqualToString:@"2"])
        {
                        img1.hidden=NO;
                        img2.hidden=NO;
        }
        else if([ratestar isEqualToString:@"3"])
        {
            img1.hidden=NO;
            img2.hidden=NO;
            img3.hidden=NO;
        }
        else if([ratestar isEqualToString:@"4"])
        {
            img1.hidden=NO;
            img2.hidden=NO;
            img3.hidden=NO;
            img4.hidden=NO;
        }
        else if([ratestar isEqualToString:@"5"])
        {
            img1.hidden=NO;
            img2.hidden=NO;
            img3.hidden=NO;
            img4.hidden=NO;
            img5.hidden=NO;
        }
        else
        {
            
        }
        [userimageview setImageWithURL:[NSURL URLWithString:profileStr] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [profileTbl reloadData];
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
    
   /* NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_user_profile.php?userid=%@&user_type=%@",idStr,userFlag];
    __weak ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setCompletionBlock:^{
        // Use when fetching text data
        pastReqArray  =(NSMutableArray *) [request.responseString JSONValue];
        //        hireReqarray=[hireReqarray valueForKey:@"data"];
        NSLog(@"past job dics :%@",pastReqArray);
        titleLbl.text=[NSString stringWithFormat:@"%@ %@",[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"firstname"],[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"lastname"]];
        NSString *profileStr=[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"user_image"];
        
        [userimageview setImageWithURL:[NSURL URLWithString:profileStr] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [profileTbl reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"my data is:%@",error);
    }];
    [request startAsynchronous];*/
}
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[pastReqArray valueForKey:@"data"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PastJobCell";
    PastJobCell *cell = (PastJobCell *)[profileTbl dequeueReusableCellWithIdentifier:simpleTableIdentifier];
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
    cell.pastjobDetailLbl.text=[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"review_text"];
    
    cell.pastjobDesignationLbll.text=[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"email"];
    
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
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*CommonShowJobView *commo=[[CommonShowJobView alloc] init];
    commo.jobDetailStr=[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"job_detail"];
    commo.priceStr=[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"price"];
    commo.priceTypeStr=[[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"price_type"];
    [self.navigationController pushViewController:commo  animated:YES];*/
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10,0,300,40)];
    customView.backgroundColor=[UIColor colorWithRed:237.0/255 green:238.0/255 blue:238.0/255 alpha:1];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    headerLabel.textAlignment=UITextAlignmentCenter;
    headerLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:14];
    headerLabel.frame = CGRectMake(0,5,[[UIScreen mainScreen] bounds].size.width,20);
    headerLabel.text = @"Job History";//Invitation
    headerLabel.textColor = [UIColor colorWithRed:111.0/255 green:111.0/255 blue:111.0/255 alpha:1];
    [customView addSubview:headerLabel];
    
    return customView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
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
- (IBAction)logOutAction:(id)sender
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
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"catIds"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"subcatIds"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"skillIds"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"is_filledValue"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"home"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"location"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loginCheck"];
}
- (IBAction)editAction:(id)sender
{
    EditViewController *edit=[[EditViewController alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
}
- (IBAction)messageAction:(id)sender
{
    ChatViewController *chat=[[ChatViewController alloc] init];
    chat.fromUserIdStr=[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"user_id"];
    chat.fromUserName=[NSString stringWithFormat:@"%@ %@",[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"firstname"],[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"lastname"]];
    chat.fromUserDesignation=[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"about_me"];
    chat.fromUserProfilepicStr=[[pastReqArray valueForKey:@"user_profile"] valueForKey:@"user_image"];
    [self.navigationController pushViewController:chat animated:YES];
}
@end
