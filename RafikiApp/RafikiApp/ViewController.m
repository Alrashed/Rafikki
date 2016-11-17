//
//  ViewController.m
//  RafikiApp
//
//  Created by CI-05 on 12/24/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"
@import Firebase;


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    [self setNeedsStatusBarAppearanceUpdate];
    
    if ([TxtemailAddress respondsToSelector:@selector(setAttributedPlaceholder:)])
    {
        UIColor *color = [UIColor colorWithRed:225.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        TxtemailAddress.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail address" attributes:@{NSForegroundColorAttributeName: color}];
        Txtpassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"•••••••••" attributes:@{NSForegroundColorAttributeName: color}];
    }else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    signinButton.layer.cornerRadius=signinButton.frame.size.height/2;
    signinButton.layer.borderWidth=1;
    signinButton.layer.borderColor=[UIColor whiteColor].CGColor;
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signInAction:(id)sender
{
    if (([TxtemailAddress.text isEqualToString:@""]||TxtemailAddress.text.length==0)||([Txtpassword.text isEqualToString:@""]||Txtpassword.text.length==0))
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Invalid username and password!!"
                                      message:nil
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        //Handle your yes please button action here
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self signInApiCall];
    }
}

-(void)signInApiCall
{
    NSString *email = TxtemailAddress.text;
    NSString *password = Txtpassword.text;
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"profilePic"];
    [[FIRAuth auth] signInWithEmail:email
                           password:password
                         completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                             if (error) {
                                 NSLog(@"%@", error.localizedDescription);
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                 UIAlertController * alert=[UIAlertController
                                                                            alertControllerWithTitle:@"Please try again. We weren't able to find the email address and password combination you entered."
                                                                            message:nil
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                                 
                                                 UIAlertAction* yesButton = [UIAlertAction
                                                                             actionWithTitle:@"Ok"
                                                                             style:UIAlertActionStyleDefault
                                                                             handler:^(UIAlertAction * action)
                                                                             {
                                                                                 //Handle your yes please button action here
                                                                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                                                             }];
                                                 [alert addAction:yesButton];
                                                 [self presentViewController:alert animated:YES completion:nil];

                                 return;
                             }
                             
                             NSString *string1 = @"users/";
                             NSString *string2 = user.uid;
                             NSLog(@"%@", string2);
                             NSString *string3 = [string1 stringByAppendingString:string2];
                             NSLog(@"%@", string3);
                             
                             FIRDatabaseQuery *myUserQuery = [_ref child:string3];
                             
                             [[[myUserQuery queryOrderedByKey] queryEqualToValue:@"firstname"]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
                                 NSString *firstname = snapshot.value;
                                 NSLog(@"%@", firstname);
                                 [[NSUserDefaults standardUserDefaults] setValue:firstname forKey:@"firstName"];
                                 [[NSUserDefaults standardUserDefaults] synchronize];
                                 NSLog(@"%@", error.description);
                             }];
                             
                             [[[myUserQuery queryOrderedByKey] queryEqualToValue:@"lastname"]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
                                 NSString *lastname = snapshot.value;
                                  NSLog(@"%@", lastname);
                                 [[NSUserDefaults standardUserDefaults] setValue:lastname forKey:@"lastName"];
                                 [[NSUserDefaults standardUserDefaults] synchronize];
                             } withCancelBlock:^(NSError *error) {
                                 NSLog(@"%@", error.description);
                             }];
                             
                             [[[myUserQuery queryOrderedByKey] queryEqualToValue:@"profilePic"]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
                                 NSString *profilePic = snapshot.value;
                                 NSLog(@"%@", profilePic);
                                 [[NSUserDefaults standardUserDefaults] setValue:profilePic forKey:@"profilePic"];
                                 [[NSUserDefaults standardUserDefaults] synchronize];
                             } withCancelBlock:^(NSError *error) {
                                 NSLog(@"%@", error.description);
                             }];
                             [[[myUserQuery queryOrderedByKey] queryEqualToValue:@"birthdate"]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
                                 NSString *birthdate = snapshot.value;
                                 NSLog(@"%@", birthdate);
                                 [[NSUserDefaults standardUserDefaults] setValue:birthdate forKey:@"birthdate"];
                                 [[NSUserDefaults standardUserDefaults] synchronize];
                             } withCancelBlock:^(NSError *error) {
                                 NSLog(@"%@", error.description);
                             }];
                             [[[myUserQuery queryOrderedByKey] queryEqualToValue:@"about_me"]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
                                 NSString *about_me = snapshot.value;
                                 NSLog(@"%@", about_me);
                                 [[NSUserDefaults standardUserDefaults] setValue:about_me forKey:@"about_me"];
                                 [[NSUserDefaults standardUserDefaults] synchronize];
                             } withCancelBlock:^(NSError *error) {
                                 NSLog(@"%@", error.description);
                             }];
                             
                             [[[myUserQuery queryOrderedByKey] queryEqualToValue:@"userType"]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
                                 NSString *userType = snapshot.value;
                                 NSLog(@"%@", userType);
                                 [[NSUserDefaults standardUserDefaults] setValue:userType forKey:@"userType"];
                                 [[NSUserDefaults standardUserDefaults] synchronize];
                             } withCancelBlock:^(NSError *error) {
                                 NSLog(@"%@", error.description);
                             }];
                             
                             [[[myUserQuery queryOrderedByKey] queryEqualToValue:@"gender"]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
                                 NSString *gender = snapshot.value;
                                 NSLog(@"%@", gender);
                                 [[NSUserDefaults standardUserDefaults] setValue:gender forKey:@"gender"];
                                 [[NSUserDefaults standardUserDefaults] synchronize];
                             } withCancelBlock:^(NSError *error) {
                                 NSLog(@"%@", error.description);
                             }];
                             

                             
                             [[NSUserDefaults standardUserDefaults] setValue:user.uid forKey:@"userId"];
                             [[NSUserDefaults standardUserDefaults] synchronize];
                             [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"userPassword"];
                             [[NSUserDefaults standardUserDefaults] synchronize];
                             
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             
                             [self passUpdateDeviceToken];
                         }];
}


-(void)passUpdateDeviceToken
{
//    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//    NSString *tockenStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"Tocken"];

//    if ([tockenStr isEqualToString:@""]||tockenStr.length==0)
//    {
//        tockenStr=@"123456789789456123";
//    }
    //NSString *userTypeStr= @"1";
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    HomeViewController *home=[[HomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];

}
- (IBAction)signUpAction:(id)sender
{
    SignupViewController *signup=[[SignupViewController alloc] init];
    [self.navigationController pushViewController:signup animated:YES];
}

- (IBAction)homeAction:(id)sender
{
        HomeViewController *home=[[HomeViewController alloc] init];
        [self.navigationController pushViewController:home animated:YES];

}
@end
