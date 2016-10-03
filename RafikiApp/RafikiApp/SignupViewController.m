//
//  SignupViewController.m
//  RafikiApp
//
//  Created by CI-05 on 12/24/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "SignupViewController.h"
#import "AFNetworking/AFNetworking.h"

@import Firebase;

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // [START create_database_reference]
    self.ref = [[FIRDatabase database] reference];
    // [END create_database_reference]
    
    NSInteger margin = 30;
    typeUserStr=@"User";
    
    self.switcher = [[DVSwitch alloc] initWithStringsArray:@[@"User", @"Expert"]];
    self.switcher.frame = CGRectMake(margin,margin*3, [[UIScreen mainScreen] bounds].size.width - margin * 2, 30);
    self.switcher.font = [UIFont fontWithName:@"Roboto-Regular" size:16];//user font color : 46  139  111
    self.switcher.backgroundColor = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0];
    self.switcher.sliderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.switcher.labelTextColorInsideSlider = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0];//0 161 217
    [self.view addSubview:self.switcher];
    [self.switcher setPressedHandler:^(NSUInteger index)
     {
         if (index==0)
         {
             typeUserStr=@"User";
//             [[[UIAlertView alloc] initWithTitle:@"0" message:@"Zero Click" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
             NSLog(@"User is Click");
         }
         else
         {
              typeUserStr=@"Expert";
             BecomeRafikkiVC *become=[[BecomeRafikkiVC alloc] init];
             [self.navigationController pushViewController:become animated:YES];
        // [[[UIAlertView alloc] initWithTitle:@"1" message:@"One Click" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
              NSLog(@"Expert is Click");
         }
         NSLog(@"Did press position on first switch at index: %lu", (unsigned long)index);
    }];
    
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
}
-(void)viewWillAppear:(BOOL)animated
{
    FIRUser *user = [FIRAuth auth].currentUser;
    self.navigationController.navigationBarHidden=YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        else
        {
            [self signupUserApiCall];
        }
    }
}
-(void)signupUserApiCall
{
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/register.php"];
//    NSString *tocken=[[NSUserDefaults standardUserDefaults] objectForKey:@"Tocken"];
//    NSLog(@"token is : %@",tocken);
//    NSDictionary *dictParams;
//    if ([tocken isEqualToString:@""]||tocken ==(id)[NSNull null]||tocken==nil)
//    {
//        tocken=@"123123123123123123";
//        dictParams = @{@"email":TxtEmail.text,@"password":TxtPassword.text,@"username":TxtUsername.text,@"phone_no" :TxtPhoneNumber.text,@"user_type":@"1",@"device_token":tocken,@"device_type":@"1"};
//    }
//    else
//    {
//        dictParams = @{@"email":TxtEmail.text,@"password":TxtPassword.text,@"username":TxtUsername.text,@"phone_no" :TxtPhoneNumber.text,@"user_type":@"1", @"device_token":tocken,@"device_type":@"1"};
//    }
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Response: %@",responseObject);
//         NSDictionary *userResponseDics=[responseObject valueForKey:@"data"];
//        
//        if ([[responseObject valueForKey:@"msg"] isEqualToString:@"Signup Successfully "])
//        {
//            [[NSUserDefaults standardUserDefaults] setObject:TxtUsername.text forKey:@"userName"];
//            [[NSUserDefaults standardUserDefaults] setObject:TxtEmail.text forKey:@"userEmail"];
//            [[NSUserDefaults standardUserDefaults] setObject:TxtPassword.text forKey:@"userPassword"];
//            [[NSUserDefaults standardUserDefaults] setObject:TxtPhoneNumber.text forKey:@"userPhone"];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:[userResponseDics valueForKey:@"user_id"] forKey:@"userId"];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:[userResponseDics valueForKey:@"is_filled"] forKey:@"is_filledValue"];
//            
//            NSLog(@"is Filed value is:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"is_filledValue"]);
//            
//            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"userType"];
//            [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"payment_method_add"];
//            
//            NSLog(@"my data is:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]);
//            
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:@"Save & Next", nil];
//            [alert show];
//        }
//        else
//        {
//            NSLog(@"Some problem Occures");
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"email Or username Exist"
//                                                                message:nil
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"Ok"
//                                                      otherButtonTitles:nil];
//            [alertView show];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        // 4
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
    NSString *email = TxtEmail.text;
    NSString *password = TxtPassword.text;

    [[FIRAuth auth] createUserWithEmail:email
                               password:password
                             completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                                 if (error) {
                                     NSLog(@"%@", error.localizedDescription);
                                     NSLog(@"Some problem Occures");
                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"email Or username Exist"
                                                                                                     message:nil
                                                                                                    delegate:nil
                                                                                           cancelButtonTitle:@"Ok"
                                                                                           otherButtonTitles:nil];
                                    [alertView show];
                                     return;
                                 }
                                 
                                 [[[_ref child:@"users"] child:user.uid]
                                  setValue:@{
                                             @"userType": typeUserStr,
                                             @"username": TxtUsername.text,
                                             @"email": email,
                                             @"phone": TxtPhoneNumber.text,                                                                                          
                                             }];
                                 
//                                 [self setDisplayName:user];
                                 // Email Subject
//                                 NSString *emailTitle = @"Rafikki verification code";
//                                 // Email Content
//                                 NSString *messageBody = @"Your verification code is 1234";
//                                 // To address
//                                 NSArray *toRecipents = [NSArray arrayWithObject:@"izaacgarcilazo@msn.com"];
//                                 
//                                 MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
                                 //mc.mailComposeDelegate = self;
                                 
//                                 NSString *tocken=[[NSUserDefaults standardUserDefaults] objectForKey:@"Tocken"];
//                                 NSLog(@"token is : %@",tocken);
//                                 NSDictionary *dictParams;
//                                 if ([tocken isEqualToString:@""]||tocken ==(id)[NSNull null]||tocken==nil)
//                                 {
//                                     tocken=@"123123123123123123";
//                                     dictParams = @{@"email":TxtEmail.text,@"password":TxtPassword.text,@"username":TxtUsername.text,@"phone_no" :TxtPhoneNumber.text,@"user_type":typeUserStr,@"device_token":tocken,@"device_type":@"1"};
//                                 }
//                                 else
//                                 {
//                                     dictParams = @{@"email":TxtEmail.text,@"password":TxtPassword.text,@"username":TxtUsername.text,@"phone_no" :TxtPhoneNumber.text,@"user_type":@"1", @"device_token":tocken,@"device_type":@"1"};
//                                 }
//                                 
//                                 
//                                 [mc setSubject:emailTitle];
//                                 [mc setMessageBody:messageBody isHTML:NO];
//                                 [mc setToRecipients:toRecipents];

                                 UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:@"Save & Next", nil];
                                             [alert show];
                             }];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        //Just Next
        VeryficationVC *pers=[[VeryficationVC alloc] init];
        pers.signupFlag=@"user";
        [self.navigationController pushViewController:pers animated:YES];
    }
    else
    {
        //Just Save & Next
      [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen1_basic"];
        VeryficationVC *pers=[[VeryficationVC alloc] init];
        pers.signupFlag=@"user";
        [self.navigationController pushViewController:pers animated:YES];
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
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                VeryficationVC *pers=[[VeryficationVC alloc] init];
                pers.signupFlag=@"expert";
                [self.navigationController pushViewController:pers animated:YES];
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
- (IBAction)loginAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
