//
//  TreckerViewController.m
//  RafikiApp
//
//  Created by CI-05 on 1/22/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "TreckerViewController.h"
#import "RateViewController.h"
#define kPayPalEnvironment PayPalEnvironmentSandbox

@interface TreckerViewController ()
{
    
}
@end

@implementation TreckerViewController

@synthesize getperamArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.paymentTextField = [[STPPaymentCardTextField alloc] initWithFrame:CGRectMake(15,200, CGRectGetWidth(self.view.frame) - 30, 44)];
    self.paymentTextField.delegate = self;
    [paymentView addSubview:self.paymentTextField];

    
    paymentView.hidden=YES;
    payBtn.layer.cornerRadius=8;
    payBtn.layer.borderWidth=1;
    payBtn.layer.borderColor=[UIColor colorWithRed:128.0/255.0 green:128.0/255.0 blue:128.0/255.0 alpha:1.0].CGColor;
    payBtn.clipsToBounds=YES;
    

    stopButton.layer.cornerRadius=stopButton.frame.size.height/2;
    NSLog(@"peram array:%@",getperamArray);
//    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
//    app.appReviewStr=@"Yes";
     AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self getJobinfoApi];
    app.trecker=[NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(getJobinfoApi) userInfo:nil repeats:YES];
}
-(void)getJobinfoApi
{
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    //    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_current_job.php?userid=%@&user_type=user",useridStr];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_current_job.php"];
    NSDictionary *dictParams ;
    NSString *typestr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    if ([typestr isEqualToString:@"1"])
    {
        dictParams= @{@"userid":useridStr,@"user_type":@"user"};
    }
    else
    {
        dictParams= @{@"userid":useridStr,@"user_type":@"expert"};
    }
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         currentJobArray  =(NSMutableArray *)[responseObject valueForKey:@"data"];
        NSLog(@"ongoingReqarray job dics :%@",currentJobArray);
         NSString *startDateStr=[[currentJobArray objectAtIndex:0] valueForKey:@"created_date"];
         NSString *currentDatestr=[[currentJobArray objectAtIndex:0] valueForKey:@"server_time"];
         [timeLbl setText:[self getTimeDifferenceOf:startDateStr withCurrentdate:currentDatestr]];
         
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
#pragma mark - getTimeDifference method.
- (NSString *)getTimeDifferenceOf:(NSString *)strDate withCurrentdate:(NSString *)strCurDate
{
    NSDateFormatter *curDateFormatter = [[NSDateFormatter alloc] init];
//    NSTimeZone *tz1 = [NSTimeZone timeZoneWithName:@"GMT +5:30"];
    NSTimeZone *tz1 = [NSTimeZone systemTimeZone];
    [curDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [curDateFormatter setTimeZone:tz1];
    NSDate *curDate = [[NSDate alloc] init];
    curDate = [curDateFormatter dateFromString:strCurDate];
    
    NSTimeInterval timer= 1000.0*[curDate timeIntervalSince1970];
    double current = timer;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *tz = [NSTimeZone systemTimeZone];
//    NSTimeZone *tz = [NSTimeZone timeZoneWithName:@"GMT +5:30"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:tz];
    NSDate *date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:strDate];
    
    NSTimeInterval timer1 = 1000.0*[date timeIntervalSince1970];
    double past = timer1;
    
    double SE,MI,HR,DY,MN;//YR;
    SE = 1000;
    MI = SE * 60;
    HR = MI * 60;
    DY = HR * 24;
    MN = DY * 30;
    //YR=MN*12;
    
    double RemailingMil = current-past;
    //NSLog(@"%f",RemailingMil);
    
    //double Year=RemailingMil/YR;
    //double Month=RemailingMil/MN;
    double days = RemailingMil / DY;
    double hours = fmod(RemailingMil, DY) / HR;
    double mint = fmod(RemailingMil, HR) / MI;
    double sec = fmod(RemailingMil, MI) / SE;
    
    //int years=floor(Year);
    // int month=floor(Month);
    int dayss = floor(days);
    int hors = floor(hours);
    int mintt = floor(mint);
    int secc = floor(sec);
    
    NSLog(@"%d",dayss);
    if (hours<10)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"0%d:%d",hors,mintt] forKey:@"lastTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
       return [NSString stringWithFormat:@"0%d:%d",hors,mintt];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d:%d",hors,mintt] forKey:@"lastTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return [NSString stringWithFormat:@"%d:%d",hors,mintt];
    }
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
- (IBAction)backAction:(id)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)stopAction:(id)sender
{
    NSString *typeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    if ([typeStr isEqualToString:@"1"])
    {
       /* NSString *totalTimestr=[[NSUserDefaults standardUserDefaults] objectForKey:@"lastTime"];
        NSArray *saprateArray = [totalTimestr componentsSeparatedByString:@":"];
        
        int hh=[[saprateArray objectAtIndex:0] intValue];
        int mm=[[saprateArray objectAtIndex:1] intValue];
        
        int price=[[getperamArray valueForKey:@"price"] intValue];
        if ([[getperamArray valueForKey:@"price_type"]isEqualToString:@"fix"])
        {
            final=[getperamArray valueForKey:@"price"];
        }
        else
        {
            final =[NSString stringWithFormat:@"%d",(price*hh)+(price *mm/60)];
        }
        int chackPrice=[final intValue];
        //    if (chackPrice <=2)
        //    {
        //        [[[UIAlertView alloc] initWithTitle:@"Payment not possible" message:@"payment is less than $2" delegate:self cancelButtonTitle:@"Okay Got it" otherButtonTitles:nil, nil] show];
        //    }
        //    else
        //    {
        NSLog(@"final price is:%@",final);
        PayPalItem *item1 = [PayPalItem itemWithName:@"User payment"
                                        withQuantity:1
                                           withPrice:[NSDecimalNumber decimalNumberWithString:@"10.0f"]
                                        withCurrency:@"USD"
                                             withSku:@"Hip-00037"];
        NSArray *items = @[item1];
        NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
        
        // Optional: include payment details
        //    NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"5.99"];
        //    NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"2.50"];
        PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
                                                                                   withShipping:nil
                                                                                        withTax:nil];
        NSDecimalNumber *total = [[subtotal decimalNumberByAdding:@""] decimalNumberByAdding:@""];
        
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        payment.amount = total;
        payment.currencyCode = @"USD";
        payment.shortDescription = @"Expert Total Payment";
        payment.items = items;  // if not including multiple items, then leave payment.items as nil
        payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
        if (!payment.processable) {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
        }
        // Update payPalConfig re accepting credit cards.
        self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
        
        PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                    configuration:self.payPalConfig
                                                                                                         delegate:self];
        [self presentViewController:paymentViewController animated:YES completion:nil];*/
        paymentView.hidden=NO;
    }
    else
    {
//        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        ExpertRateViewController *rate=[[ExpertRateViewController alloc] init];
        rate.getperamArray=currentJobArray;
        [self.navigationController pushViewController:rate animated:YES];
    }
//    }
  /*  UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Confirmation" message:@"Are you sure you want complete this job?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];*/
}
#pragma StripMethod
- (void)paymentCardTextFieldDidChange:(STPPaymentCardTextField *)textField
{
    payBtn.enabled = textField.isValid;
}
- (void)paymentView:(TreckerViewController *)controller didFinish:(NSError *)error
{
    if (error) {
        [self presentError:error];
    } else {
        [self paymentSucceeded];
    }
}
- (void)presentError:(NSError *)error
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    //    [self presentViewController:controller animated:YES completion:nil];
}

