//
//  ExpertEditVC.m
//  RafikiApp
//
//  Created by CI-05 on 2/19/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "ExpertEditVC.h"

@interface ExpertEditVC ()

@end

@implementation ExpertEditVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    dateView.hidden=YES;
    PassWordView.hidden=YES;
    
    profilePicImageview.layer.cornerRadius=profilePicImageview.frame.size.width/2;
    profilePicImageview.clipsToBounds=YES;
    
    editCatButton.layer.cornerRadius=editCatButton.frame.size.height/2;
    editCatButton.layer.borderColor=[UIColor whiteColor].CGColor;
                                     //colorWithRed:69.0/255 green:172.0/255 blue:141.0/255 alpha:1].CGColor;
    editCatButton.layer.borderWidth=1;
    
    editScrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width,editSkillButton.frame.origin.y+editSkillButton.frame.size.height+10);
    
    [self setValueWithTextfield];
    
    submitButton.layer.cornerRadius=submitButton.frame.size.height/2;
    submitButton.layer.borderColor=[UIColor whiteColor].CGColor;
    submitButton.layer.borderWidth=1;
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
-(void)setValueWithTextfield
{
    firstNameTxt.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"];
    lastNameTxt.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"lastName"];
    NSString *nickNameStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    if ([nickNameStr isEqualToString:@""]||nickNameStr==nil)
    {
        nickNameTxt.text=@"";
    }
    else
    {
        nickNameTxt.text=nickNameStr;
    }
    NSString *dateOfBirthStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"birthDate"];
    if ([dateOfBirthStr isEqualToString:@""]||dateOfBirthStr==nil||dateOfBirthStr.length==0)
    {
        dateOfBirthTxt.text=@"";
    }
    else
    {
        dateOfBirthTxt.text=dateOfBirthStr;
    }
    //    oldPasswordStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    [passwordButton setTitle:@"Change Password" forState:UIControlStateNormal];
    //    passwordTxt.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    ganderStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"gender"];
    if ([ganderStr isEqualToString:@"1"])
    {
        maleButton.selected=YES;
        femaleButton.selected=NO;
    }
    else
    {
        maleButton.selected=NO;
        femaleButton.selected=YES;
    }
    aboutTxtview.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"aboutMe"];
    NSString *profilePic=[[NSUserDefaults standardUserDefaults] objectForKey:@"profilePic"];
    if ([profilePic isEqualToString:@""]||profilePic==nil)
    {
        profilePicImageview.image=[UIImage imageNamed:@"photo"];
    }
    else
    {
        [profilePicImageview setImageWithURL:[NSURL URLWithString:profilePic] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    NSString *home=[[NSUserDefaults standardUserDefaults] objectForKey:@"home"];
    NSString *location=[[NSUserDefaults standardUserDefaults] objectForKey:@"location"];
    
    if ([home isEqualToString:@""]||home==nil)
    {
        homeTxt.text=@"";
    }
    else
    {
        homeTxt.text=home;
    }
    if ([location isEqualToString:@""]||location==nil)
    {
        locationTxt.text=@"";
    }
    else
    {
        locationTxt.text=location;
    }
    NSString *session=[[NSUserDefaults standardUserDefaults] objectForKey:@"session"];
    if ([session isEqualToString:@""])
    {
        sessionTxt.text=@"";
    }
    else
    {
        sessionTxt.text=session;
    }
    NSString *ages=[[NSUserDefaults standardUserDefaults] objectForKey:@"ages"];
    if ([ages isEqualToString:@""])
    {
        agesTxt.text=@"";
    }
    else
    {
        agesTxt.text=ages;
    }
    NSString *mustHave=[[NSUserDefaults standardUserDefaults] objectForKey:@"mustHave"];
    if ([mustHave isEqualToString:@""])
    {
        mustHavesTxt.text=@"";
    }
    else
    {
        mustHavesTxt.text=mustHave;
    }
    NSString *cost=[[NSUserDefaults standardUserDefaults] objectForKey:@"cost"];
    if ([cost isEqualToString:@""])
    {
        costTxt.text=@"";
    }
    else
    {
        costTxt.text=cost;
    }
    expirianceTxt.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"expiriance"];
    designationTxt.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"designation"];
    qualificationTxt.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"qualification"];
}
#pragma mark imagepeker Delgate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    currentImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    profilePicImageview.image=currentImage;
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
- (IBAction)editSkillButtonAction:(id)sender
{
    EditShowSkill *skill=[[EditShowSkill alloc] init];
    [self.navigationController pushViewController:skill animated:YES];
}

