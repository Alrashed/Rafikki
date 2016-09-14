
//
//  PaymentInfoVC.m
//  RafikiApp
//
//  Created by CI-05 on 4/20/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "PaymentInfoVC.h"

@interface PaymentInfoVC ()

@end

@implementation PaymentInfoVC
- (void)viewDidLoad
{
    [super viewDidLoad];
    monYearView.hidden=YES;
    monthArray=[[NSMutableArray alloc] initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil];
    yearArray=[[NSMutableArray alloc] init];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *currDate = [NSDate date];
    NSDateComponents *dComp = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
                                          fromDate:currDate];
    int year = (int)[dComp year];
    yearArray=[[NSMutableArray alloc] init];
    
    for (int i=year; i<=year+50; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    monthStr=@"01";
    YearStr=@"2016";
    // Do any additional setup after loading the view from its nib.
}
-(void)passPaymentInfoApi
{
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    //http://cricyard.com/iphone/rafiki_app/service/add_strip_payment_method.php?user_id=1&name=samir%20makadia&card_number=123456789789&month=09&year=2021&cvc=525
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/add_strip_payment_method.php"];
    NSDictionary *dictParams = @{@"user_id":userId,@"name":nameTxt.text,@"card_number":cardNumberTxt.text,@"month":monthStr,@"year":YearStr,@"cvc":cvcTxt.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"skill Response is:%@",responseObject);
         
         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:nil delegate:self cancelButtonTitle:@"Next" otherButtonTitles:@"Save & Next", nil];
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
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        //Next
        DoneSignupVC *done=[[DoneSignupVC alloc] init];
        [self.navigationController pushViewController:done animated:YES];
    }
    else
    {
        //Save & Next
        [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen7_payment"];
        DoneSignupVC *done=[[DoneSignupVC alloc] init];
        [self.navigationController pushViewController:done animated:YES];
    }
}
#pragma mark PickerView Delegate Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 2;//Or return whatever as you intend
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0)
    {
        return monthArray.count;
    }
    else
    {
        return yearArray.count;
    }
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0)
    {
        return [NSString stringWithFormat:@"%@",[monthArray objectAtIndex:row]];
    }
    else
    {
        return [NSString stringWithFormat:@"%@",[yearArray objectAtIndex:row]];
    }
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==0)
    {
        monthStr=[monthArray objectAtIndex:row];
    }
    else
    {
        YearStr=[NSString stringWithFormat:@"%@",[yearArray objectAtIndex:row]];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)DoneAction:(id)sender
{
    [monYearView setHidden:YES];
    monthYearTxt.text=[NSString stringWithFormat:@"%@/%@",monthStr,YearStr];
}
- (IBAction)cancelAction:(id)sender
{
    [monYearView setHidden:YES];
}
- (IBAction)backAction:(id)sender
{    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)nextAction:(id)sender
{
    if ([nameTxt.text isEqualToString:@""]||[cardNumberTxt.text isEqualToString:@""]||[cvcTxt.text isEqualToString:@""]||[monthYearTxt.text isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"Please enter all detail" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passPaymentInfoApi];
    }
}
- (IBAction)skipAction:(id)sender
{
    DoneSignupVC *done=[[DoneSignupVC alloc] init];
    [self.navigationController pushViewController:done animated:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==monthYearTxt)
    {
        [textField resignFirstResponder];
        [monYearView setHidden:NO];
    }
}
@end
