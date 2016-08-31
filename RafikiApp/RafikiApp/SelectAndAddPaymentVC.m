//
//  SelectAndAddPaymentVC.m
//  RafikiApp
//
//  Created by CI-05 on 3/18/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "SelectAndAddPaymentVC.h"
#define  ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define  ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface SelectAndAddPaymentVC ()

@end

@implementation SelectAndAddPaymentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    paymentPopView.frame = CGRectMake(ScreenWidth*20/320, ScreenHeight*177/568, ScreenWidth*280/320, ScreenHeight*215/568);
    popTileLbl.frame=CGRectMake(ScreenWidth*43/320, ScreenHeight*14/568, ScreenWidth*193/320, ScreenHeight*26/568);
    line1Img.frame=CGRectMake(ScreenWidth*0/320, ScreenHeight*110/568, ScreenWidth*280/320, ScreenHeight*1/568);
    line2Img.frame=CGRectMake(ScreenWidth*0/320, ScreenHeight*50/568, ScreenWidth*280/320, ScreenHeight*1/568);
    popIconImg.frame=CGRectMake(ScreenWidth*8/320, ScreenHeight*70/568, ScreenWidth*24/320, ScreenHeight*22/568);
    addAccountBtn.frame=CGRectMake(ScreenWidth*10/320, ScreenHeight*166/568, ScreenWidth*261/320, ScreenHeight*42/568);
    popBgImg.frame=CGRectMake(ScreenWidth*0/320, ScreenHeight*0/568, ScreenWidth*280/320, ScreenHeight*215/568);
    self.paymentDetailTxt = [[STPPaymentCardTextField alloc] initWithFrame:CGRectMake(ScreenWidth*40/320, ScreenHeight*60/568, ScreenWidth*235/320, ScreenHeight*40/568)];
    self.paymentDetailTxt.delegate = self;
    self.paymentDetailTxt.backgroundColor=[UIColor whiteColor];
    self.paymentDetailTxt.layer.cornerRadius=self.paymentDetailTxt.frame.size.height/2;
    self.paymentDetailTxt.layer.borderColor=[UIColor colorWithRed:55.0/255.0 green:166.0/255.0 blue:145.0/255.0 alpha:1.0].CGColor;
    self.paymentDetailTxt.layer.borderWidth=1;
    [paymentPopView addSubview:self.paymentDetailTxt];
    
    [sliderButton addTarget:self.revealViewController action:@selector(revealToggle:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
    [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
    
    paypalPopView.hidden=YES;
    
    hintLbl.frame=CGRectMake(ScreenWidth*8/320, ScreenHeight*108/568, ScreenWidth*272/320, ScreenHeight*52/568);

    
    addAccountBtn.layer.cornerRadius=addAccountBtn.frame.size.height/2;
    addAccountBtn.layer.borderColor=[UIColor whiteColor].CGColor;
    addAccountBtn.layer.borderWidth=1;
    addAccountBtn.clipsToBounds=YES;
}
-(void)passAddAccountDetailApiWithCardNumber:(NSString *)cardNo WithExpireMonth:(NSString *)expMonth WithExpireYear:(NSString *)expireYear WithCvc:(NSString *)accountCvc
{
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/add_strip_payment_method.php"];
    NSDictionary *dictParams = @{@"user_id":userId,@"name":[[NSUserDefaults standardUserDefaults] objectForKey:@"firstName"],@"card_number":cardNo,@"month":expMonth,@"year":expireYear,@"cvc":accountCvc};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"skill Response is:%@",responseObject);
         [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"payment_method_add"];
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"Account added successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alert show];
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
- (IBAction)addMethodAction:(id)sender
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"Choose Methods" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Credit Card",nil];
    [self parentViewController];
    [action showInView:self.view];
}

- (IBAction)addAcoountAction:(id)sender
{
    NSLog(@"card number is:%@",self.paymentDetailTxt.cardNumber);
    NSLog(@"expirationMonth is:%lu",(unsigned long)self.paymentDetailTxt.expirationMonth);
    NSLog(@"expirationYear is:%lu",(unsigned long)self.paymentDetailTxt.expirationYear);
    NSLog(@"cvc is:%@",self.paymentDetailTxt.cvc);
    
    [self passAddAccountDetailApiWithCardNumber:[NSString stringWithFormat:@"%@",self.paymentDetailTxt.cardNumber] WithExpireMonth:[NSString stringWithFormat:@"%lu",(unsigned long)self.paymentDetailTxt.expirationMonth] WithExpireYear:[NSString stringWithFormat:@"%lu",(unsigned long)self.paymentDetailTxt.expirationYear] WithCvc:self.paymentDetailTxt.cvc];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        paypalPopView.hidden=NO;
    }
}
#pragma StripMethod
- (void)paymentCardTextFieldDidChange:(STPPaymentCardTextField *)textField
{
    NSLog(textField.isValid ? @"Yes" : @"No");
    
    if (textField.isValid)
    {
        addAccountBtn.enabled=YES;
        addAccountBtn.alpha=1.0;
    }
    else
    {
        addAccountBtn.enabled=NO;
        addAccountBtn.alpha=0.5;
    }
}
- (void)paypalPopView:(TreckerViewController *)controller didFinish:(NSError *)error
{
    if (error)
    {
        [self presentError:error];
    }
}
- (void)presentError:(NSError *)error
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [controller addAction:action];
    //    [self presentViewController:controller animated:YES completion:nil];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == paypalPopView)
        {
            NSLog(@"Ok");
            paypalPopView.hidden=YES;
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
}
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==paymentTbl)
    {
        return 0;
    }
    else
    {
        static NSString *MyIdentifier = @"MyIdentifier";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        //    cell=nil;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==paymentTbl)
    {
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    [paymentTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
@end
