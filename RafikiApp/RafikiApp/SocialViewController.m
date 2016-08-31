//
//  SocialViewController.m
//  RafikiApp
//
//  Created by CI-05 on 1/1/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "SocialViewController.h"

@interface SocialViewController ()

@end

@implementation SocialViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
    nameArray=[[NSMutableArray alloc] initWithObjects:@"Facebook",@"Twitter",@"Email",@"Instagram",@"Message", nil];
    iconArray=[[NSMutableArray alloc] initWithObjects:@"fb",@"twitter",@"gmail",@"insta",@"Txtmessage", nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return nameArray.count;
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
    image.frame=CGRectMake(5, 10, 30, 30);
    image.image=[UIImage imageNamed:[iconArray objectAtIndex:indexPath.row]];
    image.layer.cornerRadius=image.frame.size.height/2;
    image.clipsToBounds=YES;
    [cell addSubview:image];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:16];
    titleLabel.frame = CGRectMake(45,15,[[UIScreen mainScreen] bounds].size.width,20);
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.7];
    titleLabel.text=[nameArray objectAtIndex:indexPath.row];
    [cell addSubview:titleLabel];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        //facebook
        SLComposeViewController *controller = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeFacebook];
        SLComposeViewControllerCompletionHandler myBlock =
        ^(SLComposeViewControllerResult result)
        {
            if (result == SLComposeViewControllerResultCancelled)
            {
                NSLog(@"Cancelled");
            }
            else if(result == SLComposeViewControllerResultDone)
            {
                NSLog(@"Done");
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Successfully Shared!" message:@"This Post Is Shared Successfully On Facebook!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            [controller dismissViewControllerAnimated:YES completion:nil];
        };
        controller.completionHandler = myBlock;
        [controller addImage:[UIImage imageNamed:@"photo"]];
//        [controller setInitialText:[NSString stringWithFormat:@"%@",[DataArry objectAtIndex:btn.tag]]];
        //Adding the Text to the facebook post value from iOS
        
        //[controller setInitialText:[NSString stringWithFormat:@"%@",[DataArry objectAtIndex:btn.tag]]];
        //Adding the URL to the facebook post value from iOS
        [controller addURL:[NSURL URLWithString:@"https://play.google.com/store/apps/details?id="]];
        //Adding the Text to the facebook post value from iOS
        [self presentViewController:controller animated:YES completion:nil];
    }
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
    [socialTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