- (IBAction)editPhotoIdAction:(id)sender
{
    PhotoIdVC *photoid=[[PhotoIdVC alloc] init];
    photoid.checkPhotoEditFlag=@"Yes";
    [self.navigationController pushViewController:photoid animated:YES];
}
- (IBAction)editSocialInfoAction:(id)sender
{
    SocialSecurityVC *social=[[SocialSecurityVC alloc] init];
    social.chakEditFlag=@"Yes";
    [self.navigationController pushViewController:social animated:YES];
   /* EditSocialInfo *social=[[EditSocialInfo alloc] init];
    [self.navigationController pushViewController:social animated:YES];*/
}
- (IBAction)editCatAction:(id)sender
{
    //chackEditFlag
    AddCatViewController *add=[[AddCatViewController alloc] init];
    add.chackEditFlag=@"Yes";
    [self.navigationController pushViewController:add animated:YES];
}
- (IBAction)imageButtonAction:(id)sender
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"What you Can Do?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Galary", @"Camera",nil];
    [self parentViewController];
    [action showInView:self.view];
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)maleAction:(id)sender
{
    maleButton.selected=YES;
    femaleButton.selected=NO;
    ganderStr=@"1";
}
- (IBAction)femaleAction:(id)sender
{
    femaleButton.selected=YES;
    maleButton.selected=NO;
    ganderStr=@"0";
}
- (IBAction)passwordAction:(id)sender
{
    PassWordView.hidden=NO;
}
- (IBAction)dateOfBirthAction:(id)sender
{
    dateView.hidden=NO;
}
- (IBAction)doneAction:(id)sender
{
    if ([firstNameTxt.text isEqualToString:@""]||[lastNameTxt.text isEqualToString:@""]||[dateOfBirthTxt.text isEqualToString:@""]||[aboutTxtview.text isEqualToString:@""])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please filled All Required Information" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if (currentImage ==nil)
        {
            [self passEditApi];
        }
        else
        {
            [self passImageApi];
        }
    }
}
- (IBAction)cancelAction:(id)sender
{
    dateView.hidden=YES;
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
        NSDate* now = datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        dateStr = [formatter stringFromDate:now];
    }
    
    dateOfBirthTxt.text=dateStr;
    dateView.hidden=YES;
}

