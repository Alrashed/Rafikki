//
//  ExpertRateViewController.m
//  RafikiApp
//
//  Created by CI-05 on 1/11/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "ExpertRateViewController.h"
#import "AFNetworking/AFNetworking.h"
@interface ExpertRateViewController ()

@end

@implementation ExpertRateViewController
@synthesize getperamArray,NotiDataflag;
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"peram Array is :%@",getperamArray);
    // Custom Images
    [customStarImageControl setStar:[UIImage imageNamed:@"star_highlighted-darker.png"] highlightedStar:nil atIndex:0];
    [customStarImageControl setStar:[UIImage imageNamed:@"star_highlighted-darker.png"] highlightedStar:nil atIndex:1];
    [customStarImageControl setStar:[UIImage imageNamed:@"star_highlighted-darker.png"] highlightedStar:nil atIndex:2];
    [customStarImageControl setStar:[UIImage imageNamed:@"star_highlighted-darker.png"] highlightedStar:nil atIndex:3];
    [customStarImageControl setStar:[UIImage imageNamed:@"star_highlighted-darker.png"] highlightedStar:nil atIndex:4];
    customStarImageControl.rating = 0;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)passSubmitApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //make request to the server
    NSDictionary *dictParams;
    if ([NotiDataflag isEqualToString:@"Yes"])
    {
        dictParams= @{@"invite_id":[getperamArray valueForKey:@"invite_id"],@"expert_id":[getperamArray valueForKey:@"expert_id"],@"user_id":[getperamArray valueForKey:@"user_id"],@"review_text":reviewTxtview.text,@"ratting":starrating,@"user_type":@"expert"};
    }
    else
    {
         dictParams= @{@"invite_id":[[getperamArray valueForKey:@"invite_id"] objectAtIndex:0],@"expert_id":[[getperamArray valueForKey:@"expert_id"] objectAtIndex:0],@"user_id":[[getperamArray valueForKey:@"user_id"] objectAtIndex:0],@"review_text":reviewTxtview.text,@"ratting":starrating,@"user_type":@"expert"};
    }
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/complete_job.php"];
    
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        NSDictionary *cat = responseObject;
        NSLog(@"Complete dics is:%@",cat);
        AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
        app.appReviewStr=@"Yes";
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"job Completed successfully"
                                      message:nil
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Ok"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
                                        
                                        if ([app.trecker isValid]) {
                                            [app.trecker invalidate];
                                        }
                                        //Handel your yes please button action here
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"startJob"];
                                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"startDate"];
                                        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lastTime"];
                                        
                                        JobHistoryViewController *frontViewController = [[JobHistoryViewController alloc] initWithNibName:@"JobHistoryViewController" bundle:nil];//frantview
                                        frontViewController.chackRootStr=@"Yes";
                                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                                        [revealController.navigationController setNavigationBarHidden:YES];
                                        app.window.rootViewController = revealController;
//                                        [self.navigationController popViewControllerAnimated:YES];
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
}
#pragma mark textview delegate methods
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    reviewTxtview.text=@"";
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""])
    {
        reviewTxtview.text=@"Write Review";
    }
}
-(void)newRating:(DLStarRatingControl *)control :(float)rating
{
    starrating=[NSString stringWithFormat:@"%.0f",rating];
    NSLog(@"rate star Count is:%@",starrating);
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)cancelAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)submitAction:(id)sender
{
    if ([starrating isEqualToString:@"0"]||[reviewTxtview.text isEqualToString:@"Write Review"])
    {
        //error message display
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Please enter rate-review properly"
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
        [self passSubmitApi];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