- (void)paymentSucceeded {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Payment successfully created!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    });
}
//- (void)createBackendChargeWithToken:(STPToken *)token completion:(STPTokenSubmissionHandler)completion
//{
//    if(token.tokenId.length != 0 && token.tokenId != (id)[NSNull null])
//    {
////        [self.activityIndicator startAnimating];
//              NSLog(@"my token is :-> %@",token.tokenId);
//        AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
//        
//        if (app.trecker||[app.trecker isValid])
//        {
//            [app.trecker invalidate];
//        }
//        stopButton.enabled=NO;
//        stopButton.alpha=0.5;
////        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        int price=[[[currentJobArray objectAtIndex:0] valueForKey:@"price_per_session"] intValue];
//        [MBProgressHUD showHUDAddedTo:paymentView animated:YES];
//        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
//        
//        NSURL *url = [NSURL URLWithString:@"http://cricyard.com/iphone/rafiki_app/service/stripe_payments.php"];
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//        request.HTTPMethod = @"POST";
//        
//        NSLog(@"Payment Token is : %@",token.tokenId);
//        
//        NSString *postBody = [NSString stringWithFormat:@"amount=%d&token=%@",price,token.tokenId];
//        NSLog(@"Url is :- %@",postBody);
//        NSData *data = [postBody dataUsingEncoding:NSUTF8StringEncoding];
//        [request setHTTPBody:data];
//        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)
//         {
//             NSMutableDictionary *dictData  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &connectionError];
//             NSLog(@"dictData === %@",dictData);
//             
//             NSString *Message = [dictData objectForKey:@"msg"];
//             if ([Message isEqualToString:@"sucess"])
//             {
//                 dispatch_sync(dispatch_get_main_queue(), ^{
//                    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//                     RateViewController *rate=[[RateViewController alloc] init];
//                     rate.getperamArray=currentJobArray;
//                     [self.navigationController pushViewController:rate animated:YES];
//                 });
//                
//             }
//             else
//             {
//                 [MBProgressHUD hideHUDForView:paymentView animated:YES];
//             }
//         }];
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Rafikki" message:@"invalid token,please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}
//- (IBAction)payBtnAction:(id)sender
//{
//    [[STPAPIClient sharedClient] createTokenWithCard:self.paymentTextField.cardParams
//                                          completion:^(STPToken *token, NSError *error)
//    {
//                                              
//                                              if (error)
//                                              {
//                                                  [self paymentView:self didFinish:error];
//                                              }
//                                              NSLog(@"Stripe Tocken is:%@",token);
//                                              [self createBackendChargeWithToken:token
//                                                                      completion:^(STPBackendChargeResult result, NSError *error)
//                                              {
//                                                                          if (error)
//                                                                          {
//                                                                              [self paymentView:self didFinish:error];
//                                                                              return;
//                                                                          }
//                                                                          [self paymentView:self didFinish:nil];
//                                              }];
//    }];
//}
- (IBAction)paymentBackAction:(id)sender
{
    paymentView.hidden=YES;
}
-(void)passInsertPaymentApi
{
    //http://cricyard.com/iphone/rafiki_app/service/insert_payment.php?job_id=1&job_detail=nice&sender_id=1&receiver_id=2&amount=25&paypal_transaction_id=123&payment_status=paid&transaction_date=date&platform=android
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/insert_payment.php"];
    NSDictionary *dictParams;
    dictParams= @{@"job_id":[currentJobArray valueForKey:@"invite_id"],@"job_detail":[currentJobArray valueForKey:@"job_detail"],@"sender_id":[currentJobArray valueForKey:@"user_id"],@"receiver_id":[currentJobArray valueForKey:@"expert_id"],@"amount":@"10",@"paypal_transaction_id":[[paymentResponseDics valueForKey:@"response"] valueForKey:@"id"],@"payment_status":[[paymentResponseDics valueForKey:@"response"] valueForKey:@"state"],@"transaction_date":[[paymentResponseDics valueForKey:@"response"] valueForKey:@"create_time"],@"platform":[[paymentResponseDics valueForKey:@"client"] valueForKey:@"platform"]};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
         if (app.trecker||[app.trecker isValid])
         {
             [app.trecker invalidate];
         }
         stopButton.enabled=NO;
         stopButton.alpha=0.5;
         
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
         RateViewController *rate=[[RateViewController alloc] init];
         rate.getperamArray=currentJobArray;
         [self.navigationController pushViewController:rate animated:YES];
         
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
#pragma mark - Authorize Future Payments

/*- (IBAction)getUserAuthorizationForFuturePayments:(id)sender
{
    PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
    [self presentViewController:futurePaymentViewController animated:YES completion:nil];
}*/
#pragma mark alertview delegate methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==1)
    {
        
    }
    else
    {
    }
}
@end
