//
//  AboutJobViewController.m
//  RafikiApp
//
//  Created by CI-05 on 1/6/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "AboutJobViewController.h"
#import "AFNetworking/AFNetworking.h"
@interface AboutJobViewController ()

@end

@implementation AboutJobViewController
@synthesize expertIdStr,expertDetailArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Expert Detail Array is:%@",expertDetailArray);
//    int margin=30;
   /* priceSwitchText=@"hourly";
    self.switcher = [[DVSwitch alloc] initWithStringsArray:@[@"hourly",@"fix"]];
    self.switcher.frame = CGRectMake(20,jobDetailTxtview.frame.origin.y+jobDetailTxtview.frame.size.height+30, [[UIScreen mainScreen] bounds].size.width - 20 * 2, 30);
    self.switcher.font = [UIFont fontWithName:@"Roboto-Regular" size:14];//2 113 151
    self.switcher.backgroundColor = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0];
    self.switcher.sliderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.switcher.labelTextColorInsideSlider = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0];
    [self.view addSubview:self.switcher];
    [self.switcher setPressedHandler:^(NSUInteger index)
     {
         if (index==0)
         {
           priceSwitchText=@"hourly";
         }
         else
         {
           priceSwitchText=@"fix";
         }
         NSLog(@"Did press position on first switch at index: %lu", (unsigned long)index);
     }];*/
    inviteBtn.layer.cornerRadius=inviteBtn.frame.size.height/2;
    
//    [self.view addSubview:dateView];
    dateView.frame=CGRectMake(dateView.frame.origin.x, [[UIScreen mainScreen] bounds].size.height+100, dateView.frame.size.width, dateView.frame.size.height);
    
    mainScrollView.contentSize=CGSizeMake(mainScrollView.frame.size.width,inviteBtn.frame.origin.y+ inviteBtn.frame.size.height+20);
    
    locationArray=[[NSMutableArray alloc] init];
    selectSkillArray=[[NSMutableArray alloc] init];
   /* NSString *locaStr=[expertDetailArray valueForKey:@"location"];
    NSArray* myArray = [locaStr  componentsSeparatedByString:@","];

    for (int b=0; b<myArray.count; b++)
    {
        [locationArray addObject:[myArray objectAtIndex:b]];
    }*/
    
