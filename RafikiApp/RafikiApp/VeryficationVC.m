//
//  VeryficationVC.m
//  RafikiApp
//
//  Created by CI-05 on 2/3/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "VeryficationVC.h"

@interface VeryficationVC ()
@end

@implementation VeryficationVC
@synthesize signupFlag;
- (void)viewDidLoad
{
    [super viewDidLoad];
    verfyButton.layer.cornerRadius=verfyButton.frame.size.height/2;
    verfyButton.layer.borderWidth=1;
    verfyButton.layer.borderColor=[UIColor whiteColor].CGColor;
    
    sendAginButton.layer.cornerRadius=sendAginButton.frame.size.height/2;
    sendAginButton.layer.borderWidth=1;
    sendAginButton.layer.borderColor=[UIColor whiteColor].CGColor;

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
- (IBAction)sendAginAction:(id)sender
{
    NSString *UserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/resendcode.php"];
    NSDictionary *dictParams = @{
                                 @"user_id":UserId
                                 };
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@",responseObject);
        NSDictionary  *resposeDics=(NSDictionary *) responseObject;
        NSLog(@"masseg is:%@",[resposeDics valueForKey:@"staus"]);
        if ([[responseObject valueForKey:@"staus"] isEqualToString:@"1"])
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"code sent Successfully"
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Some problem Occurs!!"
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
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
- (IBAction)veryfyAction:(id)sender
{
//    NSString *UserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/verifycode.php"];
//    NSDictionary *dictParams = @{
//                                 @"user_id":UserId,
//                                 @"code":emailTxt.text
//                                 };
//    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"Response: %@",responseObject);
//            NSDictionary  *resposeDics=(NSDictionary *) responseObject;
//            NSLog(@"masseg is:%@",[resposeDics valueForKey:@"staus"]);
            //resposeDics valueForKey:@"Signup Successfully ");
//            if ([[responseObject valueForKey:@"staus"] isEqualToString:@"1"])
    
            //{
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:@"Save & Next", nil];
                [alert show];
            //}
//            else
//            {
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Code Does not match!!"
//                                                                    message:nil
//                                                                   delegate:nil
//                                                          cancelButtonTitle:@"Ok"
//                                                          otherButtonTitles:nil];
//                [alertView show];
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            
//            // 4
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
//                                                                message:[error localizedDescription]
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"Ok"
//                                                      otherButtonTitles:nil];
//            [alertView show];
//        }];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"]isEqualToString:@"1"])
    {
        if (buttonIndex==0)
        {
            //Just Next
            PersonalViewController *pers=[[PersonalViewController alloc] init];
            pers.signupFlag=signupFlag;
            [self.navigationController pushViewController:pers animated:YES];
        }
        else
        {
            //Just Save & Next
            [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen2_verify"];
            PersonalViewController *pers=[[PersonalViewController alloc] init];
            pers.signupFlag=signupFlag;
            [self.navigationController pushViewController:pers animated:YES];
        }
        NSLog(@"Very Is Filed Value:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"is_filledValue"]);
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"is_filledValue"];
        
    }
    else
    {
        if (buttonIndex==0)
        {
            //Just Next
            PersonalViewController *pers=[[PersonalViewController alloc] init];
            pers.signupFlag=signupFlag;
            [self.navigationController pushViewController:pers animated:YES];
        }
        else
        {
            //Just Save & Next
            [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen2_verify"];
            PersonalViewController *pers=[[PersonalViewController alloc] init];
            pers.signupFlag=signupFlag;
            [self.navigationController pushViewController:pers animated:YES];
        }
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;

}
@end
