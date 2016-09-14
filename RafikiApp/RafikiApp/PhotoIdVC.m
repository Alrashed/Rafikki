//
//  PhotoIdVC.m
//  RafikiApp
//
//  Created by CI-05 on 4/9/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "PhotoIdVC.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
@interface PhotoIdVC ()

@end

@implementation PhotoIdVC
@synthesize checkPhotoEditFlag;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([checkPhotoEditFlag isEqualToString:@"Yes"])
    {
        
        [photoimgview setImageWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"photoId"]] placeholderImage:nil usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [nextButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
    else
    {
        photoimgview.image=[UIImage imageNamed:@"photo_id"];
    }
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    addImageButton.layer.cornerRadius=addImageButton.frame.size.width/2;
    addImageButton.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:177.0/255 blue:162.0/255.0 alpha:1].CGColor;
    addImageButton.layer.borderWidth=2;
    self.navigationController.navigationBarHidden=YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextAction:(id)sender
{
    if (currentImage==nil ||currentImage==(id)[NSNull null])
    {
        [[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"Please add goverment photo id" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        });
        
        [self performSelector:@selector(callApi) withObject:self afterDelay:1.0];
    }
}
-(void)callApi
{
    [self passGovermentIssueIdPicture];
}
-(void)passGovermentIssueIdPicture
{
    //http://cricyard.com/iphone/rafiki_app/service/upload_government_id.php

    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlString=@"http://cricyard.com/iphone/rafiki_app/service/upload_government_id.php";
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
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"userid"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@", userId] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSString * fileName =[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.jpg\"\r\n",fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:itemData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [imageRequest setHTTPBody:body];
    NSData *returnData = [NSURLConnection sendSynchronousRequest:imageRequest returningResponse:nil error:nil];
//    NSString *imageReturnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//
    
    NSError *error3;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:returnData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error3];
    NSLog(@"response :%@",[json valueForKey:@"government_ids"]);
    
    if ([checkPhotoEditFlag isEqualToString:@"Yes"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:[json valueForKey:@"government_ids"] forKey:@"photoId"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:@"Save & Next", nil];
        [alert show];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        //Next
        AboutMeVC *about=[[AboutMeVC alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }
    else
    {
        //Save & Next
        [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen5_photoId"];
        AboutMeVC *about=[[AboutMeVC alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }
}
- (IBAction)addImageAction:(id)sender
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"What you Can Do?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Galary", @"Camera",nil];
    [self parentViewController];
    [action showInView:self.view];
}
#pragma mark imagepeker Delgate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    currentImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    photoimgview.image=currentImage;
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
@end
