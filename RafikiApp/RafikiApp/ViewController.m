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
    
    // [START create_database_reference]
    self.ref = [[FIRDatabase database] reference];
    // [END create_database_reference]
    
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
//    if (user) {
//        [self signedIn:user];
//    }
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
                                      alertControllerWithTitle:@"Please enter username and password"
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
        [self signInApiCall];
    }
}

//- (IBAction)signInAction:(id)sender {
//    // Sign In with credentials.
//    NSString *email = TxtemailAddress.text;
//    NSString *password = Txtpassword.text;
//    [[FIRAuth auth] signInWithEmail:email
//                           password:password
//                         completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
//                             if (error) {
//                                 NSLog(@"%@", error.localizedDescription);
//                                 return;
//                             }
//                             //[self signedIn:user];
//                             //[self signInApiCall];
//                         }];
//}

-(void)signInApiCall
{
    // Sign In with credentials.
    NSString *email = TxtemailAddress.text;
    NSString *password = Txtpassword.text;
    [[FIRAuth auth] signInWithEmail:email
                           password:password
                         completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
                             if (error) {
                                 NSLog(@"%@", error.localizedDescription);
                                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                 UIAlertController * alert=[UIAlertController
                                                                            alertControllerWithTitle:@"Invalid username and password!!"
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

                                 return;
                             }
                             NSLog(@"start search for users");
                             NSDictionary *dictParams = @{
                                                          @"email":TxtemailAddress.text,
                                                          @"password":Txtpassword.text
                                                        };
                             NSDictionary  *resposeDics;
                             NSDictionary *dict;
                             NSString *key;
                             
                             //FIRDatabaseQuery *userprofile = [[[_ref child:@"users"] child:user.uid]];
                             
                             FIRDatabaseQuery *userprofile = [[_ref child:@"users"]queryEqualToValue:user.uid];
                             
                             [userprofile observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
                    
                                 NSLog(@"%@ was %@ meters tall", snapshot.key, snapshot.value[@"firstname"]);
                             }];
                             NSLog(@"%@ppppppppp", key);
                             
                             [[_ref queryOrderedByChild:@"firstname"]
                              observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
                                  NSLog(@"%@ was %@ meters tall", snapshot.key, snapshot.value[@"firstname"]);
                              }];
                             
                             FIRDatabaseQuery *myTopPostsQuery = [_ref child:@"users"];
                             [myTopPostsQuery observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
                                 NSLog(@"%@", snapshot.value);
                             } withCancelBlock:^(NSError *error) {
                                 NSLog(@"%@", error.description);
                             }];
                             NSLog(@"%@ppppppdffffppp", myTopPostsQuery);


                    
                             
                             
                             
                            [[NSUserDefaults standardUserDefaults] setObject:@"abc"  forKey:@"userName"];
                            [[NSUserDefaults standardUserDefaults] setObject:@"abc"  forKey:@"userName"];
                             
                            [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"]valueForKey:@"email"] forKey:@"userEmail"];
                            [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"password"] forKey:@"userPassword"];
                            [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"] valueForKey:@"phone_no"] forKey:@"userPhone"];
                            [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"] valueForKey:@"user_id"] forKey:@"userId"];
                                                 NSLog(@"my data is:%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"userId"]);
                             
                                                 [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"user_type"] forKey:@"userType"];
                             
                                                 [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"firstname"] forKey:@"firstName"];
                                                 [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"lastname"] forKey:@"lastName"];
                                                 [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"gender"] forKey:@"gender"];
                                                 [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"user_image"] forKey:@"profilePic"];
                                                 [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"birthdate"] forKey:@"birthDate"];
                             
                                                 [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"about_me"] forKey:@"aboutMe"];
                             
                                                 [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"nikename"] forKey:@"nickName"];
                             
                                                 NSLog(@"my password:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"]);
//                                                 NSLog(@"my birth date is:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"birthDate"]);
//                                                 [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"is_filled"] forKey:@"is_filledValue"];
//                             //                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"home"] forKey:@"home"];
//                                                 
//                                                 [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"payment_method_add"] forKey:@"payment_method_add"];
//                                                 
//                                                 [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"loginCheck"];
//                                                 [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"location"] forKey:@"location"];
//                                                 [self passUpdateDeviceToken];
                             //[self signedIn:user];
                             //[self signInApiCall];
                                                                                       
                             [self passUpdateDeviceToken];
                         }];
//    NSString *tocken=[[NSUserDefaults standardUserDefaults] objectForKey:@"Tocken"];
 //   NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/login.php?email=%@&password=%@",TxtemailAddress.text,Txtpassword.text];