//    NSLog(@"what can i teach:%@",[[[expertDetailArray valueForKey:@"what_i_teach"] valueForKey:@"address"] objectAtIndex:0]);
    
    for (int a=0; a<[[expertDetailArray valueForKey:@"what_i_teach"]count]; a++)
    {
        [locationArray addObject:[[[expertDetailArray valueForKey:@"what_i_teach"] valueForKey:@"address"] objectAtIndex:a]];
    }
    [self createSkillButton];
    
    locationPopview.hidden=YES;
    
    if ([[expertDetailArray valueForKey:@"login_status"]isEqualToString:@"1"])
    {
        [nowButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}
-(void)createSkillButton
{
    x=5;
    y=5;
    for (int a=0; a<[[expertDetailArray valueForKey:@"what_i_teach"]count]; a++)
    {
        UIButton *skillBtn=[UIButton buttonWithType: UIButtonTypeCustom];
        [skillBtn setImage:[UIImage imageNamed:@"radio_btn_unselected"] forState:UIControlStateNormal];
          UILabel *nameLbl=[[UILabel alloc] init];
        if(x<=211)
        {
            skillBtn.frame=CGRectMake(x, y, 20, 20);
            nameLbl.frame=CGRectMake(x+skillBtn.frame.size.width+2,y-2,75,25);
        }
        else
        {
            x=5;
            y=y+nameLbl.frame.size.height+30;
            skillBtn.frame=CGRectMake(x, y, 20, 20);
            nameLbl.frame=CGRectMake(x+skillBtn.frame.size.width+2,y-2,75,25);
        }
        skillBtn.tag=a;
        [skillBtn addTarget:self action:@selector(skillAction:) forControlEvents:UIControlEventTouchDown];
       // nameLbl.text=[[[expertDetailArray valueForKey:@"what_i_teach"] valueForKey:@"cat_name"] objectAtIndex:a];
         nameLbl.text=[[[expertDetailArray valueForKey:@"what_i_teach"] valueForKey:@"skill_name"] objectAtIndex:a];
        nameLbl.font=[UIFont fontWithName:@"Roboto-Medium" size:10];
        nameLbl.textColor=[UIColor colorWithRed:174.0/255 green:174.0/255 blue:180.0/255 alpha:1];
        [skillScrollview addSubview:nameLbl];
        [skillScrollview addSubview:skillBtn];
        x=x+25+nameLbl.frame.size.width;
    }
    skillScrollview.contentSize=CGSizeMake(skillScrollview.frame.size.width, y+30);
}
-(IBAction)skillAction:(UIButton *)sender
{
    UIButton *btn=(UIButton *)sender;
    NSLog(@"%@",[[[expertDetailArray valueForKey:@"what_i_teach"]valueForKey:@"skill_name"] objectAtIndex:[sender tag]]);
    for(UIView * subView in skillScrollview.subviews ) // here write Name of you ScrollView.
    {
        if([subView isKindOfClass:[UIButton class]]) // Check is SubView Class Is UILabel class?
        {
            UIButton *subBtn=(UIButton *)subView;
            if (subBtn.tag==btn.tag)
            {
                skillIDStr=@"";
                [subBtn setImage:[UIImage imageNamed:@"radio_btn_selected"] forState:UIControlStateNormal];
                skillIDStr=[[[expertDetailArray valueForKey:@"what_i_teach"]valueForKey:@"user_skill_id"] objectAtIndex:[sender tag]];
            }
            else
            {
                [subBtn setImage:[UIImage imageNamed:@"radio_btn_unselected"] forState:UIControlStateNormal];
            }
        }
    }
  /*  if (btn.selected==YES)
    {
        [btn setImage:[UIImage imageNamed:@"radio_btn_unselected"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"radio_btn_selected"] forState:UIControlStateNormal];
        [selectSkillArray removeObjectAtIndex:[sender tag]];
        btn.selected=NO;
    }
    else
    {
         [selectSkillArray addObject:[[[expertDetailArray valueForKey:@"what_i_teach"]valueForKey:@"skill_name"] objectAtIndex:[sender tag]]];
        
        [btn setImage:[UIImage imageNamed:@"radio_btn_selected"] forState:UIControlStateNormal];
        btn.selected=YES;
    }*/
}
#pragma mark Custome Date picker
-(void)createCustomDatepicker
{
    CGRect frame;
    if([UIScreen mainScreen].bounds.size.width == 375)
    {
        frame = CGRectMake(20, 80, 320, 200);
    }
    else if ([UIScreen mainScreen].bounds.size.width == 414)
    {
        frame = CGRectMake(40, 80, 320, 200);
    }
    else
    {
        frame = CGRectMake(0, 80, 320, 200);
    }
    
    UUDatePicker *datePicker
    = [[UUDatePicker alloc]initWithframe:frame
                             PickerStyle:0//UUDateStyle_YearMonthDayHourMinute//0//a[i]
                             didSelected:^(NSString *year,
                                           NSString *month,
                                           NSString *day,
                                           NSString *hour,
                                           NSString *minute,
                                           NSString *weekDay){
            [self uuDatePicker:datePicker year:year month:month day:day hour:hour minute:minute weekDay:weekDay];
//                                 [setScheduleButton setTitle:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute] forState:UIControlStateNormal];

                             }];
    [dateView addSubview:datePicker];
    
    /*//FOR MAX LIMIT SET
     //delegate
     NSDate *now = [NSDate date];
     UUDatePicker *datePicker1= [[UUDatePicker alloc]initWithframe:CGRectMake(0, 50, 320, 200)
     Delegate:self
     PickerStyle:UUDateStyle_YearMonthDayHourMinute];
     datePicker1.ScrollToDate = now;
     datePicker1.maxLimitDate = now;
     datePicker1.minLimitDate = [now dateByAddingTimeInterval:-111111111];
     [EventDatePickerView addSubview:datePicker1];
     */
}
#pragma mark - UUDatePicker's delegate
- (void)uuDatePicker:(UUDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay
{
//    [setScheduleButton setTitle:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute] forState:UIControlStateNormal];
    
    dateAndTimeStr=[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute];
}
- (NSInteger)numberOfComponentsInPickerView:(UUDatePicker *)pickerView
{
    return 5;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 0;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.a
}
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [locationArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    cell=nil;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text=[locationArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.7];
    cell.textLabel.font=[UIFont fontWithName:@"Roboto-Medium"size:14];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [selectLocButton setTitle:[locationArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    locationPopview.hidden=YES;
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
    [locationTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == locationPopview)
        {
            NSLog(@"Ok");
            locationPopview.hidden=YES;
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)inviteAction:(id)sender
{
    //[selectLocButton.currentTitle isEqualToString:@"Select Location"]
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"payment_method_add"]isEqualToString:@"No"])
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Rafikki App"
                                      message:@"You don't enter Payment Would you like to enter detail?"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"Yes"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        //yes
                                        SelectAndAddPaymentVC *sele=[[SelectAndAddPaymentVC alloc] init];
                                        [self.navigationController pushViewController:sele animated:YES];
                                    }];
        [alert addAction:yesButton];
        
        UIAlertAction* noButton = [UIAlertAction
                                    actionWithTitle:@"No"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action)
                                    {
                                        [alert dismissViewControllerAnimated:YES completion:nil];
                                    }];
        [alert addAction:noButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        if ([dateAndTimeStr isEqualToString:@""]||dateAndTimeStr.length==0||skillIDStr.length==0||[skillIDStr isEqualToString:@""])
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
        }
        else
        {
            [self passInviteApi];
        }
    }
}
-(void)passInviteApi
{
    // http://cricyard.com/iphone/rafiki_app/service/invite_expert.php?userid=1&expert_id=2&job_detail=want%20to%20teach&price=$50&price_type=hour
    
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *special_instructionStr=addSpecialInsTxtview.text;
    if ([special_instructionStr isEqualToString:@""])
    {
        special_instructionStr=@"";
    }
  /*  NSString *myString;
    for (int a=0; a<selectSkillArray.count; a++)
    {
        if (a==0)
        {
            myString=[selectSkillArray objectAtIndex:a];
        }
        else
        {
            myString=[NSString stringWithFormat:@"%@,%@",myString,[selectSkillArray  objectAtIndex:a]];
        }
    }*/
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/invite_expert.php"];
    NSDictionary *dictParams= @{@"userid":useridStr,@"expert_id":expertIdStr,@"job_detail":@"",@"start_time":[dateAndTimeStr stringByAppendingString:@":00"],@"location":selectLocButton.currentTitle,@"skill":skillIDStr,@"special_instruction":special_instructionStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        NSDictionary *inviteDics =(NSDictionary *) responseObject;

        if ([[inviteDics valueForKey:@"msg"]isEqualToString:@"Job Invite Successfully "])
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Expert hired successfully"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"Ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                            //Handel your yes please button action here
                                            [alert dismissViewControllerAnimated:YES completion:nil];
                                            [self.navigationController popViewControllerAnimated:YES];
                                        }];
            [alert addAction:yesButton];
            [self presentViewController:alert animated:YES completion:nil];
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
- (IBAction)setScheduleAction:(id)sender
{
    [jobDetailTxtview resignFirstResponder];
    [locationTxt resignFirstResponder];
    
    [self createCustomDatepicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    dateView.frame=CGRectMake(dateView.frame.origin.x, [[UIScreen mainScreen] bounds].size.height - dateView.frame.size.height, dateView.frame.size.width, dateView.frame.size.height);
    [UIView commitAnimations];
}
- (IBAction)homeAction:(id)sender
{
    HomeViewController *home=[[HomeViewController alloc] init];
    [self.navigationController pushViewController:home animated:YES];
}
- (IBAction)nowAction:(id)sender
{
    /*if ([[expertDetailArray valueForKey:@"login_status"]isEqualToString:@"1"])
    {
        [[[UIAlertView alloc] initWithTitle:@"this trainer is not online" message:nil delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil] show];
    }
    else
    {
        [nowButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }*/
    NSString *myDayString;
    NSString *myMonthString;
    NSString *myYearString;
    NSString *myHourString;
    NSString *myMinuteString;

    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateFormat:@"dd"];
    myDayString = [df stringFromDate:[NSDate date]];
    
    [df setDateFormat:@"MM"];
    myMonthString = [df stringFromDate:[NSDate date]];
    
    [df setDateFormat:@"YYYY"];
    myYearString = [df stringFromDate:[NSDate date]];
    
    [df setDateFormat:@"HH"];
    myHourString = [df stringFromDate:[NSDate date]];
    
    [df setDateFormat:@"mm"];
    myMinuteString = [df stringFromDate:[NSDate date]];
   
    dateAndTimeStr=[NSString stringWithFormat:@"%@-%@-%@ %@:%@",myYearString,myMonthString,myDayString,myHourString,myMinuteString];
    
    [setScheduleButton setTitle:[NSString stringWithFormat:@"%@-%@-%@ %@:%@",myYearString,myMonthString,myDayString,myHourString,myMinuteString] forState:UIControlStateNormal];

    
}
- (IBAction)selectLocAction:(id)sender
{
    locationPopview.hidden=NO;
}
- (IBAction)doneAction:(id)sender
{
    if ([dateAndTimeStr isEqualToString:@""]||dateAndTimeStr.length==0)
    {
        [setScheduleButton setTitle:@"set schedule" forState:UIControlStateNormal];
    }
    else
    {
        [setScheduleButton setTitle:dateAndTimeStr forState:UIControlStateNormal];
    }

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    dateView.frame=CGRectMake(dateView.frame.origin.x, [[UIScreen mainScreen] bounds].size.height+10, dateView.frame.size.width, dateView.frame.size.height);
    [UIView commitAnimations];
}
- (IBAction)cancelAction:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    dateView.frame=CGRectMake(dateView.frame.origin.x, [[UIScreen mainScreen] bounds].size.height+10, dateView.frame.size.width, dateView.frame.size.height);
    [UIView commitAnimations];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
        addSpecialInsTxtview.text=@"";
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self.view endEditing:YES];
        if ([addSpecialInsTxtview.text isEqualToString:@"Add Special Instruction Here"] || [addSpecialInsTxtview.text isEqualToString:@""])
        {
            addSpecialInsTxtview.text=@"Add Special Instruction Here";
        }
    }
    return YES;
}
@end
