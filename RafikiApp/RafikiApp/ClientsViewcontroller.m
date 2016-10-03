//
//  ClientsViewcontroller.m
//  RafikiApp
//
//  Created by CI-05 on 2/8/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "ClientsViewcontroller.h"

@interface ClientsViewcontroller ()

@end

@implementation ClientsViewcontroller

- (void)viewDidLoad
{
    [super viewDidLoad];
    addClientView.hidden=YES;
    addClientButton.layer.cornerRadius=addClientButton.frame.size.height/2;
    addClientButton.layer.borderWidth=1;
    addClientButton.layer.borderColor=[UIColor whiteColor].CGColor;
    
   [sliderButton addTarget:self.revealViewController action:@selector(revealToggle:)forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
    [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
    
    segmentView.layer.cornerRadius=5;
    segmentView.clipsToBounds=YES;
    
    [segment setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.5 alpha:0.2]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segment setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1.0 alpha:1.0]] forState:UIControlStateSelected  barMetrics:UIBarMetricsDefault];
    
    clientFlag=@"Rafikki";
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passGetAllClientsApi];
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
-(void)passGetAllClientsApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_clients.php"];
    NSDictionary *dictParams = @{@"userid":useridStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
         clientArray =(NSMutableArray *)responseObject;
        [clientsTbl reloadData];
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
-(void)passGetAllMenualClientApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_personal_client.php"];
    NSDictionary *dictParams = @{@"user_id":useridStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Menual Response: %@",responseObject);
        menualClientArray =(NSMutableArray *)responseObject;
        [clientsTbl reloadData];
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
-(void)passAddMenualClientApi
{
    // http://cricyard.com/iphone/rafiki_app/service/insert_personal_client.php?name=samir&email=samir@gmail.com&phone=123456789
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/insert_personal_client.php"];
    NSDictionary *dictParams = @{@"user_id":useridStr,@"name":nameTxt.text,@"email":emailTxt.text,@"phone":phoneTxt.text};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Menual Response: %@",responseObject);
        [self passGetAllMenualClientApi];
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
    if ([clientFlag isEqualToString:@"Rafikki"])
    {
        return [[clientArray valueForKey:@"data"] count];
    }
    else
    {
        return [[menualClientArray valueForKey:@"data"] count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    UILabel *titleLabel;
    UILabel *emailLbl;
    UILabel *phoneLbl;
    image.frame=CGRectMake(5, 10, 50, 50);
    image.layer.cornerRadius=image.frame.size.height/2;
    image.clipsToBounds=YES;
    [cell addSubview:image];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:14];
    titleLabel.frame = CGRectMake(60,10,[[UIScreen mainScreen] bounds].size.width,20);
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithRed:2/255 green:113/255 blue:151/255 alpha:0.7];
    [cell addSubview:titleLabel];
    
    emailLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    emailLbl.font = [UIFont fontWithName:@"Roboto-Medium"size:12];
    emailLbl.frame = CGRectMake(60,22,[[UIScreen mainScreen] bounds].size.width-90,30);
    emailLbl.backgroundColor=[UIColor clearColor];
    emailLbl.textColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.4];
    emailLbl.numberOfLines=2;
    [cell addSubview:emailLbl];
    
    phoneLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    phoneLbl.font = [UIFont fontWithName:@"Roboto-Medium"size:12];
    phoneLbl.frame = CGRectMake(60,38,[[UIScreen mainScreen] bounds].size.width-90,30);
    phoneLbl.backgroundColor=[UIColor clearColor];
    phoneLbl.textColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.4];
    phoneLbl.numberOfLines=2;
    [cell addSubview:phoneLbl];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([clientFlag isEqualToString:@"Rafikki"])
    {
         [image setImageWithURL:[NSURL URLWithString:[[[clientArray valueForKey:@"data"]objectAtIndex:indexPath.row]valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
         titleLabel.text=[NSString stringWithFormat:@"%@ %@",[[[clientArray valueForKey:@"data"]objectAtIndex:indexPath.row]valueForKey:@"firstname"],[[[clientArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
        emailLbl.text=[[[clientArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"email"];
        phoneLbl.text=[[[clientArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"phone_no"];
    }
    else
    {
        [image setImageWithURL:[NSURL URLWithString:[[[menualClientArray valueForKey:@"data"]objectAtIndex:indexPath.row]valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"iTunesArtwork@2x.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        titleLabel.text=[NSString stringWithFormat:@"%@",[[[menualClientArray valueForKey:@"data"]objectAtIndex:indexPath.row]valueForKey:@"name"]];
        emailLbl.text=[[[menualClientArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"email"];
        phoneLbl.text=[[[menualClientArray valueForKey:@"data"] objectAtIndex:indexPath.row] valueForKey:@"phone_number"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([clientFlag isEqualToString:@"Rafikki"])
    {
        UserProfileViewcontroller *pr=[[UserProfileViewcontroller alloc] init];
        pr.idStr=[[[clientArray valueForKey:@"data"] objectAtIndex:indexPath.row]valueForKey:@"user_id"];
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
    [clientsTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
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
- (IBAction)addClientAction:(id)sender
{
    if ([nameTxt.text isEqualToString:@""]||[emailTxt.text isEqualToString:@""]||[phoneTxt.text isEqualToString:@""]||[phoneTxt.text isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Please Enter All Fileds" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        clientFlag=@"Menual";
        [self passAddMenualClientApi];
        addClientView.hidden=YES;
    }
}
- (IBAction)addAction:(id)sender
{
    addClientView.hidden=NO;
}
- (IBAction)clientSegmentAction:(id)sender
{
    if (segment.selectedSegmentIndex==0)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        addButton.hidden=YES;
        clientFlag=@"Rafikki";
        [self passGetAllClientsApi];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        addButton.hidden=NO;
        clientFlag=@"Menual";
        [self passGetAllMenualClientApi];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == addClientView)
        {
            NSLog(@"Ok");
            addClientView.hidden=YES;
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
}
@end