//
//   NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/login.php"];//?email=%@&password=%@",TxtemailAddress.text,Txtpassword.text];
//    NSDictionary *dictParams = @{
//                                 @"email":TxtemailAddress.text,
//                                 @"password":Txtpassword.text
//                                 };
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    
//    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Response: %@",responseObject);
//        if (responseObject)
//        {
//            NSDictionary  *resposeDics= (NSDictionary *) responseObject;
//            if ([[resposeDics valueForKey:@"staus"] integerValue]==1)
//            {
//                NSString *userTypeStr=[[resposeDics valueForKey:@"data"] valueForKey:@"user_type"];
//                if ([userTypeStr isEqualToString:@"1"])
//                {
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"username"]  forKey:@"userName"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"]valueForKey:@"email"] forKey:@"userEmail"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"password"] forKey:@"userPassword"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"] valueForKey:@"phone_no"] forKey:@"userPhone"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"] valueForKey:@"user_id"] forKey:@"userId"];
//                    NSLog(@"my data is:%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"userId"]);
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"user_type"] forKey:@"userType"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"firstname"] forKey:@"firstName"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"lastname"] forKey:@"lastName"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"gender"] forKey:@"gender"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"user_image"] forKey:@"profilePic"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"birthdate"] forKey:@"birthDate"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"about_me"] forKey:@"aboutMe"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"nikename"] forKey:@"nickName"];
//                    
//                    NSLog(@"my password:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"]);
//                    NSLog(@"my birth date is:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"birthDate"]);
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"is_filled"] forKey:@"is_filledValue"];
////                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"home"] forKey:@"home"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"payment_method_add"] forKey:@"payment_method_add"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"loginCheck"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"location"] forKey:@"location"];
//                    [self passUpdateDeviceToken];
//                }
//                else
//                {
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"username"]  forKey:@"userName"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"]valueForKey:@"email"] forKey:@"userEmail"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"password"] forKey:@"userPassword"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"] valueForKey:@"phone_no"] forKey:@"userPhone"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics  valueForKey:@"data"] valueForKey:@"user_id"] forKey:@"userId"];
//                    NSLog(@"my data is:%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"userId"]);
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"user_type"] forKey:@"userType"];
//                    
//                    //expert personal data
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"firstname"] forKey:@"firstName"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"lastname"] forKey:@"lastName"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"gender"] forKey:@"gender"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"user_image"] forKey:@"profilePic"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"is_filled"] forKey:@"is_filledValue"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"about_me"] forKey:@"aboutMe"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"goverment_id"] forKey:@"photoId"];
//                    
//                    //
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"social_security_number"] forKey:@"socialSecurityNumber"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"birthdate"] forKey:@"birthDate"];
//                    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"loginCheck"];
//
//                    //expert proff data
//                  /*  [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"experience"] forKey:@"expiriance"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"designation"] forKey:@"designation"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"qulification"] forKey:@"qualification"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"hour_rate"] forKey:@"rate"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"skill"] forKey:@"skill"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"birthdate"] forKey:@"birthDate"];
//                    
//                    NSLog(@"my bday:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"birthDate"]);
//                    
//                       [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"about_me"] forKey:@"aboutMe"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[resposeDics valueForKey:@"data"] valueForKey:@"nikename"] forKey:@"nickName"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"is_filled"] forKey:@"is_filledValue"];
//                    
//                     [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"home"] forKey:@"home"];
//                    
//                     [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"location"] forKey:@"location"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"session_time"] forKey:@"session"];
//                    
//                      [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"ages"] forKey:@"ages"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"must_have"] forKey:@"mustHave"];
//                    
//                     [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"cost"] forKey:@"cost"];
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"experience"] forKey:@"expiriance"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"designation"] forKey:@"designation"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"qulification"] forKey:@"qualification"];*/
//                    
//                    [self passUpdateDeviceToken];
//
//                    
//                }
//            }
//            else
//            {
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                UIAlertController * alert=[UIAlertController
//                                           alertControllerWithTitle:@"Invalid username and password!!"
//                                           message:nil
//                                           preferredStyle:UIAlertControllerStyleAlert];
//                
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"Ok"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action)
//                                            {
//                                                //Handel your yes please button action here
//                                                [alert dismissViewControllerAnimated:YES completion:nil];
//                                            }];
//                [alert addAction:yesButton];
//                [self presentViewController:alert animated:YES completion:nil];
//            }
//        }
//     }
//    failure:^(AFHTTPRequestOperation *operation, NSError *error)
//    {
//    }];
}
-(void)passUpdateDeviceToken
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *tockenStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"Tocken"];

    if ([tockenStr isEqualToString:@""]||tockenStr.length==0)
    {
        tockenStr=@"123456789789456123";
    }
//
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/update_device_token.php"];
    //NSDictionary *dictParams = @{@"userid":useridStr,@"device_token":tockenStr,@"device_type":@"1"};
//    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//        NSLog(@"Response: %@",responseObject);
//         
//         NSString *userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
//         if ([userTypeStr isEqualToString:@"1"])
//         {
//             [MBProgressHUD hideHUDForView:self.view animated:YES];
//             HomeViewController *home=[[HomeViewController alloc] init];
//             [self.navigationController pushViewController:home animated:YES];
//         }
//         else
//         {
//             [MBProgressHUD hideHUDForView:self.view animated:YES];
//             ExpertHomeViewController *Exhome=[[ExpertHomeViewController alloc] init];
//             [self.navigationController pushViewController:Exhome animated:YES];
//         }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
//                                                             message:[error localizedDescription]
//                                                            delegate:nil
//                                                   cancelButtonTitle:@"Ok"
//                                                   otherButtonTitles:nil];
//         [alertView show];
//     }];
    NSString *userTypeStr= @"1";//[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    HomeViewController *home=[[HomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];

}
- (IBAction)signUpAction:(id)sender
{
    SignupViewController *signup=[[SignupViewController alloc] init];
    [self.navigationController pushViewController:signup animated:YES];
}
@end
