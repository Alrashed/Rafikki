//
//  PaymentDepositMethods.m
//  RafikiApp
//
//  Created by CI-05 on 3/4/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "PaymentDepositMethods.h"

@interface PaymentDepositMethods ()

@end

@implementation PaymentDepositMethods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
      [IQKeyboardManager sharedManager].enable=YES;
    
    addBankButton.layer.cornerRadius=addBankButton.frame.size.height/2;
    addBankButton.layer.borderColor=[UIColor whiteColor].CGColor;
    addBankButton.layer.borderWidth=1;
    addBankButton.clipsToBounds=YES;
    
    addPayPalButton.layer.cornerRadius=addPayPalButton.frame.size.height/2;
    addPayPalButton.layer.borderColor=[UIColor whiteColor].CGColor;
    addPayPalButton.layer.borderWidth=1;
    addPayPalButton.clipsToBounds=YES;
    
    paypalPopView.hidden=YES;
    bankPopView.hidden=YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passGetDepositeMethods];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark Pass APIs
-(void)passGetDepositeMethods
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_bank_detail.php"];
    NSDictionary *dictParams=@{@"expert_id":useridStr,};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         allDepositeRecDics=(NSMutableDictionary *)responseObject;
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         [depositTbl reloadData];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
-(void)passInsertBankDetailApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/insert_payment_method.php"];
    NSDictionary *dictParams=@{@"expert_id":useridStr,@"method_type":@"Bank",@"bank_account_no":bankAccountNoTxt.text,@"bank_account_name":banckAccountNameTxt.text,@"bank_ifsccode":backIFSCCodeTxt.text};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         banckAccountNameTxt.text=@"";
         bankAccountNoTxt.text=@"";
         backIFSCCodeTxt.text=@"";
         bankPopView.hidden=YES;
         [self passGetDepositeMethods];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
