//
//  RateViewController.m
//  RafikiApp
//
//  Created by CI-05 on 1/9/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "RateViewController.h"
#import "AFNetworking/AFNetworking.h"
@interface RateViewController ()

@end

@implementation RateViewController
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
-(void)getClientTokens
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    // TODO: Switch this URL to your own authenticated API
//    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//    NSURL *clientTokenURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/braintree/create_customer.php?user_id=%@", useridStr]];
//    NSMutableURLRequest *clientTokenRequest = [NSMutableURLRequest requestWithURL:clientTokenURL];
//    [clientTokenRequest setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
//    
//    [[[NSURLSession sharedSession] dataTaskWithRequest:clientTokenRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
//    {
//        // TODO: Handle errors
//      /*  NSString *clientToken = @"eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiI3ZmY1YTc5MzFlMWQ5YWY1MjJlNTNlYjhjZmVjMDJlYWM3Y2ZlZmE2OGY2ZGMzYjNlZjFjZTdhOGIwZGQ4ODBlfGNyZWF0ZWRfYXQ9MjAxNi0wMi0yN1QwNDozNjowNC42ODIxODE4MTgrMDAwMFx1MDAyNm1lcmNoYW50X2lkPTM0OHBrOWNnZjNiZ3l3MmJcdTAwMjZwdWJsaWNfa2V5PTJuMjQ3ZHY4OWJxOXZtcHIiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzM0OHBrOWNnZjNiZ3l3MmIvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIn0sInRocmVlRFNlY3VyZUVuYWJsZWQiOnRydWUsInRocmVlRFNlY3VyZSI6eyJsb29rdXBVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvMzQ4cGs5Y2dmM2JneXcyYi90aHJlZV9kX3NlY3VyZS9sb29rdXAifSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQWNtZSBXaWRnZXRzLCBMdGQuIChTYW5kYm94KSIsImNsaWVudElkIjpudWxsLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjp0cnVlLCJlbnZpcm9ubWVudCI6Im9mZmxpbmUiLCJ1bnZldHRlZE1lcmNoYW50IjpmYWxzZSwiYnJhaW50cmVlQ2xpZW50SWQiOiJtYXN0ZXJjbGllbnQzIiwiYmlsbGluZ0FncmVlbWVudHNFbmFibGVkIjp0cnVlLCJtZXJjaGFudEFjY291bnRJZCI6ImFjbWV3aWRnZXRzbHRkc2FuZGJveCIsImN1cnJlbmN5SXNvQ29kZSI6IlVTRCJ9LCJjb2luYmFzZUVuYWJsZWQiOmZhbHNlLCJtZXJjaGFudElkIjoiMzQ4cGs5Y2dmM2JneXcyYiIsInZlbm1vIjoib2ZmIn0=";
//        clientToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];*/
//        NSString *clientToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        
//        NSError *jsonError;
//        NSData *objectData = [clientToken dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
//                                                             options:NSJSONReadingMutableContainers
//                                                               error:&jsonError];
//        
//        
//        NSLog(@"tocken dics is:%@",[[json valueForKey:@"client_token"] objectAtIndex:0]);
//        
//        self.braintreeClient = [[BTAPIClient alloc] initWithAuthorization:[[json valueForKey:@"client_token"] objectAtIndex:0]];
//        // If you haven't already, create and retain a `BTAPIClient` instance with a tokenization
//        // key or a client token from your server.
//        // Typically, you only need to do this once per session.
//        //self.braintreeClient = [[BTAPIClient alloc] initWithAuthorization:aClientToken];
//        
//        BTPaymentRequest *paymentRequest = [[BTPaymentRequest alloc] init];
//        paymentRequest.summaryTitle = @"Job Payment";
//        paymentRequest.summaryDescription = @"";
//        paymentRequest.displayAmount = @"$19.00";
//        paymentRequest.callToActionText = @"$19 - Payment Now";
//        paymentRequest.shouldHideCallToAction = NO;
//        
//        BTDropInViewController *dropIn = [[BTDropInViewController alloc] initWithAPIClient:self.braintreeClient];
//        dropIn.delegate = self;
//        dropIn.paymentRequest = paymentRequest;
//        dropIn.title = @"Check Out";
//        
//        
//        // Create a BTDropInViewController
////        BTDropInViewController *dropInViewController = [[BTDropInViewController alloc]
////                                                        initWithAPIClient:self.braintreeClient];
////        dropInViewController.delegate = self;
//        
//        // This is where you might want to customize your view controller (see below)
//        
//        // The way you present your BTDropInViewController instance is up to you.
//        // In this example, we wrap it in a new, modally-presented navigation controller:
//        UIBarButtonItem *item = [[UIBarButtonItem alloc]
//                                 initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
//                                 target:self
//                                 action:@selector(userDidCancelPayment)];
//        dropIn.navigationItem.leftBarButtonItem = item;
//        UINavigationController *navigationController = [[UINavigationController alloc]
//                                                        initWithRootViewController:dropIn];
//        [self presentViewController:navigationController animated:YES completion:nil];
//        // As an example, you may wish to present our Drop-in UI at this point.
//        // Continue to the next section to learn more...
//    }] resume];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/braintree/create_customer.php"];
    NSDictionary *dictParams;
    if ([NotiDataflag isEqualToString:@"Yes"])
    {
        dictParams= @{@"user_id":useridStr,@"other_user_id":[getperamArray valueForKey:@"expert_id"]};
    }
    else
    {
        dictParams= @{@"user_id":useridStr,@"other_user_id":[[getperamArray valueForKey:@"expert_id"] objectAtIndex:0]};
    }
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         NSLog(@"my rate:%@",[[responseObject valueForKey:@"hour_rate"] objectAtIndex:0]);
                 // If you haven't already, create and retain a `BTAPIClient` instance with a tokenization
                 // key or a client token from your server.
                 // Typically, you only need to do this once per session.
                 //self.braintreeClient = [[BTAPIClient alloc] initWithAuthorization:aClientToken];
         
         NSString *totalTimestr=[[NSUserDefaults standardUserDefaults] objectForKey:@"lastTime"];
         NSArray *saprateArray = [totalTimestr componentsSeparatedByString:@":"];
         
         int hh=[[saprateArray objectAtIndex:0] intValue];
         int mm=[[saprateArray objectAtIndex:1] intValue];
         
         int price=[[[responseObject valueForKey:@"hour_rate"] objectAtIndex:0]intValue];
         final =[NSString stringWithFormat:@"%d",(price*hh)+(price *mm/60)];
         int chackPrice=[final intValue];
             if (chackPrice <=2)
             {
                 [[[UIAlertView alloc] initWithTitle:@"Payment not possible" message:@"payment is less than $2" delegate:self cancelButtonTitle:@"Okay Got it" otherButtonTitles:nil, nil] show];
                 [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
             }
             else
             {
                 self.braintreeClient = [[BTAPIClient alloc] initWithAuthorization:[[responseObject valueForKey:@"client_token"] objectAtIndex:0]];

                 BTPaymentRequest *paymentRequest = [[BTPaymentRequest alloc] init];
                 paymentRequest.summaryTitle = @"Job Payment";
                 paymentRequest.summaryDescription = @"";
                 paymentRequest.displayAmount = final;
                 paymentRequest.callToActionText =[NSString stringWithFormat:@"%@- Payment Now",final];
                 paymentRequest.shouldHideCallToAction = NO;
                 
                 BTDropInViewController *dropIn = [[BTDropInViewController alloc] initWithAPIClient:self.braintreeClient];
                 dropIn.delegate = self;
                 dropIn.paymentRequest = paymentRequest;
                 dropIn.title = @"Check Out";
                 
                 
                 // Create a BTDropInViewController
                 //        BTDropInViewController *dropInViewController = [[BTDropInViewController alloc]
                 //                                                        initWithAPIClient:self.braintreeClient];
                 //        dropInViewController.delegate = self;
                 
                 // This is where you might want to customize your view controller (see below)
                 
                 // The way you present your BTDropInViewController instance is up to you.
                 // In this example, we wrap it in a new, modally-presented navigation controller:
                 UIBarButtonItem *item = [[UIBarButtonItem alloc]
                                          initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                          target:self
                                          action:@selector(userDidCancelPayment)];
                 dropIn.navigationItem.leftBarButtonItem = item;
                 UINavigationController *navigationController = [[UINavigationController alloc]
                                                                 initWithRootViewController:dropIn];
                 [self presentViewController:navigationController animated:YES completion:nil];
                 // As an example, you may wish to present our Drop-in UI at this point.
                 // Continue to the next section to learn more...
             }
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
- (void)userDidCancelPayment
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
// Implement BTDropInViewControllerDelegate ...
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dropInViewController:(BTDropInViewController *)viewController
  didSucceedWithTokenization:(BTPaymentMethodNonce *)paymentMethodNonce
{
    // Send payment method nonce to your server for processing
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([paymentMethodNonce.nonce isEqualToString:@""]||paymentMethodNonce.nonce.length==0)
    {
        NSLog(@"Payment nones Not found");
    }
    else
    {
         [self passSubmitApiWithNones:paymentMethodNonce.nonce];
    }
//    [self postNonceToServer:paymentMethodNonce.nonce];
}
- (void)dropInViewControllerDidCancel:(__unused BTDropInViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)postNonceToServer:(NSString *)paymentMethodNonce
{
    // Update URL with your server
  /*  NSURL *paymentURL = [NSURL URLWithString:@"https://your-server.example.com/checkout"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:paymentURL];
    request.HTTPBody = [[NSString stringWithFormat:@"payment_method_nonce=%@", paymentMethodNonce] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
      {
          [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"startJob"];
          [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"startDate"];
          [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"lastTime"];
          
          dispatch_async(dispatch_get_main_queue(), ^{
              
              // code here
              HomeViewController *frontViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];//frantview
              RearViewController *rearViewController = [[RearViewController alloc] init];//slider
              UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
              UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
              SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
              AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
              [revealController.navigationController setNavigationBarHidden:YES];
              app.window.rootViewController = revealController;
              
          });
          
         
          // TODO: Handle success and failure
      }] resume];*/
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)passSubmitApiWithNones:(NSString *)nones
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
  //  http://cricyard.com/iphone/rafiki_app/service/complete_job.php?invite_id=""&expert_id=""&user_id=""&review_text=""&ratting=""&user_type="";
    NSString *lastTime=[[NSUserDefaults standardUserDefaults] objectForKey:@"lastTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSDictionary *dictParams;
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/complete_job.php"];
    if ([NotiDataflag isEqualToString:@"Yes"])
    {
       /* dictParams= @{@"invite_id":[getperamArray valueForKey:@"invite_id"],@"expert_id":[getperamArray valueForKey:@"expert_id"] ,@"user_id":[getperamArray valueForKey:@"user_id"],@"review_text":reviewTxtview.text,@"ratting":starrating,@"user_type":@"user",@"amount":final,@"nonce":nones};*/

         dictParams= @{@"invite_id":[getperamArray valueForKey:@"invite_id"],@"expert_id":[getperamArray valueForKey:@"expert_id"] ,@"user_id":[getperamArray valueForKey:@"user_id"],@"review_text":reviewTxtview.text,@"ratting":starrating,@"user_type":@"user"};
    }
    else
    {
         dictParams= @{@"invite_id":[[getperamArray valueForKey:@"invite_id"] objectAtIndex:0],@"expert_id":[[getperamArray valueForKey:@"expert_id"] objectAtIndex:0],@"user_id":[[getperamArray valueForKey:@"user_id"] objectAtIndex:0],@"review_text":reviewTxtview.text,@"ratting":starrating,@"user_type":@"user"};
    }
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        NSDictionary *cat = responseObject;
        NSLog(@"Complete dics is:%@",cat);
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
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            // code here
                                            JobHistoryViewController *frontViewController = [[JobHistoryViewController alloc] initWithNibName:@"JobHistoryViewController" bundle:nil];//frantview
                                            frontViewController.chackRootStr=@"Yes";
                                            RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                                            UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                                            UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                                            SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                                            AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                                            [revealController.navigationController setNavigationBarHidden:YES];
                                            app.window.rootViewController = revealController;
                                        });
                                        
                                     /*HomeViewController *frontViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];//frantview
                                        RearViewController *rearViewController = [[RearViewController alloc] init];//slider
                                        UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
                                        UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
                                        SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
                                        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication] delegate];
                                        [revealController.navigationController setNavigationBarHidden:YES];
                                        app.window.rootViewController = revealController;
                                        
//                                        [self.navigationController popViewControllerAnimated:YES];*/
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
        [self passSubmitApiWithNones:@""];
    }
}
@end
