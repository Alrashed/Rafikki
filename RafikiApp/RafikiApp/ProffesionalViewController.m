//
//  ProffesionalViewController.m
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "ProffesionalViewController.h"
#import "ExpertHomeViewController.h"
#import "AFNetworking/AFNetworking.h"
@interface ProffesionalViewController ()

@end

@implementation ProffesionalViewController
@synthesize filedFlag;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    
    if ([filedFlag isEqualToString:@"Yes"])
    {
        cancelButton.hidden=NO;
    }
    
    [self passGetCategoryapi];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)submitAction:(id)sender
{
    catIdStr=[NSString stringWithFormat:@"%@,%@,%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"catIds"],[[NSUserDefaults standardUserDefaults] objectForKey:@"subcatIds"],[[NSUserDefaults standardUserDefaults] objectForKey:@"skillIds"]];
   /* [[NSUserDefaults standardUserDefaults] setObject:catConcatStr forKey:@"catIds"];
    [[NSUserDefaults standardUserDefaults] setObject:subCatConcatStr forKey:@"subcatIds"];
    [[NSUserDefaults standardUserDefaults] setObject:skillConcateStr forKey:@"skillIds"];*/
    NSString *catStr= addServiceButton.titleLabel.text;
    if (([txtExpiriance.text isEqualToString:@""]||txtExpiriance.text.length==0)||([txtQualification.text isEqualToString:@""]||txtQualification.text.length==0)||([txtDesignation.text isEqualToString:@""]||txtDesignation.text.length==0)||([txtRate.text isEqualToString:@""]||txtRate.text.length==0)||([txtSkill.text isEqualToString:@""]||txtSkill.text.length==0)||([catIdStr isEqualToString:@""]||catIdStr.length==0)||([txtSkill.text isEqualToString:@""]||txtSkill.text.length==0))
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Please enter all fields properly"
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
        NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        if ([filedFlag isEqualToString:@"Yes"])
        {
            [self passChangeModeApiWithUserid:userIdStr WithUserType:@"2"];
        }
        else
        {
            [self passProfessnalApi];
        }
    }
}
-(void)passChangeModeApiWithUserid:(NSString *)userid WithUserType:(NSString *)usertype
    {
        // http://cricyard.com/iphone/rafiki_app/service/change_user_type.php?userid=1&type=2
        NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/change_user_type.php"];
        NSDictionary *dictParams = @{@"userid":userid,@"type":usertype};
        NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"Response: %@",responseObject);
            NSString *filedStr=[responseObject valueForKey:@"is_filled"];
            [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"userType"];
            [self passProfessnalApi];
            NSLog(@"user isFiled:%@",filedStr);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"problem");
         }];
}
-(void)passProfessnalApi
{
    NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/register_professional_info.php"];//?=%@&=%@&=%@&=%@&%@&=%@&category_id=%@",txtExpiriance.text,txtQualification.text,txtDesignation.text,txtSkill.text,userIdStr,txtRate.text,catIdStr];
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
 /*   [[NSUserDefaults standardUserDefaults] setObject:catConcatStr forKey:@"catIds"];
    [[NSUserDefaults standardUserDefaults] setObject:subCatConcatStr forKey:@"subcatIds"];
    [[NSUserDefaults standardUserDefaults] setObject:skillConcateStr forKey:@"skillIds"];*/
     catIdStr=[NSString stringWithFormat:@"%@,%@,%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"catIds"],[[NSUserDefaults standardUserDefaults] objectForKey:@"subcatIds"],[[NSUserDefaults standardUserDefaults] objectForKey:@"skillIds"]];
        
    NSDictionary *dictParams = @{@"experience":txtExpiriance.text,
                                 @"qulification":txtQualification.text,
                                 @"designation":txtDesignation.text,
                                 @"location":txtSkill.text,
                                 @"userid":userIdStr,
                                 @"hour_rate":txtRate.text,
                                 @"category_id":catIdStr
                                 };
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        NSDictionary  *resposeDics=(NSDictionary *)responseObject;
        
        if ([[responseObject valueForKey:@"msg"] isEqualToString:@"Signup Successfully "])
        {
            [[NSUserDefaults standardUserDefaults] setObject:txtExpiriance.text forKey:@"expiriance"];
            [[NSUserDefaults standardUserDefaults] setObject:txtDesignation.text forKey:@"designation"];
            [[NSUserDefaults standardUserDefaults] setObject:txtQualification.text forKey:@"qualification"];
            [[NSUserDefaults standardUserDefaults] setObject:txtRate.text forKey:@"rate"];
            [[NSUserDefaults standardUserDefaults] setObject:txtSkill.text forKey:@"location"];

            [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"is_filled"] forKey:@"is_filledValue"];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            ExpertHomeViewController  *home=[[ExpertHomeViewController alloc] init];
            [self.navigationController pushViewController:home animated:YES];
        }
        else
        {
            NSLog(@"Some problem Occures");
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
-(void)passGetCategoryapi
{
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_category.php"];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_category.php"];
//    NSDictionary *dictParams = @{};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
     [manager GET:encodedString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         NSLog(@"Response: %@",responseObject);
         catDics=[responseObject valueForKey:@"cat"];
         NSLog(@"cat dics :%@",catDics);
         [catTbl reloadData];
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
- (IBAction)SkipAction:(id)sender
{
    HomeViewController *home=[[HomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}
- (IBAction)addServiceAction:(id)sender
{
//    catTbl.hidden=NO;
    AddCatViewController *add=[[AddCatViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return catDics.count;
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
    cell.textLabel.text=[[catDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
    catIdStr=[[catDics valueForKey:@"cat_id"] objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    addServiceButton.titleLabel.text=[[catDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
    [addServiceButton setTitle:[[catDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    catTbl.hidden=YES;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    [catTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (IBAction)cancelAction:(id)sender
{
    HomeViewController *frontViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];//frantview
    RearViewController *rearViewController = [[RearViewController alloc] init];//slider
    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    [revealController.navigationController setNavigationBarHidden:YES];
    app.window.rootViewController = revealController;
}
@end
