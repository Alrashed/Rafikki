//
//  EditShowSkill.m
//  RafikiApp
//
//  Created by CI-05 on 5/18/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "EditShowSkill.h"
#import "EditSkillVC.h"

@interface EditShowSkill ()

@end

@implementation EditShowSkill

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passGetAllskillApi];
}
-(void)passGetAllskillApi
{
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_user_skills.php"];
    NSDictionary *dictParams = @{@"user_id":userId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"skill Response is:%@",responseObject);
         skillDics=(NSMutableArray *)responseObject;
         [skillTbl reloadData];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
#pragma mark -tableview Deleagte methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return skillDics.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [skillTbl dequeueReusableCellWithIdentifier:CellIdentifier];
    cell=nil;
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    UILabel *expiriance=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width-10, 22)];
    expiriance.text=[NSString stringWithFormat:@"Skill: %@",[[skillDics objectAtIndex:indexPath.row]valueForKey:@"skill_name"]];
    expiriance.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
    expiriance.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
    [cell addSubview:expiriance];
    
    UILabel *skill_nameLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 32, [[UIScreen mainScreen] bounds].size.width-10, 22)];
    
    skill_nameLbl.text=[NSString stringWithFormat:@"Experience: %@",[[skillDics objectAtIndex:indexPath.row]valueForKey:@"expiriance"] ];//
        skill_nameLbl.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
    skill_nameLbl.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
    [cell addSubview:skill_nameLbl];
    
    UILabel *avg_session_timeLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 54, [[UIScreen mainScreen] bounds].size.width-10, 22)];
    
    avg_session_timeLbl.text=[NSString stringWithFormat:@"Avg Session: %@",[[skillDics objectAtIndex:indexPath.row]valueForKey:@"avg_session_time"] ];//
    avg_session_timeLbl.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
    avg_session_timeLbl.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
    [cell addSubview:avg_session_timeLbl];
    
    UILabel *price_per_sessionLbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 76, [[UIScreen mainScreen] bounds].size.width-10, 22)];
    
    price_per_sessionLbl.text=[NSString stringWithFormat:@"Price per session: %@",[[skillDics objectAtIndex:indexPath.row]valueForKey:@"price_per_session"] ];//
    price_per_sessionLbl.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
    price_per_sessionLbl.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
    [cell addSubview:price_per_sessionLbl];
    
    UILabel *ages=[[UILabel alloc] initWithFrame:CGRectMake(10, 98, [[UIScreen mainScreen] bounds].size.width-10, 22)];
    ages.text=[NSString stringWithFormat:@"Ages: %@",[[skillDics objectAtIndex:indexPath.row]valueForKey:@"ages"] ];//
    ages.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
    ages.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
    [cell addSubview:ages];
    
    UILabel *qulification=[[UILabel alloc] initWithFrame:CGRectMake(10, 120, [[UIScreen mainScreen] bounds].size.width-10, 22)];
    
    qulification.text=[NSString stringWithFormat:@"Qulification: %@",[[skillDics objectAtIndex:indexPath.row]valueForKey:@"qulification"] ];//
    qulification.font=[UIFont fontWithName:@"Roboto-Medium" size:15.0];
    qulification.textColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0];
    [cell addSubview:qulification];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
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
    [skillTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditSkillVC *edit=[[EditSkillVC alloc] init];
    edit.detailSkillArray=[skillDics objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:edit animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addSkillAction:(id)sender
{
    EditSkillVC *edit=[[EditSkillVC alloc] init];
    edit.ViewtypeStr=@"Add";
    [self.navigationController pushViewController:edit animated:YES];
}
- (IBAction)homeAction:(id)sender
{
    HomeViewController *home=[[HomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
