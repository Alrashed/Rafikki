//
//  HelpViewController.m
//  RafikiApp
//
//  Created by CI-05 on 2/15/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [sliderButton addTarget:self.revealViewController action:@selector(revealToggle:)forControlEvents:UIControlEventTouchUpInside];

    nameArray=[[NSMutableArray alloc] initWithObjects:@"Social",@"Terms and Condition",@"Privacy Policy", @"Contact us",nil];
    [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
    [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
}
- (void)didReceiveMemoryWarning {
    
       [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    cell.textLabel.font=[UIFont fontWithName:@"Roboto-Medium" size:16];
    cell.textLabel.textColor=[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.7];
    cell.textLabel.text=[nameArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    [helpTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        SocialViewController *social=[[SocialViewController alloc] init];
        [self.navigationController pushViewController:social animated:YES];
    }
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
