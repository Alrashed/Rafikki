//
//  TrasactionViewController.m
//  RafikiApp
//
//  Created by CI-05 on 2/10/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "TrasactionViewController.h"

@interface TrasactionViewController ()

@end

@implementation TrasactionViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
