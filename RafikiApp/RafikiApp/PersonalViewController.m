//
//  PersonalViewController.m
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "PersonalViewController.h"
#import "AFNetworking/AFNetworking.h"
@import Firebase;

@interface PersonalViewController ()

@end

@implementation PersonalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // [START create_database_reference]
    self.ref = [[FIRDatabase database] reference];
    // [END create_database_reference]
    
    maleRedButton.selected=YES;
    dateView.hidden=YES;
    ganderStr=@"1";
    privacyView.hidden=YES;
    
    userPictureImageview.layer.cornerRadius=5;
    userPictureImageview.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:172.0/255.0 blue:162.0/255 alpha:1].CGColor;
    userPictureImageview.layer.borderWidth=1;
    userPictureImageview.clipsToBounds=YES;
    
    firstNameView.layer.cornerRadius=5;
    firstNameView.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:172.0/255.0 blue:162.0/255 alpha:1].CGColor;
    firstNameView.layer.borderWidth=1;
    firstNameView.clipsToBounds=YES;
    
    lastNameView.layer.cornerRadius=5;
    lastNameView.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:172.0/255.0 blue:162.0/255 alpha:1].CGColor;
    lastNameView.layer.borderWidth=1;
    lastNameView.clipsToBounds=YES;
    
    genderView.layer.cornerRadius=5;
    genderView.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:172.0/255.0 blue:162.0/255 alpha:1].CGColor;
    genderView.layer.borderWidth=1;
    genderView.clipsToBounds=YES;
    
    aboutMeTxt.layer.cornerRadius=5;
    aboutMeTxt.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:172.0/255.0 blue:162.0/255 alpha:1].CGColor;
    aboutMeTxt.layer.borderWidth=1;
    aboutMeTxt.clipsToBounds=YES;
    
    nickNameTxt.layer.cornerRadius=5;
    nickNameTxt.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:172.0/255.0 blue:162.0/255 alpha:1].CGColor;
    nickNameTxt.layer.borderWidth=1;
    nickNameTxt.clipsToBounds=YES;
    
    dateOfbirthButton.layer.cornerRadius=5;
    dateOfbirthButton.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:172.0/255.0 blue:162.0/255 alpha:1].CGColor;
    dateOfbirthButton.layer.borderWidth=1;
    dateOfbirthButton.clipsToBounds=YES;
    
    privecyButton.layer.cornerRadius=5;
    privecyButton.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:172.0/255.0 blue:162.0/255 alpha:1].CGColor;
    privecyButton.layer.borderWidth=1;
    privecyButton.clipsToBounds=YES;
    
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextAction:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if ((TxtFirstName.text.length==0||[TxtFirstName.text isEqualToString:@""])||(TxtLastName.text.length==0||[TxtLastName.text isEqualToString:@""])||[dateOfbirthButton.titleLabel.text isEqualToString:@"Choose date of birth"])
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    else
    {
//        if (userPictureImageview.image==nil)
//        {
//            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Confirmation." message:@"you can browse but wont be able to request a trainer without a picture" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
//            alert.tag=1000;
//            [alert show];
//            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        }
//        else
//        {
            [self SignupPersonalApiCall];
//        }
    }
}
-(void)SignupPersonalApiCall
{
    FIRUser *user = [FIRAuth auth].currentUser;
    if (currentImage ==nil)
    {
        imageReturnString=@"";
    }
    //new firebase code
    // [START single_value_read]
    
    
//    NSString *email = [FIRAuth auth].currentUser.email;
//
//    NSString *firstName = TxtFirstName.text;
//    NSString *lastName = TxtLastName.text;
//    NSString *birthdate = dateOfbirthButton.titleLabel.text;
//    NSString *catid = @"548";
//    NSString *catname = @"Tenor";
//    NSString *designation = @"";
//    NSString *experience = @"";
//    NSString *gender = ganderStr;
//    NSString *hour_rate = @"";
//    NSString *latitude = @"37.317406";
//    NSString *longitude = @"-121.872704";
//    NSString *phone_no = @"4083682350";
//    NSString *qulification = @"";
//    NSString *skill = @"";
//    NSString *user_id = @"1";
//    NSString *user_image = @"";
//    NSString *user_type = @"2";
//    NSString *username = @"izaacg";
    
    [[[[_ref child:@"users"] child:user.uid] child:@"firstname"] setValue:TxtFirstName.text];
    [[[[_ref child:@"users"] child:user.uid] child:@"lastname"] setValue:TxtLastName.text];
    [[[[_ref child:@"users"] child:user.uid] child:@"gender"] setValue:ganderStr];
    [[[[_ref child:@"users"] child:user.uid] child:@"about_me"] setValue:aboutMeTxt.text];
    [[[[_ref child:@"users"] child:user.uid] child:@"nickname"] setValue:nickNameTxt.text];
    [[[[_ref child:@"users"] child:user.uid] child:@"birthdate"] setValue:dateOfbirthButton.titleLabel.text];
        //NSData *itemData=UIImageJPEGRepresentation(currentImage, 0.6);
    
    NSString *profPic = [UIImagePNGRepresentation(currentImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSLog(@"%@Thisis working", profPic);
    [[[[_ref child:@"users"] child:user.uid] child:@"profilePic"] setValue:profPic];

    
    
//    FIRUserProfileChangeRequest *changeRequest = [user profileChangeRequest];
//    
//    changeRequest.displayName = @"Jane Q. User";
//    changeRequest.photoURL =
//    [NSURL URLWithString:@"https://example.com/jane-q-user/profile.jpg"];
//    [changeRequest commitChangesWithCompletion:^(NSError *_Nullable error) {
//        if (error) {
//            // An error happened.
//        } else {
//            // Profile updated.
//        }
//    }];
    
    // Authentication just completed successfully :)
    // The logged in user's unique identifier
//    NSLog(@"%@", user.uid);
    // Create a new user dictionary accessing the user's info
    // provided by the authData parameter
//    NSDictionary *newUser = @{
//                              @"test1": @"test1",
//                              @"test2": @"test2"
//                              };
    // Create a child path with a key set to the uid underneath the "users" node
    // This creates a URL path like the following:
    //  - https://<YOUR-FIREBASE-APP>.firebaseio.com/users/<uid>
//    [[[_ref childByAppendingPath:@"users"]
//      childByAppendingPath:user.uid] setValue:newUser];
//
    
    
    //--------------fix this------------//
//    [[NSUserDefaults standardUserDefaults] setObject:TxtFirstName.text forKey:@"firstName"];
//    [[NSUserDefaults standardUserDefaults] setObject:TxtLastName.text forKey:@"lastName"];
//    [[NSUserDefaults standardUserDefaults] setObject:ganderStr forKey:@"gender"];
//    [[NSUserDefaults standardUserDefaults] setObject:imageReturnString forKey:@"profilePic"];
//    [[NSUserDefaults standardUserDefaults] setObject:dateOfbirthButton.currentTitle forKey:@"BirthDate"];
//    [[NSUserDefaults standardUserDefaults] setObject:aboutMeTxt.text forKey:@"about_me"];
//    [[NSUserDefaults standardUserDefaults] setObject:nickNameTxt.text forKey:@"nickName"];
//    NSLog(@"isFiled is:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"is_filledValue"]);
//    [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"payment_method_add"];
//                        
//
//    NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//    NSDictionary *dictParams = @{
//                                                                      @"firstname":TxtFirstName.text,
//                                                                      @"lastname":TxtLastName.text,
//                                                                      @"gender":ganderStr,
//                                                                      @"profilepic":imageReturnString,
//                                                                      @"userid":userIdStr,
//                                                                      @"about_me":aboutMeTxt.text,
//                                                                      @"dob":dateOfbirthButton.titleLabel.text,
//                                                                      @"nikename":nickNameTxt.text
//                                                                      };
//    
//    -------------------------
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:@"Save & Next", nil];
    alert.tag=2000;
    [alert show];
    
    // [END single_value_read]

//    else
//    {
//        NSString *urlString=@"http://cricyard.com/iphone/rafiki_app/service/upload.php";
//        NSData *itemData=UIImageJPEGRepresentation(currentImage, 0.6);
//        NSString *String = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        NSMutableURLRequest *imageRequest = [[NSMutableURLRequest alloc] init];
//        [imageRequest setURL:[NSURL URLWithString:String]];
//        [imageRequest setHTTPMethod:@"POST"];
//        
//        NSString *boundary = @"---------------------------14737809831466499882746641449";
//        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//        [imageRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
//        
//        NSMutableData *body = [NSMutableData data];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"yyyyMMdd_hhmmss"];
//        
//        NSString * fileName =[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
//        
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.jpg\"\r\n",fileName] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[NSData dataWithData:itemData]];
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        [imageRequest setHTTPBody:body];
//        
//        NSData *returnData = [NSURLConnection sendSynchronousRequest:imageRequest returningResponse:nil error:nil];
//        imageReturnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    }
//        NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//        
//        //    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/register_personal_info.php?firstname=%@&lastname=%@&gender=%@&profilepic=%@&userid=%@&about_me=%@&dob=%@",TxtFirstName.text,TxtLastName.text,ganderStr,imageReturnString,userIdStr,aboutMeTxt.text,dateOfbirthButton.titleLabel.text];
//        if (nickNameTxt.text==nil||nickNameTxt.text.length==0)
//        {
//            nickNameTxt.text=@"";
//        }
//        if (aboutMeTxt.text==nil||aboutMeTxt.text.length==0)
//        {
//            aboutMeTxt.text=@"";
//        }
//        
//        NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/register_personal_info.php"];
//        NSDictionary *dictParams = @{
//                                     @"firstname":TxtFirstName.text,
//                                     @"lastname":TxtLastName.text,
//                                     @"gender":ganderStr,
//                                     @"profilepic":imageReturnString,
//                                     @"userid":userIdStr,
//                                     @"about_me":aboutMeTxt.text,
//                                     @"dob":dateOfbirthButton.titleLabel.text,
//                                     @"nikename":nickNameTxt.text
//                                     };
//        
//        NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            NSLog(@"Response: %@",responseObject);
//            
//            NSDictionary  *resposeDics=(NSDictionary *) responseObject;
//            NSLog(@"masseg is:%@",[resposeDics valueForKey:@"msg"]);
//            //resposeDics valueForKey:@"Signup Successfully ");
//            if ([[responseObject valueForKey:@"msg"] isEqualToString:@"Signup Successfully "])
//            {
//                [[NSUserDefaults standardUserDefaults] setObject:TxtFirstName.text forKey:@"firstName"];
//                [[NSUserDefaults standardUserDefaults] setObject:TxtLastName.text forKey:@"lastName"];
//                [[NSUserDefaults standardUserDefaults] setObject:ganderStr forKey:@"gender"];
//                [[NSUserDefaults standardUserDefaults] setObject:imageReturnString forKey:@"profilePic"];
//                [[NSUserDefaults standardUserDefaults] setObject:dateOfbirthButton.currentTitle forKey:@"BirthDate"];
//                [[NSUserDefaults standardUserDefaults] setObject:aboutMeTxt.text forKey:@"about_me"];
//                [[NSUserDefaults standardUserDefaults] setObject:nickNameTxt.text forKey:@"nickName"];
//                NSLog(@"isFiled is:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"is_filledValue"]);
//                [[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"payment_method_add"];
//                
//                [MBProgressHUD hideHUDForView:self.view animated:YES];
//                if ([self.signupFlag isEqualToString:@"user"])
//                {
//                    [[NSUserDefaults standardUserDefaults] setObject:[[responseObject valueForKey:@"data"] valueForKey:@"is_filled"] forKey:@"is_filledValue"];
//                    NSLog(@"personal Is Filed:-%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"is_filledValue"]);
//
//                    
//                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:@"Save & Next", nil];
//                    alert.tag=2000;
//                    [alert show];
//                   
//                }
//                else
//                {
//                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:@"Save & Next", nil];
//                    alert.tag=2000;
//                    [alert show];
//                }
//            }
//            else
//            {
//                NSLog(@"Some problem Occures");
//            }
//            
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
    
