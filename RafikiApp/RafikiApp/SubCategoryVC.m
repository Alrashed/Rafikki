//
//  SubCategoryVC.m
//  RafikiApp
//
//  Created by CI-05 on 2/17/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "SubCategoryVC.h"

@interface SubCategoryVC ()

@end

@implementation SubCategoryVC
@synthesize catIdStr,catName;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    titleLbl.text=catName;
    [self passGetSubCategorys];
    // Do any additional setup after loading the view from its nib.
}
-(void)passGetSubCategorys
{
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_cat.php"];
    NSDictionary *peramDics=@{@"parent_id":catIdStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:peramDics success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        NSMutableDictionary *cat = (NSMutableDictionary *)responseObject;
        subCatDics=[cat valueForKey:@"cat"];
        NSLog(@"cat dics :%@",subCatDics);
        [subCatTbl reloadData];
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
    return subCatDics.count;
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
//    cell.textLabel.text=[[subCatDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
//    cell.textLabel.textColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.7];
//    cell.textLabel.font=[UIFont fontWithName:@"Roboto-Medium"size:14];
    UIImageView *image=[[UIImageView alloc] init];
    image.frame=CGRectMake(15, 10, 30, 30);
    
    ///iphone/rafiki_app/service/cat_icon/new/
    NSString *first=[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/cat_icon/new/%@.png",[[subCatDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row]];
    
    NSString* encodedUrl = [first stringByAddingPercentEscapesUsingEncoding:
                            NSUTF8StringEncoding];
    
    [image setImageWithURL:[NSURL URLWithString:encodedUrl] placeholderImage:[UIImage imageNamed:@"iTunesArtwork@2x.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    image.layer.cornerRadius=image.frame.size.width/2;
    image.clipsToBounds=YES;
    [cell addSubview:image];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:14];
    titleLabel.frame = CGRectMake(image.frame.size.width+10+15,15,[[UIScreen mainScreen] bounds].size.width,20);
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.7];
    titleLabel.text=[[subCatDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
    [cell addSubview:titleLabel];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SkillDisplayView *Skill=[[SkillDisplayView alloc] init];
    Skill.SubCatId=[[subCatDics valueForKey:@"cat_id"] objectAtIndex:indexPath.row];
    Skill.SkillName=[[subCatDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:Skill animated:YES];
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
    [subCatTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
