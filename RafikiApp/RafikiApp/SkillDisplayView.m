//
//  SkillDisplayView.m
//  RafikiApp
//
//  Created by CI-05 on 5/12/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "SkillDisplayView.h"

@interface SkillDisplayView ()

@end

@implementation SkillDisplayView
@synthesize SkillName,SubCatId;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    titleLbl.text=SkillName;
    [self passSkillApi];
}
-(void)passSkillApi
{
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_cat.php"];
    NSDictionary *peramDics=@{@"parent_id":SubCatId};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:peramDics success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         NSMutableDictionary *cat = (NSMutableDictionary *)responseObject;
         skillDics=[cat valueForKey:@"cat"];
         NSLog(@"cat dics :%@",skillDics);
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
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }];
}
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return skillDics.count;
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
    cell.textLabel.text=[[skillDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.7];
    cell.textLabel.font=[UIFont fontWithName:@"Roboto-Medium"size:14];
    /* UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
     titleLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:14];
     titleLabel.frame = CGRectMake(10,0,[[UIScreen mainScreen] bounds].size.width,20);
     titleLabel.backgroundColor=[UIColor clearColor];
     titleLabel.textColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.7];
     titleLabel.text=[[subCatDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
     [cell addSubview:titleLabel];*/
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterListViewController *filter=[[FilterListViewController alloc] init];
    filter.catIdStr=[[skillDics valueForKey:@"cat_id"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:filter animated:YES];
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
    [skillTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