-(void)passUpdateBankApi
{
//     http://cricyard.com/iphone/rafiki_app/service/update_payment_method.php?id=1&expert_id=1&method_type=Bank&bank_account_no=101010101010110&bank_account_name=samir%20makadia&bank_ifsccode=samir6688
    
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/update_payment_method.php"];
    NSDictionary *dictParams=@{@"id":[NSString stringWithFormat:@"%d",upDateId],@"expert_id":useridStr,@"method_type":@"Bank",@"bank_account_no":bankAccountNoTxt.text,@"bank_account_name":banckAccountNameTxt.text,@"bank_ifsccode":backIFSCCodeTxt.text};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         banckAccountNameTxt.text=@"";
         bankAccountNoTxt.text=@"";
         backIFSCCodeTxt.text=@"";
         bankPopView.hidden=YES;
         [self passGetDepositeMethods];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
-(void)passDeleteApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/delete_payment_method.php"];
    NSDictionary *dictParams=@{@"id":[NSString stringWithFormat:@"%d",upDateId],@"expert_id":useridStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         [self passGetDepositeMethods];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
#pragma mark Table Delegate Methods -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[allDepositeRecDics valueForKey:@"data"]  valueForKey:@"bank"]count]==0)
    {
        return 1;
    }
    else
    {
        return [[[allDepositeRecDics valueForKey:@"data"] valueForKey:@"bank"] count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if ([[[allDepositeRecDics valueForKey:@"data"] valueForKey:@"bank"] count]==0)
        {
            static NSString *MyIdentifier = @"MyIdentifier";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            cell=nil;
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:MyIdentifier];
            }
            UILabel *dataLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            dataLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:12];
            dataLabel.frame = CGRectMake(10,30,[[UIScreen mainScreen] bounds].size.width,20);
            dataLabel.text = @"Bank account not added";
            dataLabel.backgroundColor=[UIColor clearColor];
            dataLabel.textColor = [UIColor blackColor];
            [cell addSubview:dataLabel];
            return cell;
        }
        else
        {
            static NSString *MyIdentifier = @"MyIdentifier";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
            cell=nil;
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier:MyIdentifier];
            }
            UILabel *bank_account_nameLbl = [[UILabel alloc] initWithFrame:CGRectZero];
            bank_account_nameLbl.font = [UIFont fontWithName:@"Roboto-Medium"size:12];
            bank_account_nameLbl.text=[NSString stringWithFormat:@"A/C No:  %@",[[[[allDepositeRecDics valueForKey:@"data"] valueForKey:@"bank"] objectAtIndex:indexPath.row] valueForKey:@"bank_account_no"]];
            bank_account_nameLbl.frame = CGRectMake(10,5,[[UIScreen mainScreen] bounds].size.width,20);
            bank_account_nameLbl.backgroundColor=[UIColor clearColor];
            bank_account_nameLbl.textColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.7];
            [cell addSubview:bank_account_nameLbl];
            
            UILabel *bank_account_name = [[UILabel alloc] initWithFrame:CGRectZero];
            bank_account_name.font = [UIFont fontWithName:@"Roboto-Medium"size:12];
            bank_account_name.text=[NSString stringWithFormat:@"A/C Name:  %@",[[[[allDepositeRecDics valueForKey:@"data"] valueForKey:@"bank"] objectAtIndex:indexPath.row] valueForKey:@"bank_account_name"]];
            bank_account_name.frame = CGRectMake(10,25,[[UIScreen mainScreen] bounds].size.width,20);
            bank_account_name.backgroundColor=[UIColor clearColor];
            bank_account_name.textColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.7];
            [cell addSubview:bank_account_name];
            
            UILabel *bank_ifsccode = [[UILabel alloc] initWithFrame:CGRectZero];
            bank_ifsccode.font = [UIFont fontWithName:@"Roboto-Medium"size:12];
            bank_ifsccode.text=[NSString stringWithFormat:@"Routing:  %@",[[[[allDepositeRecDics valueForKey:@"data"] valueForKey:@"bank"] objectAtIndex:indexPath.row] valueForKey:@"bank_ifsccode"]];
            bank_ifsccode.frame = CGRectMake(10,45,[[UIScreen mainScreen] bounds].size.width,20);
            bank_ifsccode.backgroundColor=[UIColor clearColor];
            bank_ifsccode.textColor = [UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.7];
            [cell addSubview:bank_ifsccode];
            
            UIButton *updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [updateButton setTitle:@"Update" forState:UIControlStateNormal];
            updateButton.titleLabel.font=[UIFont fontWithName:@"Roboto-Medium" size:15];
            [updateButton setTitleColor:[UIColor colorWithRed:69.0/255 green:172.0/255 blue:141.0/255 alpha:1] forState:UIControlStateNormal];
            updateButton.tag=indexPath.row;
            [updateButton setFrame:CGRectMake(10, 60, 50 , 30.0f)];
            [updateButton addTarget:self action:@selector(updateButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:updateButton];
            
            UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
            deleteButton.titleLabel.font=[UIFont fontWithName:@"Roboto-Medium" size:15];
            [deleteButton setTitleColor:[UIColor colorWithRed:69.0/255 green:172.0/255 blue:141.0/255 alpha:1] forState:UIControlStateNormal];
            deleteButton.tag=indexPath.row;
            [deleteButton setFrame:CGRectMake(70, 60, 50 , 30.0f)];
            [deleteButton addTarget:self action:@selector(deleteButtonButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:deleteButton];

            return cell;
        }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
          return 90;
    }
    else
    {
        return 64;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10,0,300,40)];
    customView.backgroundColor=[UIColor colorWithRed:69.0/255 green:172.0/255 blue:141.0/255 alpha:1];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.font = [UIFont fontWithName:@"Roboto-Medium"size:17];
    if (section ==0)
    {
        headerLabel.frame = CGRectMake(10,5,[[UIScreen mainScreen] bounds].size.width,20);
        headerLabel.text=@"Bank Detail";
    }
    headerLabel.backgroundColor=[UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    [customView addSubview:headerLabel];
    
    return customView;
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
    [depositTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
-(IBAction)updateButtonAction:(id)sender
{
    banckAccountNameTxt.text=[[[[allDepositeRecDics valueForKey:@"data"] valueForKey:@"bank"] objectAtIndex:[sender tag]] valueForKey:@"bank_account_name"];
     bankAccountNoTxt.text=[[[[allDepositeRecDics valueForKey:@"data"] valueForKey:@"bank"] objectAtIndex:[sender tag]] valueForKey:@"bank_account_no"];
    backIFSCCodeTxt.text=[[[[allDepositeRecDics valueForKey:@"data"] valueForKey:@"bank"] objectAtIndex:[sender tag]] valueForKey:@"bank_ifsccode"];
    upDateId=[[[[[allDepositeRecDics valueForKey:@"data"] valueForKey:@"bank"] objectAtIndex:[sender tag]] valueForKey:@"id"] intValue];
    
    [addBankButton setTitle:@"Update" forState:UIControlStateNormal];
    bankPopView.hidden=NO;
}
-(IBAction)deleteButtonButtonAction:(id)sender
{
    upDateId=[[[[[allDepositeRecDics valueForKey:@"data"] valueForKey:@"bank"] objectAtIndex:[sender tag]] valueForKey:@"id"] intValue];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passDeleteApi];
}
- (IBAction)bankAccountAddAction:(id)sender
{
    if ([bankAccountNoTxt.text isEqualToString:@""]||bankAccountNoTxt.text.length==0||[banckAccountNameTxt.text isEqualToString:@""]||bankAccountNoTxt.text.length==0||[backIFSCCodeTxt.text isEqualToString:@""]||backIFSCCodeTxt.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Please enter all required filed" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([addBankButton.currentTitle isEqualToString:@"Update"])
        {
            [self passUpdateBankApi];
        }
        else
        {
            [self passInsertBankDetailApi];
        }
    }
}
- (IBAction)addMethodAction:(id)sender
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"Deposite Methods" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Bank",nil];
    [self parentViewController];
    [action showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        [addBankButton setTitle:@"Add Bank Account" forState:UIControlStateNormal];
        NSLog(@"Bank");
        banckAccountNameTxt.text=@"";
        bankAccountNoTxt.text=@"";
        backIFSCCodeTxt.text=@"";
        bankPopView.hidden=NO;
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == paypalPopView)
        {
            NSLog(@"Ok");
            paypalPopView.hidden=YES;
        }
       else if ([touchs view] == bankPopView)
        {
            NSLog(@"Ok");
            bankPopView.hidden=YES;
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
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
