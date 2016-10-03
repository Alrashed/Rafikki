
/*

 Copyright (c) 2013 Joan Lluch <joan.lluch@sweetwilliamsl.com>
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is furnished
 to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 Original code:
 Copyright (c) 2011, Philip Kluz (Philip.Kluz@zuui.org)
 
*/

#import "RearViewController.h"

#import "SWRevealViewController.h"
#import "MapViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "NotificationController.h"
#import "DeskBoardController.h"
#import "UserProfileViewcontroller.h"

#import "SocialViewController.h"

#import "ViewController.h"
#import "SettingViewController.h"
#import "ExpertHomeViewController.h"
#import "ProfileViewController.h"
#import "ClientsViewcontroller.h"
#import "AddCatViewController.h"
#import "SocialSecurityVC.h"

@interface RearViewController()
{
    NSInteger _presentedRow;
}

@end

@implementation RearViewController

@synthesize rearTableView = _rearTableView,userImageview,userNameLbl,upperArray,lowerArray,iconArray,ExpertUpperArray,ExpertIconArray,mode;

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    
    userImageview.layer.cornerRadius=userImageview.frame.size.width/2;
    userImageview.clipsToBounds=YES;
    userImageview.layer.borderWidth=2;
    userImageview.layer.borderColor=[UIColor whiteColor].CGColor;
    [self setNeedsStatusBarAppearanceUpdate];
    NSString *fname = [[NSUserDefaults standardUserDefaults] stringForKey:@"firstName"];
    NSString *lname = [[NSUserDefaults standardUserDefaults] stringForKey:@"lastName"];
    NSString *name=[NSString stringWithFormat:@"%@ %@",fname, lname];
    
    if (name ==(id)[NSNull null]||[name isEqualToString:@"(null) (null)"]||name==nil)
    {
        userNameLbl.text=@"Rafikki User";
        userTypeStr=@"1";
        modeButton.hidden=YES;
        modeView.hidden=YES;
        modeDropDownImg.hidden=YES;
        modeUserImageView.hidden=YES;
    }
    else
    {
        NSString *profileStr=[[NSUserDefaults standardUserDefaults] valueForKey:@"profilePic"];
        NSData *data3 = [[NSData alloc]initWithBase64EncodedString:profileStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *ret = [UIImage imageWithData:data3];
        userNameLbl.text= name;
        modeButton.hidden=NO;
        modeDropDownImg.hidden=NO;
        modeUserImageView.hidden=NO;
        modeView.hidden=YES;
        [userImageview setImage:ret];

        if ([userTypeStr isEqualToString:@"1"])
        {
            [modeButton setTitle:@"User" forState:UIControlStateNormal];
        }
        else
        {
            [modeButton setTitle:@"Rafikki" forState:UIControlStateNormal];
        }
    }
    
    upperArray=[[NSMutableArray alloc] initWithObjects:@"Home",@"Map",@"Activity",@"Messages",@"Payment",@"Setting",@"Help",nil];
    iconArray=[[NSMutableArray alloc] initWithObjects:@"home",@"near",@"desk",@"message",@"paycheck",@"settingicon",@"help",nil];
    lowerArray=[[NSMutableArray alloc] initWithObjects:@"Setting",@"Social",@"Help",@"Contact us", nil];
    
    ExpertUpperArray=[[NSMutableArray alloc] initWithObjects:@"Schedule",@"Messages",@"Clients",@"Paycheck",@"Setting",@"Help",nil];
    ExpertIconArray=[[NSMutableArray alloc] initWithObjects:@"home",@"message",@"client",@"paycheck",@"settingicon",@"help",nil];
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];

    if (![useridStr isEqualToString:@""]||useridStr!=nil||useridStr!=(id)[NSNull null])
    {
        [self.rearTableView reloadData];
    }
}
-(void)passGetCounterApiWithIndex:(NSUInteger)index
{
//    NSString *useridStr=[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];
//    
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service//count_unread_message.php"];
//    NSDictionary *dictParams = @{@"user_id":useridStr};
//    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Response: %@",responseObject);
//        if (![[responseObject valueForKey:@"total_message_count"]isEqualToString:@"0"])
//        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            UITableViewCell *cell = (UITableViewCell *) [self.rearTableView cellForRowAtIndexPath:indexPath];
            for (UIView *subview in [cell subviews])
            {
                if ([subview isKindOfClass:[UILabel class]])
                {
                    UILabel *MessageCounterLbl=(UILabel *)subview;
//                    MessageCounterLbl.text=[responseObject valueForKey:@"total_message_count"];
                    MessageCounterLbl.text=@"total_message_count";
                    MessageCounterLbl.font=[UIFont fontWithName:@"Roboto-Medium" size:15];
                    MessageCounterLbl.textColor=[UIColor redColor];
                    MessageCounterLbl.textAlignment=NSTextAlignmentCenter;
                    MessageCounterLbl.layer.cornerRadius=MessageCounterLbl.frame.size.width/2;
                    MessageCounterLbl.layer.backgroundColor=[UIColor whiteColor].CGColor;
                    MessageCounterLbl.clipsToBounds=YES;
                }
            }
        //}
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         NSLog(@"problem");
//     }];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma marl - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if ([userTypeStr isEqualToString:@"1"])
        {
            //User
            return upperArray.count;
        }
        else
        {
            return ExpertUpperArray.count;
        }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    NSInteger row = indexPath.row;
    cell=nil;
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
//    NSString *text = nil;
    UIImageView *arroImage;
    if (indexPath.section==0)
    {
        cell.textLabel.font=[UIFont fontWithName:@"Roboto-Medium" size:16];
        if ([userTypeStr isEqualToString:@"1"])
        {
            cell.textLabel.text=[upperArray objectAtIndex:indexPath.row];
            cell.imageView.image=[UIImage imageNamed:[iconArray objectAtIndex:indexPath.row]];
            
            if ([[upperArray objectAtIndex:indexPath.row] isEqualToString:@"Messages"])
            {
//                NSString *name=[NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"],[[NSUserDefaults standardUserDefaults] objectForKey:@"lastName"]];
                
                NSString *fname = [[NSUserDefaults standardUserDefaults] stringForKey:@"firstName"];
                NSString *lname = [[NSUserDefaults standardUserDefaults] stringForKey:@"lastName"];
                NSString *name=[NSString stringWithFormat:@"%@ %@",fname, lname];
                
                if (name ==(id)[NSNull null]||[name isEqualToString:@"(null) (null)"]||name==nil)
                {
                    
                }
                else
                {
                    [self passGetCounterApiWithIndex:indexPath.row];
                }
                
                UILabel *messageCounterLbl=[[UILabel alloc] init];
                messageCounterLbl.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width-120, 18, 20, 20);
                [cell addSubview:messageCounterLbl];
            }
        }
        else
        {
            cell.textLabel.text=[ExpertUpperArray objectAtIndex:indexPath.row];
            cell.imageView.image=[UIImage imageNamed:[ExpertIconArray objectAtIndex:indexPath.row]];
            
            if ([[ExpertUpperArray objectAtIndex:indexPath.row] isEqualToString:@"Messages"])
            {
                [self passGetCounterApiWithIndex:indexPath.row];
                UILabel *messageCounterLbl=[[UILabel alloc] init];
                messageCounterLbl.frame=CGRectMake([[UIScreen mainScreen] bounds].size.width-120, 18, 20, 20);
                [cell addSubview:messageCounterLbl];
            }
        }
        arroImage=[[UIImageView alloc] init];
        arroImage.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-100, 20, 18, 18);
        //arroImage.image=[UIImage imageNamed:@"Slider_arrow"];
    }
   /* else if (indexPath.section==1)
    {
//        cell.imageView.image = [UIImage new];
        [arroImage removeFromSuperview];
        cell.textLabel.font=[UIFont fontWithName:@"Roboto-Medium" size:14];
        cell.textLabel.text=[lowerArray objectAtIndex:indexPath.row];
        arroImage=[[UIImageView alloc] init];
        arroImage.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-100, 10, 18, 18);
       // arroImage.image=[UIImage imageNamed:@"Slider_arrow"];
    }
    else
    {
        if (indexPath.row==0)
        {
            if ([userNameLbl.text isEqualToString:@"SignUp / SignIn"])
            {
                
            }
            else
            {
                CGRect myFrame = CGRectMake([UIScreen mainScreen].bounds.size.width-130, 15.0f, 250.0f, 25.0f);
                //create and initialize the slider
                mode = [[UISwitch alloc] initWithFrame:myFrame];
                //set the switch to ON
                mode.onTintColor=[UIColor clearColor];
                [mode setOn:NO];
                //attach action method to the switch when the value changes
                [mode addTarget:self
                                  action:@selector(switchIsChanged:)
                        forControlEvents:UIControlEventValueChanged];
                
                [cell addSubview:mode];
                cell.textLabel.text=@"Change mode";
                cell.imageView.image=[UIImage imageNamed:@"switch"];
            }
        }
        else
        {
            if ([userNameLbl.text isEqualToString:@"SignUp / SignIn"])
            {
            }
            else
            {
                cell.textLabel.text=@"Log out";
                cell.imageView.image=[UIImage imageNamed:@"logout"];
            }
        }
    }*/
    [cell addSubview:arroImage];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *VC = nil;
    
    if (indexPath.section==0)
    {
        if ([userTypeStr isEqualToString:@"1"])
        {
            if (indexPath.row==0)
            {
                VC = [[HomeViewController alloc] init];
            }
            else if (indexPath.row==1)
            {
                VC = [[MapViewController alloc] init];
            }
            else if (indexPath.row==2)
            {
                if ([userNameLbl.text isEqualToString:@"Rafikki User"])
                {
                  UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"you need to sign in" message:@"you want to sign in?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                    [alert show];
                      return ;
                }
                else
                {
                    VC=[[DeskBoardController alloc] init];
                }
            }
            else if (indexPath.row==3)
            {
                if ([userNameLbl.text isEqualToString:@"Rafikki User"])
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"you need to sign in" message:@"you want to sign in?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                    [alert show];
                      return ;
                }
                else
                {
                    VC=[[MessageViewController alloc] init];
                }
            }
            else if (indexPath.row==4)
            {
                //User Payment
                if ([userNameLbl.text isEqualToString:@"Rafikki User"])
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"you need to sign in" message:@"you want to sign in?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                    [alert show];
                    return ;
                }
                else
                {
                    VC=[[SelectAndAddPaymentVC alloc] init];
                }
            }
            else if (indexPath.row==5)
            {
                if ([userNameLbl.text isEqualToString:@"Rafikki User"])
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"you need to sign in" message:@"you want to sign in ?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
                    [alert show];
                    return ;
                }
                else
                {
                    VC=[[SettingViewController alloc] init];
                }
                
            }
            else if (indexPath.row==6)
            {
                VC=[[HelpViewController alloc] init];
            }
            else
            {
                return ;
            }
        }
        else
        {
            if (indexPath.row==0)
            {
                VC=[[ExpertHomeViewController alloc] init];
            }
            else if(indexPath.row==1)
            {
                VC=[[MessageViewController alloc] init];
            }
            else if (indexPath.row==2)
            {
                 VC=[[ClientsViewcontroller alloc] init];
            }
            else if (indexPath.row==3)
            {
                VC=[[PaychackViewController alloc] init];
            }
            else if (indexPath.row==4)
            {
                VC=[[SettingViewController alloc] init];
            }
            else if (indexPath.row==5)
            {
                //help
                VC=[[HelpViewController alloc] init];
            }
            /*else if (indexPath.row==6)
            {
                NSString *jobStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"startJob"];
                if ([jobStr isEqualToString:@""]||jobStr.length==0)
                {
//                    [self passStatusApi];
                    ViewController *frontViewController = [[ViewController alloc] initWithNibName:@"Viewcontroller" bundle:nil];//frantview
                    RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                    [revealController.navigationController setNavigationBarHidden:YES];
                    app.window.rootViewController = revealController;
                }
                else
                {
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Opps" message:@"One job already started if you want logout you have to complete this job in Ongoing Section" delegate:self cancelButtonTitle:@"Ok git it" otherButtonTitles:nil, nil];
                    alert.tag=5000;
                    [alert show];
                }
            }*/
            else
            {
                return;
            }
        }
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:VC];
        [navigationController setNavigationBarHidden:YES];
        [self.revealViewController pushFrontViewController:navigationController animated:YES];
    }
    /*else if (indexPath.section==1)
    {
        if (indexPath.row==0)
        {
            VC=[[SettingViewController alloc] init];
        }
        else if (indexPath.row==1)
        {
            VC=[[SocialViewController alloc] init];
        }
        else
        {
            return;
        }
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:VC];
        [navigationController setNavigationBarHidden:YES];
        [self.revealViewController pushFrontViewController:navigationController animated:YES];
    }*/
   /* else
    {
        if ([userNameLbl.text isEqualToString:@"SignUp / SignIn"])
        {
            return;
        }
        else
        {
            //chack job is start Or not...
            NSString *jobStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"startJob"];
            if ([jobStr isEqualToString:@""]||jobStr.length==0)
            {
                [self passStatusApi];
                ViewController *frontViewController = [[ViewController alloc] initWithNibName:@"Viewcontroller" bundle:nil];//frantview
                RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                [revealController.navigationController setNavigationBarHidden:YES];
                app.window.rootViewController = revealController;
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Opps" message:@"One job already started if you want logout you have to complete this job in Ongoing Section" delegate:self cancelButtonTitle:@"Ok git it" otherButtonTitles:nil, nil];
                alert.tag=5000;
                [alert show];
            }
        }
    }*/
}
- (IBAction)rafikkiModeAction:(id)sender
{
    NSString *jobStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"startJob"];
    if ([jobStr isEqualToString:@""]||jobStr.length==0)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
        NSString *issFiledStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"is_filledValue"];
        
        if([userTypeStr isEqualToString:@"1"])
        {
            if ([issFiledStr isEqualToString:@"0"])
            {
                SocialSecurityVC *frontViewController = [[SocialSecurityVC alloc] initWithNibName:@"SocialSecurityVC" bundle:nil];//frantview
                frontViewController.filedFlag=@"Yes";
                RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                [revealController.navigationController setNavigationBarHidden:YES];
                app.window.rootViewController = revealController;
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"userType"];
                [self passChangeModeApiWithUserid:userIdStr WithUserType:@"2"];
                userTypeStr=@"2";
            }
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"userType"];
            [self passChangeModeApiWithUserid:userIdStr WithUserType:@"1"];
            userTypeStr=@"1";
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Opps" message:@"One job already started if you want start another job you have to stop current job" delegate:self cancelButtonTitle:@"Ok git it" otherButtonTitles:nil, nil];
        alert.tag=5000;
        [alert show];
    }
    [modeButton setTitle:@"Rafikki" forState:UIControlStateNormal];
    modeView.hidden=YES;
}
- (IBAction)userModeAction:(id)sender
{
    NSString *jobStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"startJob"];
    if ([jobStr isEqualToString:@""]||jobStr.length==0)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
        NSString *issFiledStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"is_filledValue"];
        
        if([userTypeStr isEqualToString:@"1"])
        {
            if ([issFiledStr isEqualToString:@"0"])
            {
               /* ProffesionalViewController *frontViewController = [[ProffesionalViewController alloc] initWithNibName:@"ProffesionalViewController" bundle:nil];//frantview
                frontViewController.filedFlag=@"Yes";
                RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                [revealController.navigationController setNavigationBarHidden:YES];
                app.window.rootViewController = revealController;*/
                
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"userType"];
                [self passChangeModeApiWithUserid:userIdStr WithUserType:@"1"];
                userTypeStr=@"1";
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"userType"];
                [self passChangeModeApiWithUserid:userIdStr WithUserType:@"2"];
                userTypeStr=@"2";
            }
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"userType"];
            [self passChangeModeApiWithUserid:userIdStr WithUserType:@"1"];
            userTypeStr=@"1";
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Opps" message:@"One job already started if you want start another job you have to stop current job" delegate:self cancelButtonTitle:@"Ok git it" otherButtonTitles:nil, nil];
        alert.tag=5000;
        [alert show];
    }
    [modeButton setTitle:@"User" forState:UIControlStateNormal];
    modeView.hidden=YES;
}
- (IBAction)modeAction:(id)sender
{
    if (modeView.hidden==YES)
    {
        modeView.hidden=NO;
    }
    else
    {
        modeView.hidden=YES;
    }
}
- (IBAction)modeSwitchAction:(id)sender
{
    NSString *jobStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"startJob"];
    if ([jobStr isEqualToString:@""]||jobStr.length==0)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
        NSString *issFiledStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"is_filledValue"];

        if([userTypeStr isEqualToString:@"1"])
        {
            if ([issFiledStr isEqualToString:@"0"])
            {
                ProffesionalViewController *frontViewController = [[ProffesionalViewController alloc] initWithNibName:@"ProffesionalViewController" bundle:nil];//frantview
                frontViewController.filedFlag=@"Yes";
                RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                [revealController.navigationController setNavigationBarHidden:YES];
                app.window.rootViewController = revealController;
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"userType"];
                [self passChangeModeApiWithUserid:userIdStr WithUserType:@"2"];
                userTypeStr=@"2";
            }
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"userType"];
            [self passChangeModeApiWithUserid:userIdStr WithUserType:@"1"];
            userTypeStr=@"1";
        }
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Opps" message:@"One job already started if you want start another job you have to stop current job" delegate:self cancelButtonTitle:@"Ok git it" otherButtonTitles:nil, nil];
        alert.tag=5000;
        [alert show];
    }
}
-(void)passChangeModeApiWithUserid:(NSString *)userid WithUserType:(NSString *)usertype
{
    // http://cricyard.com/iphone/rafiki_app/service/change_user_type.php?userid=1&type=2
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/change_user_type.php"];
//    NSDictionary *dictParams = @{@"userid":userid,@"type":usertype};
//    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"Response: %@",responseObject);
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//
//        NSString *filedStr=[responseObject valueForKey:@"is_filled"];
//        NSLog(@"user isFiled:%@",filedStr);
//        [self.rearTableView reloadData];
//        
//        if ([userTypeStr isEqualToString:@"1"])
//        {
            HomeViewController *VC = nil;
            VC = [[HomeViewController alloc] init];
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:VC];
            [navigationController setNavigationBarHidden:YES];
            [self.revealViewController pushFrontViewController:navigationController animated:YES];
