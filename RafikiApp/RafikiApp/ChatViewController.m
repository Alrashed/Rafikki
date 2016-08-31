//
//  ChatViewController.m
//  RafikiApp
//
//  Created by CI-05 on 1/23/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "ChatViewController.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ChatViewController ()

@end

@implementation ChatViewController
@synthesize fromUserIdStr,fromUserDesignation,fromUserName,fromUserProfilepicStr,profileClickFlag;
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    [IQKeyboardManager sharedManager].enable=NO;
    
    if ([profileClickFlag isEqualToString:@"Yes"])
    {
        profileButton.enabled=YES;
    }

    userImageView.layer.cornerRadius=userImageView.frame.size.width/2;
    userImageView.clipsToBounds=YES;
    
    userTitleLbl.text=fromUserName;
    designationLbl.text=fromUserDesignation;
    [userImageView setImageWithURL:[NSURL URLWithString:fromUserProfilepicStr]placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    setFirstTime=YES;
    [self passGetOldMessageApi];
    messageTxt.inputAccessoryView = [[UIView alloc] init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    if ([messageTxt isFirstResponder])
    {
        NSDictionary *userInfo = [notification userInfo];
        CGRect rect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        [UIView animateWithDuration:0.5 animations:^{
            messageTxtView.frame = CGRectMake(messageTxtView.frame.origin.x, (kScreenHeight-messageTxtView.frame.size.height)-rect.size.height, messageTxtView.frame.size.width, messageTxtView.frame.size.height);
            //            commentTable.frame=CGRectMake(commentTable.frame.origin.x, commentTable.frame.origin.y, commentTable.frame.size.width,commentTable.frame.size.height-rect.size.height+self.bannerView.frame.size.height);//[[UIScreen mainScreen]bounds].size.height-252
        }];
        //self.viewBottom.frame = CGRectMake(0, self.viewBottom.frame.origin.y-rect.size.height, self.viewBottom.frame.size.width, self.viewBottom.frame.size.height);
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if ([messageTxt isFirstResponder])
    {
        messageTxtView.frame = CGRectMake(messageTxtView.frame.origin.x, self.view.frame.size.height-messageTxtView.frame.size.height, messageTxtView.frame.size.width, messageTxtView.frame.size.height);
        //        commentTable.frame=CGRectMake(commentTable.frame.origin.x, commentTable.frame.origin.y, commentTable.frame.size.width, [[UIScreen mainScreen] bounds].size.height-commentTable.frame.origin.y-sendCommentBgView.frame.size.height-sendCommentBgView.frame.size.height-25);
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (getAllmessageTimer||[getAllmessageTimer isValid])
    {
        [getAllmessageTimer invalidate];
        getAllmessageTimer=nil;
    }
}
-(void)passGetOldMessageApi
{
  //  http://cricyard.com/iphone/rafiki_app/service/chat_list.php?send_user_id=1&from_user_id=2
    
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/chat_list.php"];
    NSDictionary *dictParams= @{@"send_user_id":useridStr,@"from_user_id":fromUserIdStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Old message Response: %@",responseObject);
        messageArray=(NSMutableArray *)responseObject;
        [chatTbl reloadData];
        if (setFirstTime==YES)
        {
            if (messageArray.count != 0)
            {
                //set Bottom in tableView
                NSIndexPath* ipath = [NSIndexPath indexPathForRow: messageArray.count-1 inSection: 0];
                [chatTbl scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: NO];
            }
            setFirstTime=NO;
        }
        if (getAllmessageTimer||[getAllmessageTimer isValid ])
        {
            [getAllmessageTimer invalidate];
            getAllmessageTimer=nil;
        }
        getAllmessageTimer=[NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(passGetOldMessageApi) userInfo:nil repeats:YES];
        
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
- (BOOL)textFieldShouldReturn:(UITextField *)TEXTFIELD
{
    [TEXTFIELD resignFirstResponder];
    return YES;
}
-(void)passInsertMessageApi
{
    // http://cricyard.com/iphone/rafiki_app/service/user_chat.php?send_user_id=1&from_user_id=2&message=hi

    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/user_chat.php"];
//    NSString *messageStr=[messageTxt.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dictParams= @{@"send_user_id":fromUserIdStr,@"from_user_id":useridStr,@"message":messageTxt.text};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=(NSDictionary *)responseObject;
        NSLog(@"insert message Response: %@",responseObject);
        if ([[[dic valueForKey:@"msg"] objectAtIndex:0]isEqualToString:@"Success"])
        {
            NSLog(@"message send");
            [self passGetOldMessageApi];
        }
        else
        {
            NSLog(@"message not send");
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
#pragma mark tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messageArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell1";
    //over
    UITableViewCell *ChatTableCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ChatTableCell=nil;
    
    if (!ChatTableCell)
    {
        ChatTableCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if ([useridStr isEqualToString:[[messageArray objectAtIndex:indexPath.row]valueForKey:@"send_user_id"]])
    {
        CGSize f = [[[messageArray valueForKey:@"chat_text"]objectAtIndex:indexPath.row] boundingRectWithSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-10, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{
                                                NSFontAttributeName : [UIFont systemFontOfSize:12]
                                                }
                                      context:nil].size;
        int cellhight=f.height+20;
        
        UILabel *LeftTitleLbl = [[UILabel alloc] initWithFrame: CGRectMake(30, 10, [[UIScreen mainScreen] bounds].size.width-110, cellhight)];
        
        LeftTitleLbl.text =[[messageArray objectAtIndex:indexPath.row] valueForKey:@"chat_text"] ;
        LeftTitleLbl.numberOfLines=0;
        LeftTitleLbl.font=[UIFont systemFontOfSize:12];
        LeftTitleLbl.textColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
        LeftTitleLbl.backgroundColor=[UIColor clearColor];
        LeftTitleLbl.textAlignment = NSTextAlignmentLeft;
        LeftTitleLbl.lineBreakMode = NSLineBreakByCharWrapping;
        LeftTitleLbl.baselineAdjustment = UIBaselineAdjustmentNone;
        
        UIImageView *LaftChatBGImage=[[UIImageView alloc]initWithFrame:CGRectMake(LeftTitleLbl.frame.origin.x-20, LeftTitleLbl.frame.origin.y-10, LeftTitleLbl.frame.size.width+85, cellhight+30)];
        
        LaftChatBGImage.image = [[UIImage imageNamed:@"leftchatBG"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:30];
        
        [ChatTableCell.contentView addSubview:LaftChatBGImage];
        
        UILabel *LeftTimeLBL=[[UILabel alloc]initWithFrame:CGRectMake(LeftTitleLbl.frame.size.width, LeftTitleLbl.frame.size.height+10, 80, 15)];
        LeftTimeLBL.textAlignment=UITextAlignmentRight;
        
        NSString *dateStr = [[messageArray objectAtIndex:indexPath.row] valueForKey:@"date"];
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
        [dateFormatters setDateFormat:@"dd-MM-yyyy hh:mm"];
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
            LeftTimeLBL.text=[arr objectAtIndex:1];
        }
        else if ([dayStr isEqualToString:@"Yesterday"])
        {
            LeftTimeLBL.text=[arr objectAtIndex:0];
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
            LeftTimeLBL.text=stringForNewDate;
        }
        
        //[[messageArray objectAtIndex:indexPath.row]valueForKey:@"time"] ;//section
        LeftTimeLBL.font=[UIFont systemFontOfSize:11];
        LeftTimeLBL.textColor=[UIColor grayColor];
                               //colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
        [ChatTableCell.contentView addSubview:LeftTimeLBL];
        [ChatTableCell.contentView addSubview:LeftTitleLbl];
    }
    else
    {
        CGSize f = [[[messageArray objectAtIndex:indexPath.row]valueForKey:@"chat_text"] boundingRectWithSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-10, MAXFLOAT)
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{
                                                NSFontAttributeName : [UIFont systemFontOfSize:12]
                                                }
                                      context:nil].size;
        int cellhight=f.height+20;
        
        UILabel *RightTitleLbl = [[UILabel alloc] initWithFrame: CGRectMake(30, 10, [[UIScreen mainScreen] bounds].size.width-90, cellhight)];

        RightTitleLbl.text = [[messageArray objectAtIndex:indexPath.row] valueForKey:@"chat_text"];
        RightTitleLbl.numberOfLines=0;
        
        RightTitleLbl.font=[UIFont systemFontOfSize:12];
        RightTitleLbl.textColor=[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
        RightTitleLbl.backgroundColor=[UIColor clearColor];
        RightTitleLbl.textAlignment = NSTextAlignmentLeft;
        RightTitleLbl.lineBreakMode = NSLineBreakByCharWrapping;
        RightTitleLbl.baselineAdjustment = UIBaselineAdjustmentNone;
        
        UIImageView *RightChatBGImage=[[UIImageView alloc]initWithFrame:CGRectMake(RightTitleLbl.frame.origin.x-15, RightTitleLbl.frame.origin.y-10, RightTitleLbl.frame.size.width+65, cellhight+30)];
        
        RightChatBGImage.image = [[UIImage imageNamed:@"rightchatBg"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:30] ;
        [ChatTableCell.contentView addSubview:RightChatBGImage];
        
        [ChatTableCell.contentView addSubview:RightTitleLbl];
        UILabel *RightTimeLBL=[[UILabel alloc]initWithFrame:CGRectMake(RightTitleLbl.frame.size.width-25, RightTitleLbl.frame.size.height+10, 80, 15)];
        
        RightTimeLBL.textAlignment=UITextAlignmentRight;

        
        NSString *dateStr = [[messageArray objectAtIndex:indexPath.row] valueForKey:@"date"];
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
            RightTimeLBL.text=[arr objectAtIndex:1];
        }
        else if ([dayStr isEqualToString:@"Yesterday"])
        {
            RightTimeLBL.text=[arr objectAtIndex:0];
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
            RightTimeLBL.text=stringForNewDate;

        }
        
        
        //[[messageArray objectAtIndex:indexPath.row]valueForKey:@"time"];
        RightTimeLBL.font=[UIFont systemFontOfSize:11];
        RightTimeLBL.textColor=[UIColor grayColor];
                                //colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.8];
        [ChatTableCell.contentView addSubview:RightTimeLBL];
    }
    ChatTableCell.backgroundColor=[UIColor clearColor];
    ChatTableCell.selectionStyle=UITableViewCellSelectionStyleNone;
    return ChatTableCell;
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
    [chatTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize f = [[[messageArray valueForKey:@"chat_text"] objectAtIndex:indexPath.row] boundingRectWithSize:CGSizeMake([[UIScreen mainScreen]bounds].size.width-10, MAXFLOAT)
                                  options:NSStringDrawingUsesLineFragmentOrigin
                               attributes:@{
                                            NSFontAttributeName : [UIFont systemFontOfSize:12]
                                            }
                                  context:nil].size;
    return f.height+50;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    
    [getAllmessageTimer invalidate];
    getAllmessageTimer=nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sendAction:(id)sender
{
    if ([messageTxt.text isEqualToString:@""]||messageTxt.text.length==0)
    {
    }
    else
    {
        [messageTxt resignFirstResponder];
        setFirstTime=YES;
        [self passInsertMessageApi];
        [messageTxt setText:@""];
    }
//    NSDate *myDate = [NSDate date];
    /*NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateStyle:NSDateFormatterLongStyle];
    [f setTimeStyle:NSDateFormatterLongStyle];
    NSString *str=[[messageArray objectAtIndex:0] valueForKey:@"date"];
    NSDate *myDate=[f dateFromString:str];
    [f setDateFormat:@"ZZZ"];
    
    NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
    for (NSString *name1 in timeZoneNames)
    {
        NSTimeZone *tz = [NSTimeZone timeZoneWithName:name1];
        [f setTimeZone:tz];
        
        NSLog(@"%@ = \"%@\" = %d = %@", [tz abbreviation], name1, [tz secondsFromGMT], [f stringFromDate:myDate]);
    }*/
 
}

- (IBAction)homeAction:(id)sender
{
    NSString *userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    if ([userTypeStr isEqualToString:@"1"])
    {
        HomeViewController *home=[[HomeViewController alloc] init];
        [self.navigationController pushViewController:home animated:YES];
    }
    else
    {
        ExpertHomeViewController *home=[[ExpertHomeViewController alloc] init];
        [self.navigationController pushViewController:home animated:YES];
    }

    
}
- (IBAction)homeBtn:(id)sender {
}

- (IBAction)profileAction:(id)sender
{
    NSString *userTypeStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
    if ([userTypeStr isEqualToString:@"1"])
    {
        ProfileViewController *pr=[[ProfileViewController alloc] init];
        pr.expertIdStr =fromUserIdStr;
        pr.userFlag=@"expert";
        pr.chackviewFlagStr=@"guest";
        [self.navigationController pushViewController:pr animated:YES];
    }
    else
    {
        UserProfileViewcontroller *pr=[[UserProfileViewcontroller alloc] init];
        pr.idStr=fromUserIdStr;
        pr.userFlag=@"user";
        pr.viewTypeStr=@"guest";
        [self.navigationController pushViewController:pr animated:YES];
    }
}
@end
