//
//  BecomeRafikkiVC.m
//  RafikiApp
//
//  Created by CI-05 on 3/25/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "BecomeRafikkiVC.h"

@interface BecomeRafikkiVC ()

@end

@implementation BecomeRafikkiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    startButton.layer.cornerRadius=startButton.frame.size.height/2;
    startButton.layer.borderColor=[UIColor whiteColor].CGColor;
    startButton.layer.borderWidth=1;
    startButton.clipsToBounds=YES;
    
    roundLbl1.layer.cornerRadius=roundLbl1.frame.size.width/2;
    roundLbl1.clipsToBounds=YES;
    
    roundLbl2.layer.cornerRadius=roundLbl2.frame.size.width/2;
    roundLbl2.clipsToBounds=YES;
    
    roundLbl3.layer.cornerRadius=roundLbl3.frame.size.width/2;
    roundLbl3.clipsToBounds=YES;
    
    roundLbl4.layer.cornerRadius=roundLbl4.frame.size.width/2;
    roundLbl4.clipsToBounds=YES;
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)startAction:(id)sender
{
    check_DiclosesVC *chack=[[check_DiclosesVC alloc] initWithNibName:@"check&DiclosesVC" bundle:nil];
    [self.navigationController pushViewController:chack animated:YES];
}
@end
