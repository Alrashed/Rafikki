//
//  check&DiclosesVC.m
//  RafikiApp
//
//  Created by CI-05 on 3/25/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "check&DiclosesVC.h"

@interface check_DiclosesVC ()

@end

@implementation check_DiclosesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)agreeAction:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if (btn.selected==YES)
    {
        btn.selected=NO;
    }
    else
    {
        btn.selected=YES;
    }
}

- (IBAction)nextAction:(id)sender
{
    if (agreeBtn.selected==YES)
    {
        ExpertSignupVC *sign=[[ExpertSignupVC alloc] init];
        [self.navigationController pushViewController:sign animated:YES];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"please agree all terms and condition" delegate:self cancelButtonTitle:@"okay" otherButtonTitles:nil, nil] show];
    }
    
}
@end
