//
//  JobHistoryViewController.m
//  RafikiApp
//
//  Created by CI-05 on 2/20/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "JobHistoryViewController.h"

@interface JobHistoryViewController ()

@end

@implementation JobHistoryViewController
@synthesize chackRootStr;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passPastjobApi];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)passPastjobApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    //    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_job_history.php?userid=%@&user_type=user",useridStr];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_job_history.php"];
    NSDictionary *dictParams;
    NSString *userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    if ([userTypeStr isEqualToString:@"1"])
    {
        dictParams = @{@"userid":useridStr,@"user_type":@"user"};
    }
    else
    {
        dictParams = @{@"userid":useridStr,@"user_type":@"expert"};
    }
    
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        pastReqArray  =(NSMutableArray *)responseObject;
        NSLog(@"past job dics :%@",pastReqArray);
        [tblJobHistory reloadData];
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
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[pastReqArray valueForKey:@"data"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PastJobCell";
    PastJobCell *cell = (PastJobCell *)[tblJobHistory dequeueReusableCellWithIdentifier:simpleTableIdentifier];
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
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonShowJobView *commo=[[CommonShowJobView alloc] init];
    commo.jobDetailArray=[[pastReqArray valueForKey:@"data"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:commo  animated:YES];
}
-(IBAction)profilePictureAction:(id)sender
{
    NSString *userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    if([userTypeStr isEqualToString:@"1"])
    {
        ProfileViewController *pr=[[ProfileViewController alloc] init];
        pr.expertIdStr =[[[pastReqArray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"expert_id"];
        pr.userFlag=@"expert";
        pr.chackviewFlagStr=@"guest";
        [self.navigationController pushViewController:pr animated:YES];
    }
    else
    {
        UserProfileViewcontroller *pr=[[UserProfileViewcontroller alloc] init];
        pr.idStr=[[[pastReqArray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"user_id"];
        pr.userFlag=@"user";
        pr.viewTypeStr=@"guest";
        [self.navigationController pushViewController:pr animated:YES];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    [tblJobHistory setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
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
- (IBAction)backAction:(id)sender
{
    if ([chackRootStr isEqualToString:@"Yes"])
    {
        NSString *userType=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
        if ([userType isEqualToString:@"1"])
        {
            HomeViewController *frontViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];//frantview
            RearViewController *rearViewController = [[RearViewController alloc] init];//slider
            UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
            UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
            SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [revealController.navigationController setNavigationBarHidden:YES];
            app.window.rootViewController = revealController;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        else
        {
            ExpertHomeViewController *frontViewController = [[ExpertHomeViewController alloc] initWithNibName:@"ExpertHomeViewController" bundle:nil];//frantview
            RearViewController *rearViewController = [[RearViewController alloc] init];//slider
            UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
            UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
            SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [revealController.navigationController setNavigationBarHidden:YES];
            app.window.rootViewController = revealController;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