- (IBAction)submitAction:(id)sender
{
    oldPasswordStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userPassword"];
    if ([oldPasswordStr isEqualToString:oldPasswordTxt.text])
    {
        if (newPasswordTxt.text.length==0||confirmPasswordTxt.text.length==0)
        {
            [[[UIAlertView alloc] initWithTitle:@"Enter new password and confirm new password" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
        else
        {
            if ([newPasswordTxt.text isEqualToString:confirmPasswordTxt.text])
            {
                [self passChangePasswordApi];
            }
            else
            {
                [[[UIAlertView alloc] initWithTitle:@"Password not match" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
            }
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Old Password is wrong" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
}
#pragma mark password section
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == PassWordView)
        {
            NSLog(@"Ok");
            PassWordView.hidden=YES;
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
}
#pragma mark pass API
-(void)passChangePasswordApi
{
    //http://cricyard.com/iphone/rafiki_app/service/change_password.php?userid=1&password=123
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/change_password.php"];
    NSDictionary *dictParams=@{@"userid":useridStr,@"password":confirmPasswordTxt.text};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         [[NSUserDefaults standardUserDefaults]setObject:confirmPasswordTxt.text forKey:@"userPassword"];
         //         [passwordButton setTitle:confirmPasswordTxt.text forState:UIControlStateNormal];
         PassWordView.hidden=YES;
         oldPasswordTxt.text=@"";
         newPasswordTxt.text=@"";
         confirmPasswordTxt.text=@"";
         
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
-(void)passImageApi
{
    NSString *urlString=@"http://cricyard.com/iphone/rafiki_app/service/upload.php";
    NSData *itemData=UIImageJPEGRepresentation(currentImage, 0.6);
    NSString *String = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *imageRequest = [[NSMutableURLRequest alloc] init];
    [imageRequest setURL:[NSURL URLWithString:String]];
    [imageRequest setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [imageRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd_hhmmss"];
    
    NSString * fileName =[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.jpg\"\r\n",fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:itemData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [imageRequest setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:imageRequest returningResponse:nil error:nil];
    imageStr = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    [self passEditApi];
}
-(void)passEditApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    //  firstname=samir&lastname=makadia&gender=1&profilepic=google.com&userid=0&about_me=hi&dob=6-6-1988&nikename=sam&password=123
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/edit_user_profile.php"];
    NSDictionary *dictParams;
    
    if (currentImage ==nil)
    {
        /*[3/16/16, 10:58:06 AM] Nitin Sangani: firstname=
         [3/16/16, 10:58:15 AM] Nitin Sangani: &lastname=
         [3/16/16, 10:58:24 AM] Nitin Sangani: &gender=
         [3/16/16, 10:58:32 AM] Nitin Sangani: &profilepic=
         [3/16/16, 10:58:42 AM] Nitin Sangani: &userid=
         [3/16/16, 10:58:52 AM] Nitin Sangani: &about_me=
         [3/16/16, 10:58:58 AM] Nitin Sangani: &dob=
         [3/16/16, 10:59:04 AM] Nitin Sangani: &nikename=
         [3/16/16, 10:59:14 AM] Nitin Sangani: &home=
         [3/16/16, 10:59:21 AM] Nitin Sangani: &location=
         [3/16/16, 10:59:28 AM] Nitin Sangani: &session_time=
         [3/16/16, 10:59:38 AM] Nitin Sangani: &ages=
         [3/16/16, 10:59:44 AM] Nitin Sangani: &must_have=
         [3/16/16, 10:59:52 AM] Nitin Sangani: &cost=
         [3/16/16, 10:59:59 AM] Nitin Sangani: &experience=
         [3/16/16, 11:00:06 AM] Nitin Sangani: &hour_rate=
         [3/16/16, 11:00:14 AM] Nitin Sangani: &qulification=
         [3/16/16, 11:00:22 AM] Nitin Sangani: &designation=*/
        
        imageStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"profilePic"];
        dictParams= @{@"firstname":firstNameTxt.text,@"lastname":lastNameTxt.text,@"gender":ganderStr,@"userid":useridStr,@"profilepic":imageStr,@"about_me":aboutTxtview.text,@"dob":dateOfBirthTxt.text};
    }
    else
    {
        dictParams= @{@"firstname":firstNameTxt.text,@"lastname":lastNameTxt.text,@"gender":ganderStr,@"profilepic":imageStr,@"userid":useridStr,@"about_me":aboutTxtview.text,@"dob":dateOfBirthTxt.text};
    }
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         
         /*firstName
          lastName
          nickName
          birthDate
          userPassword
          gender
          aboutMe
          profilePic*/
                  
         [[NSUserDefaults standardUserDefaults] setObject:homeTxt.text forKey:@"home"];
         [[NSUserDefaults standardUserDefaults] setObject:locationTxt.text forKey:@"location"];
         [[NSUserDefaults standardUserDefaults] setObject:sessionTxt.text forKey:@"session"];
         [[NSUserDefaults standardUserDefaults] setObject:agesTxt.text forKey:@"ages"];
         [[NSUserDefaults standardUserDefaults] setObject:mustHavesTxt.text forKey:@"mustHave"];
         [[NSUserDefaults standardUserDefaults] setObject:costTxt.text forKey:@"cost"];
         
         [[NSUserDefaults standardUserDefaults] setObject:firstNameTxt.text forKey:@"firstName"];
         [[NSUserDefaults standardUserDefaults] setObject:lastNameTxt.text forKey:@"lastName"];
         [[NSUserDefaults standardUserDefaults] setObject:nickNameTxt.text forKey:@"nickName"];
         [[NSUserDefaults standardUserDefaults] setObject:dateOfBirthTxt.text forKey:@"birthDate"];
         //         [[NSUserDefaults standardUserDefaults] setObject:passwordButton.titleLabel.text forKey:@"userPassword"];
         [[NSUserDefaults standardUserDefaults] setObject:ganderStr forKey:@"gender"];
         [[NSUserDefaults standardUserDefaults] setObject:aboutTxtview.text forKey:@"aboutMe"];
         [[NSUserDefaults standardUserDefaults] setObject:imageStr forKey:@"profilePic"];
         
         [[NSUserDefaults standardUserDefaults] setObject:expirianceTxt.text forKey:@"expiriance"];
         [[NSUserDefaults standardUserDefaults] setObject:designationTxt.text forKey:@"designation"];
         [[NSUserDefaults standardUserDefaults] setObject:qualificationTxt.text forKey:@"qualification"];
         
         UIAlertController * alert=   [UIAlertController
                                       alertControllerWithTitle:@"Information Updated successfully"
                                       message:nil
                                       preferredStyle:UIAlertControllerStyleAlert];
         
         UIAlertAction* yesButton = [UIAlertAction
                                     actionWithTitle:@"Ok"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         //Handel your yes please button action here
                                         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                         [self.navigationController popViewControllerAnimated:YES];
                                     }];
         [alert addAction:yesButton];
         [self presentViewController:alert animated:YES completion:nil];
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
@end
