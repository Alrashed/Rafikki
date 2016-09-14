//
//  MessageViewController.m
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
@end
@implementation MessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [IQKeyboardManager sharedManager].enable=YES;
     [sliderButtton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
    [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passGetChatlistApi];
}
-(void)passGetChatlistApi
{
    NSString  *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/user_chat_list.php"];
    NSDictionary *dictParams= @{@"user_id":useridStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"Chat list Response: %@",responseObject);
        historyArray =(NSMutableArray *)responseObject;
        [messageListTbl reloadData];
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
    return [[historyArray valueForKey:@"result"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MessageListCell";
    MessageListCell *cell = (MessageListCell *)[messageListTbl dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    cell=nil;
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MessageListCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.messageUserImageview.image=[UIImage imageNamed:@"photo"];
    
    [cell.messageUserImageview setImageWithURL:[NSURL URLWithString:[[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"photo"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [cell.messageTitleLbl setTitle:[NSString stringWithFormat:@"%@ %@",[[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]] forState:UIControlStateNormal];
    
    cell.messageTitleLbl.tag=indexPath.row;
    [cell.messageTitleLbl addTarget:self action:@selector(profileViewClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.messageDetailLbl.text=[[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"chat_text"];
    NSString *dateStr = [[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"date"];
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
    
    NSArray *arr = [dateStr componentsSeparatedByString:@","];
    NSString *dayStr = [arr objectAtIndex:0];
    
    if ([dayStr isEqualToString:@"Today"])
    {
        cell.timeLbl.text=[arr objectAtIndex:1];
    }
    else if ([dayStr isEqualToString:@"Yesterday"])
    {
        cell.timeLbl.text=[arr objectAtIndex:0];
    }
    else
    {
        //date formatter for the above string
        NSDateFormatter *dateFormatterWS = [[NSDateFormatter alloc] init];
        [dateFormatterWS setDateFormat:@"MM/dd/yy,HH:mm a"];
        
        NSDate *date =[dateFormatterWS dateFromString:dateStr];
        //date formatter that you want
        NSDateFormatter *dateFormatterNew = [[NSDateFormatter alloc] init];
        [dateFormatterNew setDateFormat:@"MMM dd"];
        
        NSString *stringForNewDate = [dateFormatterNew stringFromDate:date];
        NSLog(@"Date %@",stringForNewDate);
        cell.timeLbl.text=stringForNewDate;
    }
    NSString *messageCounter=[[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"message_count"];
    if ([messageCounter isEqualToString:@"0"])
    {
        cell.messageCounterLbl.hidden=YES;
    }
    else
    {
        cell.messageCounterLbl.hidden=NO;
        cell.messageCounterLbl.layer.cornerRadius=cell.messageCounterLbl.frame.size.height/2;
        cell.messageCounterLbl.clipsToBounds=YES;
        cell.messageCounterLbl.text=messageCounter;
    }
    
    cell.messageUserImageview.layer.cornerRadius=cell.messageUserImageview.frame.size.height/2;
    cell.messageUserImageview.clipsToBounds=YES;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    MessageListCell *cell = (MessageListCell *) [messageListTbl cellForRowAtIndexPath:indexPath];
//    cell.messageCounterLbl.hidden=YES;
    
    ChatViewController *chat=[[ChatViewController alloc] init];
    chat.fromUserIdStr=[[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"send_user_id"];
    chat.profileClickFlag=@"Yes";
    chat.fromUserName=[NSString stringWithFormat:@"%@ %@",[[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
    chat.fromUserDesignation=[[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"online_status"];
    chat.fromUserProfilepicStr=[[[historyArray valueForKey:@"result"] objectAtIndex:indexPath.row] valueForKey:@"photo"];
    NSLog(@"not called :%@",chat.fromUserIdStr);
    [self.navigationController pushViewController:chat animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    [messageListTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65;
}
-(IBAction)profileViewClick:(id)sender
{
    NSString *userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    if ([userTypeStr isEqualToString:@"1"])
    {
        ProfileViewController *pr=[[ProfileViewController alloc] init];
         pr.expertIdStr =[[[historyArray valueForKey:@"result"] objectAtIndex:[sender tag]]valueForKey:@"send_user_id"];
         pr.userFlag=@"expert";
         pr.chackviewFlagStr=@"guest";
        [self.navigationController pushViewController:pr animated:YES];
    }
    else
    {
        UserProfileViewcontroller *pr=[[UserProfileViewcontroller alloc] init];
        pr.idStr=[[[historyArray valueForKey:@"result"] objectAtIndex:[sender tag]]valueForKey:@"send_user_id"];
        pr.userFlag=@"user";
        pr.viewTypeStr=@"guest";
        [self.navigationController pushViewController:pr animated:YES];
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