//end of firebase code
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1000)
    {
        if (buttonIndex ==1)
        {
            //Okay
            UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"What you Can Do?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Galary", @"Camera",nil];
            [self parentViewController];
            [action showInView:self.view];
        }
        else
        {
            //Cancel
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            });
            
            [self performSelector:@selector(callApi) withObject:self afterDelay:1.0];
        }
    }
    else if (alertView.tag==2000)
    {
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"]isEqualToString:@"1"])
        {
            if (buttonIndex==0)
            {
                //Next
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"loginCheck"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen1_basic"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen2_verify"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen3_personal"];
                
//                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"is_filledValue"];
                HomeViewController *home=[[HomeViewController alloc] init];
                [self.navigationController pushViewController:home animated:YES];
            }
            else
            {
                //Save & Next
                [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"loginCheck"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen1_basic"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen2_verify"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen3_personal"];
                
//                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"is_filledValue"];
                HomeViewController *home=[[HomeViewController alloc] init];
                [self.navigationController pushViewController:home animated:YES];
            }
        }
        else
        {
            if (buttonIndex==0)
            {
                //Next
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"is_filledValue"];
                SocialSecurityVC *social=[[SocialSecurityVC alloc] init];
                [self.navigationController pushViewController:social animated:YES];
            }
            else
            {
                //Save & Next
                [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen3_personal"];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"is_filledValue"];
                SocialSecurityVC *social=[[SocialSecurityVC alloc] init];
                [self.navigationController pushViewController:social animated:YES];
            }
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        HomeViewController *home=[[HomeViewController alloc] init];
        [self.navigationController pushViewController:home animated:YES];
    }
}
-(void)callApi
{
    [self SignupPersonalApiCall];
}
#pragma mark imagepeker Delgate Methods
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info
{
    currentImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    userPictureImageview.image=currentImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController     alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [imagePicker setDelegate:self];
        
        //        imagePicker.modalTransitionStyle=UIModalPresentationPageSheet;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
    else if (buttonIndex==1)
    {
        //        NSLog(@"image of camera..is on");
        @try
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate=self;
            
            [self presentViewController:picker animated:YES completion:nil];
        }
        @catch (NSException *exception)
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"No camera"
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
    }
    else
    {
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)maleAction:(id)sender
{
    maleRedButton.selected=YES;
    femaleRedButton.selected=NO;
    ganderStr=@"1";
}
- (IBAction)feMaleAction:(id)sender
{
    femaleRedButton.selected=YES;
    maleRedButton.selected=NO;
    ganderStr=@"0";
}
- (IBAction)imageAction:(id)sender
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"What you Can Do?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Galary", @"Camera",nil];
    [self parentViewController];
    [action showInView:self.view];
}
- (IBAction)birthDateAction:(id)sender
{
    dateView.hidden=NO;
}
- (IBAction)datepickerAction:(id)sender
{
    dateStr=[NSString stringWithFormat:@"%@",birthDatepicker.date];
}
- (IBAction)setAction:(id)sender
{
    if (dateStr.length==0)
    {
        NSDate* now = [[NSDate alloc] init];//EventDatePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        dateStr = [formatter stringFromDate:now];
    }
    else
    {
        NSDate* now = birthDatepicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        dateStr = [formatter stringFromDate:now];
    }
    [dateOfbirthButton setTitle:dateStr forState:UIControlStateNormal];
    dateView.hidden=YES;
}
- (IBAction)cancelAction:(id)sender
{
        dateView.hidden=YES;
}
- (IBAction)submitAction:(id)sender
{
    questionString=nil;
    answerString=nil;
    if (ans1Txt.text.length==0 && ans2Txt.text.length==0&&ans3Txt.text.length==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter Answer at least one for submit" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        if (ans1Txt.text.length!=0)
        {
            questionString=@"What is your pet name ?";
            answerString=ans1Txt.text;
        }
        else
        {
            questionString=@",";
        }
        if (ans2Txt.text.length!=0)
        {
            if (questionString.length==0)
            {
                questionString=[NSString stringWithFormat:@"What is your birth place?"];
                answerString=ans2Txt.text;
            }
            else
            {
                questionString=[NSString stringWithFormat:@"What is your birth place?,%@",questionString];
                answerString=[NSString stringWithFormat:@"%@,%@",answerString,ans2Txt.text];
            }
        }
        else
        {
            questionString=@",";
        }
        if (ans3Txt.text.length!=0)
        {
            if (questionString.length==0)
            {
                questionString=[NSString stringWithFormat:@"What is your school name?"];
                answerString=ans3Txt.text;
            }
            else
            {
                questionString=[NSString stringWithFormat:@"What is your school name?,%@",questionString];
                answerString=[NSString stringWithFormat:@"%@,%@",answerString,ans3Txt.text];

            }
        }
        else
        {
            questionString=@",";
        }
       // http://cricyard.com/iphone/rafiki_app/service/question_answer.php?userid=81&question=What%20is%20your%20PetName?,What%20is%20your%20Birth%20Place?,What%20is%20your%20schoolName?&answer=jitu,
         NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
         NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/question_answer.php"];
         NSDictionary *dictParams = @{
         @"userid":userIdStr,
         @"question":questionString,
         @"answer":answerString
         };
         NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
         
         AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
         manager.requestSerializer = [AFJSONRequestSerializer serializer];
         [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
         NSLog(@"Response: %@",responseObject);
             privacyView.hidden=YES;
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSLog(@"some problem:....");
         }];
    }
}
- (IBAction)skipAction:(id)sender {
    privacyView.hidden=YES;
}
- (IBAction)privacyAction:(id)sender {
    privacyView.hidden=NO;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    
}
@end
