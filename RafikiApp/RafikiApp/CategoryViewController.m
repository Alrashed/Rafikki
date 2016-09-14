//
//  CategoryViewController.m
//  RafikiApp
//
//  Created by CI-05 on 1/2/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "CategoryViewController.h"
#import "AFNetworking/AFNetworking.h"
@interface CategoryViewController ()

@end
@implementation CategoryViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passGetCategorys];
    // Do any additional setup after loading the view from its nib.
}
-(void)passGetCategorys
{
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_cat.php"];
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        NSMutableDictionary *cat = (NSMutableDictionary *)responseObject;
        catDics=[cat valueForKey:@"cat"];
        NSLog(@"cat dics :%@",catDics);
        [catTbl reloadData];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     }];
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
//    cell.textLabel.text=[[catDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
//    cell.textLabel.textColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.7];
//    cell.textLabel.font=[UIFont fontWithName:@"Roboto-Medium"size:14];
 
        UIImageView *image=[[UIImageView alloc] init];
        image.frame=CGRectMake(15, 10, 30, 30);
        
        NSString *first=[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/cat_icon/new/%@.png",[[catDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row]];
        
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
        titleLabel.text=[[catDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
        [cell addSubview:titleLabel];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubCategoryVC *sub=[[SubCategoryVC alloc] init];
    sub.catIdStr=[[catDics valueForKey:@"cat_id"] objectAtIndex:indexPath.row];
    sub.catName=[[catDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:sub animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    [catTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
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
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
