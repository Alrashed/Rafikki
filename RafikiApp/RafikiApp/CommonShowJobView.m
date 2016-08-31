//
//  CommonShowJobView.m
//  RafikiApp
//
//  Created by CI-05 on 1/12/16.
//  Copyright © 2016 CI-05. All rights reserved.
//
#import "CommonShowJobView.h"

@interface CommonShowJobView ()

@end

@implementation CommonShowJobView
@synthesize priceStr,priceTypeStr,jobDetailStr,jobDetailArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *skillStr=[jobDetailArray valueForKey:@"skill"];
    NSArray *arr = [skillStr componentsSeparatedByString:@","];
    
    NSString *finalSkillStr;
    for (int i=0; i<arr.count; i++)
    {
        if (i==0)
        {
            finalSkillStr=[arr objectAtIndex:i];
        }
        else
        {
            finalSkillStr=[NSString stringWithFormat:@"%@\n%@",finalSkillStr,[arr objectAtIndex:i]];
        }
    }

    
    jobDetailTxtview.text=finalSkillStr;
    if ([[jobDetailArray valueForKey:@"location"] isEqualToString:@""])
    {
        locationTxt.text=@"Location Not Added";
    }
    else
    {
        locationTxt.text=[jobDetailArray valueForKey:@"location"];
    }
    if ([[jobDetailArray valueForKey:@"special_instruction"] isEqualToString:@""])
    {
        specialInstructionTxt.text=@"Special Instruction Not Added";
    }
    else
    {
        specialInstructionTxt.text=[jobDetailArray valueForKey:@"special_instruction"];
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
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
