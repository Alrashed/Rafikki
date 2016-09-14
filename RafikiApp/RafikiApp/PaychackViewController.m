//
//  PaychackViewController.m
//  RafikiApp
//
//  Created by CI-05 on 2/4/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "PaychackViewController.h"

@interface PaychackViewController ()
@end

@implementation PaychackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    segmentView.layer.cornerRadius=5;
    segmentView.clipsToBounds=YES;
    [segment setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.5 alpha:0.2]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segment setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:1.0 alpha:1.0]] forState:UIControlStateSelected  barMetrics:UIBarMetricsDefault];
    
    transactionButton.layer.cornerRadius=transactionButton.frame.size.height/2;
    transactionButton.layer.borderColor=[UIColor colorWithRed:46.0/255 green:139.0/255 blue:111.0/255 alpha:1].CGColor;
    transactionButton.layer.borderWidth=1;
    transactionButton.clipsToBounds=YES;
    
    [sliderButton addTarget:self.revealViewController action:@selector(revealToggle:)forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
    [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    chackSegmentStr=@"Week";
    [self getCurrentDayAndCirrentWeekAndCurrentMonthWithDate];
    
   
}
-(void)getCurrentDayAndCirrentWeekAndCurrentMonthWithDate
{
   NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat;
    NSString *dateString2Prev;
 
    NSLog(@"Today date is %@",today);
    dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];// you can use your format.
    
    NSString *Original=[dateFormat stringFromDate:today];
    //Week Start Date
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:today];
    
    int dayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:today] weekday];// this will give you current day of week
    [components setDay:([components day] - ((dayofweek) - 2))];// for beginning of the week.
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateFormat_first = [[NSDateFormatter alloc] init];
    [dateFormat_first setDateFormat:@"yyyy-MM-dd"];
    dateString2Prev = [dateFormat stringFromDate:beginningOfWeek];
    
    thisWeek = [dateFormat_first dateFromString:dateString2Prev];
    
    [components setDay:([components day] - ([components day] -2))];
    thisMonth = [gregorian dateFromComponents:components];
    
    NSDate *now = [NSDate date];
    int daysToAdd = 1;
    NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    NSDateFormatter *dformat = [[NSDateFormatter alloc]init];
    [dformat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *myTodayStr=[dformat stringFromDate:newDate1];
    NSString *myThisWeekStr=[dformat stringFromDate:thisWeek];
    NSString *myThisMonthstr=[dformat stringFromDate:thisMonth];
    
    NSLog(@"This Week%@",myThisWeekStr);
    NSLog(@"This Month%@",myThisMonthstr);
    NSLog(@"This is Today%@",myTodayStr);

    /*if ([chackSegmentStr isEqualToString:@"Today"])
    {
        [self passPayChackApiWithStartDate:Original WithEndDate:myTodayStr];
    }*/
    if ([chackSegmentStr isEqualToString:@"Week"])
    {
        [self passPayChackApiWithStartDate:myThisWeekStr WithEndDate:myTodayStr];
    }
    else if ([chackSegmentStr isEqualToString:@"Month"])
    {
        [self passPayChackApiWithStartDate:myThisMonthstr WithEndDate:myTodayStr];
    }
    else
    {
        [self passPayChackApiWithStartDate:@"" WithEndDate:myTodayStr];
    }
}
-(void)passPayChackApiWithStartDate:(NSString *)startDate WithEndDate:(NSString *)endDate
{
    //http://cricyard.com/iphone/rafiki_app/service/get_completed_job.php?userid=3&startdate=2016-02-01&enddate=2016-02-09
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];

    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_completed_job.php"];
    NSDictionary *dictParams = @{@"userid":useridStr,@"startdate":startDate,@"enddate":endDate};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@",responseObject);
        payChackAll=[[NSMutableArray alloc] init];
        for (int i=0; i < [[responseObject valueForKey:@"data"] count]; i++)
        {
            [payChackAll addObject:[[responseObject valueForKey:@"data"] objectAtIndex:i]];
        }
        NSLog(@"Balance is:%@",[responseObject valueForKey:@"user_balance"]);
        if ([responseObject valueForKey:@"user_balance"] == [NSNull null])
        {
            amountLbl.text=@"$0";
        }
        else
        {
            amountLbl.text=[NSString stringWithFormat:@"$%@",[responseObject valueForKey:@"user_balance"]];
        }
        [payTbl reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[payChackAll valueForKey:@"data"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PaychackCell";
    PaychackCell *cell = (PaychackCell *)[payTbl dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    cell=nil;
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PaychackCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.titleLbl.text=[NSString stringWithFormat:@"%@ %@",[[payChackAll  objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[payChackAll  objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
    cell.subTitleLbl.text=[NSString stringWithFormat:@"$%@ %@",[[payChackAll  objectAtIndex:indexPath.row] valueForKey:@"total_price"],[[payChackAll  objectAtIndex:indexPath.row] valueForKey:@"review_text"]];
    cell.UserPicImageview.layer.cornerRadius=cell.UserPicImageview.frame.size.width/2;
    
    NSString *dateStr = [[payChackAll objectAtIndex:indexPath.row] valueForKey:@"created_date"];
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter1 dateFromString:dateStr];
    NSLog(@"date : %@",date);
    
    NSTimeZone *currentTimeZone = [NSTimeZone localTimeZone];
    NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    
    NSInteger currentGMTOffset = [currentTimeZone secondsFromGMTForDate:date];
    NSInteger gmtOffset = [utcTimeZone secondsFromGMTForDate:date];
    NSTimeInterval gmtInterval = currentGMTOffset - gmtOffset;
    
    NSDate *destinationDate = [[NSDate alloc] initWithTimeInterval:gmtInterval sinceDate:date];
    
    
    
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat:@"dd-MMM-yyyy hh:mm"];
    [dateFormatters setDateStyle:NSDateFormatterShortStyle];
    [dateFormatters setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatters setDoesRelativeDateFormatting:YES];
    [dateFormatters setTimeZone:[NSTimeZone systemTimeZone]];
    dateStr = [dateFormatters stringFromDate: destinationDate];
    NSLog(@"DateString : %@", dateStr);
    
    cell.dateLbl.text=dateStr;
    
    cell.UserPicImageview.clipsToBounds=YES;
    [cell.UserPicImageview setImageWithURL:[NSURL URLWithString:[[payChackAll  objectAtIndex:indexPath.row]valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
    [payTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addSettingPayAction:(id)sender
{
    PaymentDepositMethods *depo=[[PaymentDepositMethods alloc] init];
    [self.navigationController pushViewController:depo animated:YES];
}
- (IBAction)transcationAction:(id)sender
{
    /*TrasactionViewController *tra=[[TrasactionViewController alloc] init];
    [self.navigationController pushViewController:tra animated:YES];*/
}
- (IBAction)paychackSegmentAction:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (segment.selectedSegmentIndex==0)
    {
        chackSegmentStr=@"Week";
        [self getCurrentDayAndCirrentWeekAndCurrentMonthWithDate];
    }
    else if (segment.selectedSegmentIndex==1)
    {
        chackSegmentStr=@"Month";
        [self getCurrentDayAndCirrentWeekAndCurrentMonthWithDate];
    }
    else
    {
        chackSegmentStr=@"All";
        [self getCurrentDayAndCirrentWeekAndCurrentMonthWithDate];
    }
   
}
@end