//        }
//        else
//        {
//            ExpertHomeViewController *VC = nil;
//            VC = [[ExpertHomeViewController alloc] init];
//            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:VC];
//            [navigationController setNavigationBarHidden:YES];
//            [self.revealViewController pushFrontViewController:navigationController animated:YES];
//        }
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         NSLog(@"problem");
//     }];
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"problem");
     }];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 100)];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.rearTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section==0)
//    {
        return 0;
//    }
//    else if (section==1)
//    {
//        return 15;
//    }
//    else
//    {
//        return 15;
//    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section==0)
//    {
        return  50;
//    }
//    else if (indexPath.section==1)
//    {
//        return 35;
//    }
//    else
//    {
//        return 60;
//    }
}
/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10,0,300,0)];
        return customView;
    }
    else
    {
        UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10,0,300,15)];
        customView.backgroundColor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1];
        UIImageView *image=[[UIImageView alloc] init];
        image.frame=CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 15);
        image.image=[UIImage imageNamed:@"line_seprate"];
        [customView addSubview:image];
        return customView;
    }
}*/
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
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
//
//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    NSLog( @"%@: REAR", NSStringFromSelector(_cmd));
//}
- (IBAction)userProfileAction:(id)sender
{
    if ([userTypeStr isEqualToString:@"1"])
    {
        if ([userNameLbl.text isEqualToString:@"Rafikki User"])
        {
            ViewController *frontViewController = [[ViewController alloc] initWithNibName:@"Viewcontroller" bundle:nil];//frantview
            RearViewController *rearViewController = [[RearViewController alloc] init];//slider
            UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
            UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
            SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [revealController.navigationController setNavigationBarHidden:YES];
            app.window.rootViewController = revealController;
        }
        else
        {
            UserProfileViewcontroller *VC = nil;
            VC = [[UserProfileViewcontroller alloc] init];
            VC.idStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
            VC.userFlag=@"user";
            VC.viewTypeStr=@"owner";
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:VC];
            [navigationController setNavigationBarHidden:YES];
            [self.revealViewController pushFrontViewController:navigationController animated:YES];
        }
    }
    else if([userTypeStr isEqualToString:@"2"])
    {
        ProfileViewController *VC = nil;
        VC = [[ProfileViewController alloc] init];
        VC.expertIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        VC.chackviewFlagStr=@"ExpertOwner";
        VC.userFlag=@"expert";
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:VC];
        [navigationController setNavigationBarHidden:YES];
        [self.revealViewController pushFrontViewController:navigationController animated:YES];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==5000)
    {
    }
    else
    {
        if (buttonIndex ==1)
        {
        }
        else
        {
            ViewController *frontViewController = [[ViewController alloc] initWithNibName:@"Viewcontroller" bundle:nil];//frantview
            RearViewController *rearViewController = [[RearViewController alloc] init];//slider
            UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
            UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
            SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
            [revealController.navigationController setNavigationBarHidden:YES];
            app.window.rootViewController = revealController;
        }
    }
    
    
}
@end
