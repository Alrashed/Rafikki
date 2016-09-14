//
//  ExpertSignupVC.m
//  RafikiApp
//
//  Created by CI-05 on 4/21/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "ExpertSignupVC.h"

@interface ExpertSignupVC ()

@end

@implementation ExpertSignupVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    typeUserStr=@"Expert";

    if ([TxtUsername respondsToSelector:@selector(setAttributedPlaceholder:)])
    {
        UIColor *color = [UIColor colorWithRed:225.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        TxtUsername.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User name" attributes:@{NSForegroundColorAttributeName: color}];
        TxtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail address" attributes:@{NSForegroundColorAttributeName: color}];
        TxtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"•••••••••" attributes:@{NSForegroundColorAttributeName: color}];
        TxtPhoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Phone number" attributes:@{NSForegroundColorAttributeName: color}];
    }else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    signUpButton.layer.cornerRadius=signUpButton.frame.size.height/2;
    signUpButton.layer.borderWidth=1;
    signUpButton.layer.borderColor=[UIColor whiteColor].CGColor;
    [self setNeedsStatusBarAppearanceUpdate];
    
    signupScrollview.contentSize=CGSizeMake([[UIScreen mainScreen] bounds].size.width, signUpButton.frame.origin.y+signUpButton.frame.size.height);
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)signUpAction:(id)sender
{
    /*  PersonalViewController *pers=[[PersonalViewController alloc] init];
     pers.signupFlag=@"user";
     [self.navigationController pushViewController:pers animated:YES];*/
    
    if (([TxtEmail.text isEqualToString:@""]||TxtEmail.text.length==0) ||([TxtPassword.text isEqualToString:@""]||TxtPassword.text.length==0)||([TxtPhoneNumber.text isEqualToString:@""]||TxtPhoneNumber.text.length==0)||([TxtUsername.text isEqualToString:@""]||TxtUsername.text.length==0))
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
        if ([typeUserStr isEqualToString:@"Expert"])
        {
            [self signupExpertApiCall];
        }
    }
}
-(void)signupExpertApiCall
{
    //    NSString *tocken=[[NSUserDefaults standardUserDefaults] objectForKey:@"Tocken"];
    //    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/register.php?email=%@&username=%@&password=%@&phone_no=%@&user_type=2&device_token=%@",TxtEmail.text,TxtUsername.text,TxtPassword.text,TxtPhoneNumber.text,tocken];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/register.php"];
    NSString *tocken=[[NSUserDefaults standardUserDefaults] objectForKey:@"Tocken"];
    NSLog(@"my tocken:%@",tocken);
    NSDictionary *dictParams;
    if ([tocken isEqualToString:@""]||tocken ==(id)[NSNull null]||tocken==nil)
    {
        tocken=@"123123123123123123";
        dictParams = @{@"email":TxtEmail.text,@"password":TxtPassword.text,@"username":TxtUsername.text,@"phone_no" :TxtPhoneNumber.text,@"user_type":@"2",@"device_type":@"1",@"device_token":tocken};
    }
    else
    {
        dictParams = @{@"email":TxtEmail.text, @"password":TxtPassword.text,@"username":TxtUsername.text,@"phone_no" :TxtPhoneNumber.text,@"user_type":@"2",@"device_token":tocken,@"device_type":@"1"};
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@",responseObject);
        NSDictionary *ResponseDics=[responseObject valueForKey:@"data"];
        
        if ([[responseObject valueForKey:@"msg"] isEqualToString:@"Signup Successfully "])
        {
            [[NSUserDefaults standardUserDefaults] setObject:TxtUsername.text forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:TxtEmail.text forKey:@"userEmail"];
            [[NSUserDefaults standardUserDefaults] setObject:TxtPassword.text forKey:@"userPassword"];
            [[NSUserDefaults standardUserDefaults] setObject:TxtPhoneNumber.text forKey:@"userPhone"];
            
            NSString *myStr=[ResponseDics valueForKey:@"user_id"];
            NSLog(@"su joye:%@",myStr);
            [[NSUserDefaults standardUserDefaults] setObject:myStr forKey:@"userId"];
            [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"userType"];
            
             [[NSUserDefaults standardUserDefaults] setObject:[ResponseDics valueForKey:@"is_filled"] forKey:@"is_filledValue"];
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:@"Save & Next", nil];
            [alert show];
        }
        else
        {
            NSLog(@"Some problem Occures");
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"email Or username Exist"
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        NSLog(@"Zero is Called");
        NSLog(@"Is filed is:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"is_filledValue"]);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        VeryficationVC *pers=[[VeryficationVC alloc] init];
        pers.signupFlag=@"expert";
        [self.navigationController pushViewController:pers animated:YES];
    }
    else
    {
        NSLog(@"One is Called");
        [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen1_basic"];
        NSLog(@"Is filed is:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"is_filledValue"]);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        VeryficationVC *pers=[[VeryficationVC alloc] init];
        pers.signupFlag=@"expert";
        [self.navigationController pushViewController:pers animated:YES];
    }
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
