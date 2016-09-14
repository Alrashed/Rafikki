//
//  SocialSecurityVC.m
//  RafikiApp
//
//  Created by CI-05 on 4/9/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "SocialSecurityVC.h"

@interface SocialSecurityVC ()

@end

@implementation SocialSecurityVC
@synthesize filedFlag,chakEditFlag;
- (void)viewDidLoad {
    [super viewDidLoad];
    roundLbl1.layer.cornerRadius=roundLbl1.frame.size.width/2;
    roundLbl1.clipsToBounds=YES;
    
    roundLbl2.layer.cornerRadius=roundLbl2.frame.size.width/2;
    roundLbl2.clipsToBounds=YES;
    
    roundLbl3.layer.cornerRadius=roundLbl3.frame.size.width/2;
    roundLbl3.clipsToBounds=YES;
    
    roundLbl4.layer.cornerRadius=roundLbl4.frame.size.width/2;
    roundLbl4.clipsToBounds=YES;
    
    if ([chakEditFlag isEqualToString:@"Yes"])
    {
        fullNameTxt.text=[NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"],[[NSUserDefaults standardUserDefaults] objectForKey:@"lastName"]];
        ageTxt.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"birthDate"];
        SocialSecurityTxt.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"socialSecurityNumber"];
        [nectButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
    else
    {
        fullNameTxt.text=[NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"],[[NSUserDefaults standardUserDefaults] objectForKey:@"lastName"]];
        ageTxt.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"birthDate"];
    }
    self.navigationController.navigationBarHidden=YES;

    /*[[NSUserDefaults standardUserDefaults] setObject:TxtFirstName.text forKey:@"firstName"];
     [[NSUserDefaults standardUserDefaults] setObject:TxtLastName.text forKey:@"lastName"];
     [[NSUserDefaults standardUserDefaults] setObject:dateOfbirthButton.currentTitle forKey:@"BirthDate"];*/
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}
-(void)passSSNInsertApi
{
    //http://cricyard.com/iphone/rafiki_app/service/register_ssn.php?social_security_number=123654789&userid=1
    
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/register_ssn.php"];
    NSDictionary *dictParams = @{@"social_security_number":SocialSecurityTxt.text,@"userid":userId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         
         if ([chakEditFlag isEqualToString:@"Yes"])
         {
             [self.navigationController popViewControllerAnimated:YES];
         }
         else
         {
             UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:@"Save & Next", nil];
             [alert show];
         }
         
          [[NSUserDefaults standardUserDefaults] setObject:SocialSecurityTxt.text forKey:@"socialSecurityNumber"];
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        //Next
        PhotoIdVC *photo=[[PhotoIdVC alloc] init];
        [self.navigationController pushViewController:photo animated:YES];
    }
    else
    {
        //Save & Next
        [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen4_Socail"];
        PhotoIdVC *photo=[[PhotoIdVC alloc] init];
        [self.navigationController pushViewController:photo animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender
{
    if ([filedFlag isEqualToString:@"Yes"])
    {
        HomeViewController *frontViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];//frantview
        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        [revealController.navigationController setNavigationBarHidden:YES];
        app.window.rootViewController = revealController;
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
- (IBAction)nextAction:(id)sender
{
    if ([SocialSecurityTxt.text isEqualToString:@""]||SocialSecurityTxt.text.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"Please enter social security Number (SSN)" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passSSNInsertApi];
    }
}
@end
