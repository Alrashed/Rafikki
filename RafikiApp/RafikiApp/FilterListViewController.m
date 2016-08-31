//
//  FilterListViewController.m
//  RafikiApp
//
//  Created by CI-05 on 3/8/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "FilterListViewController.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface FilterListViewController ()

@end

@implementation FilterListViewController
@synthesize catIdStr;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getCurrentLoc];
    // Do any additional setup after loading the view from its nib.
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
    latPub =coordinate.latitude;
    longiPub = coordinate.longitude;
    NSLog(@"Latitude  = %f", latPub);
    NSLog(@"Longitude = %f", longiPub);
    [self PassgetExpertWithLat:[NSString stringWithFormat:@"%f",latPub] AndLongi:[NSString stringWithFormat:@"%f",longiPub]];
}
-(void)PassgetExpertWithLat:(NSString *)lat AndLongi:(NSString *)longi
{
    NSString *urlStr;
    NSMutableDictionary *dictParams=[[NSMutableDictionary alloc] init];
    urlStr=[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_user_by_skill.php"];
    dictParams =(NSMutableDictionary *)@{@"skill_id":catIdStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@",responseObject);
        NSDictionary *cat=(NSDictionary *)responseObject;
        
        nearDics=[cat valueForKey:@"data"];
        [expertListTbl reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }];
}
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nearDics.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PastJobCell";
    PastJobCell *cell = (PastJobCell *)[expertListTbl dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    cell=nil;
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PastJobCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    [cell.pastjobUserimageView setImageWithURL:[NSURL URLWithString:[[nearDics valueForKey:@"user_image"] objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    cell.pastjobUserimageView.layer.cornerRadius=cell.pastjobUserimageView.frame.size.height/2;
    cell.pastjobUserimageView.clipsToBounds=YES;
    
    cell.pastjobTitleLbl.text=[NSString stringWithFormat:@"%@ %@",[[nearDics valueForKey:@"firstname"]objectAtIndex:indexPath.row],[[nearDics valueForKey:@"lastname"]objectAtIndex:indexPath.row]];
    
    cell.pastjobDetailLbl.text=[[nearDics valueForKey:@"email"]objectAtIndex:indexPath.row];
    
    cell.pastjobDesignationLbll.text=[[nearDics valueForKey:@"phone_no"]objectAtIndex:indexPath.row];
    
    cell.profilePictureButton.tag=indexPath.row;
    [cell.profilePictureButton addTarget:self action:@selector(profilePictureAction:) forControlEvents:UIControlEventTouchUpInside];
    
    float ratestar=[[[nearDics valueForKey:@"ratings"]objectAtIndex:indexPath.row] floatValue];
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
   
}
-(IBAction)profilePictureAction:(id)sender
{
        ProfileViewController *pr=[[ProfileViewController alloc] init];
        pr.expertIdStr =[[nearDics valueForKey:@"user_id"]objectAtIndex:[sender tag]];
        //[[[pastReqArray valueForKey:@"data"] objectAtIndex:[sender tag]]valueForKey:@"expert_id"];
        pr.userFlag=@"expert";
        pr.chackviewFlagStr=@"guest";
    pr.skillId=catIdStr;
        [self.navigationController pushViewController:pr animated:YES];
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
    [expertListTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
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
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)homeAction:(id)sender
{
    HomeViewController *home=[[HomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}
@end
