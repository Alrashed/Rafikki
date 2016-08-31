//
//  EditViewController.m
//  RafikiApp
//
//  Created by CI-05 on 1/29/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    dateView.hidden=YES;

    PassWordView.hidden=YES;

    // Do any additional setup after loading the view from its nib.
    
    editScrollview.contentSize=CGSizeMake([[UIScreen mainScreen] bounds].size.width, aboutView.frame.origin.y+aboutView.frame.size.height+250);
    editButton.layer.borderWidth=1;
    editButton.layer.cornerRadius=editButton.frame.size.height/2;
    profilePicImageview.layer.cornerRadius=profilePicImageview.frame.size.width/2;
    profilePicImageview.clipsToBounds=YES;
    editButton.layer.borderColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255 blue:0.0/255 alpha:0.5].CGColor;
    [self setValueWithTextfield];
    
    submitButton.layer.cornerRadius=submitButton.frame.size.height/2;
    submitButton.layer.borderColor=[UIColor whiteColor].CGColor;
    submitButton.layer.borderWidth=1;
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)passwordAction:(id)sender
{
    PassWordView.hidden=NO;
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
- (IBAction)datepickerAction:(id)sender
{
    dateStr=[NSString stringWithFormat:@"%@",datePicker.date];
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
- (IBAction)cancelAction:(id)sender {
    
    dateView.hidden=YES;
}
- (IBAction)dateAction:(id)sender {
    
    dateView.hidden=NO;
}
- (IBAction)updateAction:(id)sender
{
    if ([firstNameTxt.text isEqualToString:@""]||[lastNameTxt.text isEqualToString:@""]||[dateOfBirthTxt.text isEqualToString:@""])
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
- (IBAction)imageButton:(id)sender
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
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
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
        imageStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"profilePic"];
         dictParams= @{@"firstname":firstNameTxt.text,@"lastname":lastNameTxt.text,@"gender":ganderStr,@"userid":useridStr,@"profilepic":imageStr,@"about_me":aboutTxtview.text,@"dob":dateOfBirthTxt.text,@"nikename":@"",@"home":@"",@"location":@"",@"session_time":@"",@"ages":@"",@"must_have":@"",@"cost":@"",@"qulification":@"",@"designation":@"",@"experience":@"",@"hour_rate":@""};
    }
    else
    {
        
        dictParams= @{@"firstname":firstNameTxt.text,@"lastname":lastNameTxt.text,@"gender":ganderStr,@"profilepic":imageStr,@"userid":useridStr,@"about_me":aboutTxtview.text,@"dob":dateOfBirthTxt.text,@"nikename":@"",@"home":@"",@"location":@"",@"session_time":@"",@"ages":@"",@"must_have":@"",@"cost":@"",@"qulification":@"",@"designation":@"",@"experience":@"",@"hour_rate":@""};
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

         
         [[NSUserDefaults standardUserDefaults] setObject:firstNameTxt.text forKey:@"firstName"];
         [[NSUserDefaults standardUserDefaults] setObject:lastNameTxt.text forKey:@"lastName"];
         [[NSUserDefaults standardUserDefaults] setObject:nickNameTxt.text forKey:@"nickName"];
         [[NSUserDefaults standardUserDefaults] setObject:dateOfBirthTxt.text forKey:@"birthDate"];
//         [[NSUserDefaults standardUserDefaults] setObject:passwordButton.titleLabel.text forKey:@"userPassword"];
         [[NSUserDefaults standardUserDefaults] setObject:ganderStr forKey:@"gender"];
         [[NSUserDefaults standardUserDefaults] setObject:aboutTxtview.text forKey:@"aboutMe"];
         [[NSUserDefaults standardUserDefaults] setObject:imageStr forKey:@"profilePic"];
         
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
