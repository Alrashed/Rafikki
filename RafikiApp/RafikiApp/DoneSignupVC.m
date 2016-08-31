//
//  DoneSignupVC.m
//  RafikiApp
//
//  Created by CI-05 on 4/20/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "DoneSignupVC.h"

@interface DoneSignupVC ()

@end

@implementation DoneSignupVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)finishAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"loginCheck"];
    
    NSString *userIdStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"userType"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"is_filledValue"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen1_basic"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen2_verify"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen3_personal"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen4_Socail"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen5_photoId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen6_Aboutme"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"screen7_payment"];
    
    
    [self passChangeModeApiWithUserid:userIdStr WithUserType:@"2"];
    userTypeStr=@"2";
}
-(void)passChangeModeApiWithUserid:(NSString *)userid WithUserType:(NSString *)usertype
{
    // http://cricyard.com/iphone/rafiki_app/service/change_user_type.php?userid=1&type=2
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/change_user_type.php"];
    NSDictionary *dictParams = @{@"userid":userid,@"type":usertype};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@",responseObject);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        NSString *filedStr=[responseObject valueForKey:@"is_filled"];
        NSLog(@"user isFiled:%@",filedStr);
        ExpertHomeViewController  *home=[[ExpertHomeViewController alloc] init];
        [self.navigationController pushViewController:home animated:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"problem");
     }];
}
@end
