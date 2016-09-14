//
//  AboutMeVC.m
//  RafikiApp
//
//  Created by CI-05 on 4/19/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "AboutMeVC.h"

@interface AboutMeVC ()

@end

@implementation AboutMeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    timeView.hidden=YES;
    
   
    
    tellUsAboutTxtview.layer.cornerRadius=7;
    tellUsAboutTxtview.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    tellUsAboutTxtview.layer.borderWidth=2;
    tellUsAboutTxtview.clipsToBounds=YES;
    

    skillView.layer.cornerRadius=skillView.frame.size.height/2;
    skillView.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    skillView.layer.borderWidth=2;
    skillView.clipsToBounds=YES;
    
    plusLbl.layer.cornerRadius=plusLbl.frame.size.width/2;
    plusLbl.layer.borderColor=[UIColor colorWithRed:56.0/255.0 green:177.0/255 blue:162.0/255 alpha:1].CGColor;
    plusLbl.layer.borderWidth=1;
    plusLbl.clipsToBounds=YES;
    
    timeDoneButton.layer.cornerRadius=5;
    timeDoneButton.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:177.0/255.0 blue:162.0/255.0 alpha:1.0].CGColor;
    timeDoneButton.layer.borderWidth=1;
    timeDoneButton.clipsToBounds=YES;
    
    DaysNameArray=[[NSMutableArray alloc] initWithObjects:@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun", nil];
    DayTimeArray=[[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0", nil];
    
    UINib *nib = [UINib nibWithNibName:@"AvailabilityDaysCell" bundle: nil];
    [availabilityCollectionView registerNib:nib forCellWithReuseIdentifier:@"AvailabilityDaysCell"];

    [startTimePikerView setValue:[UIColor colorWithRed:59.0/255.0 green:177.0/255.0 blue:162.0/255.0 alpha:1] forKeyPath:@"textColor"];
//    startTimePikerView.backgroundColor=[UIColor colorWithRed:59.0/255.0 green:177.0/255.0 blue:162.0/255.0 alpha:1];
    
    [endTimeDatepickerView setValue:[UIColor colorWithRed:59.0/255.0 green:177.0/255.0 blue:162.0/255.0 alpha:1] forKeyPath:@"textColor"];
//    endTimeDatepickerView.backgroundColor=[UIColor colorWithRed:59.0/255.0 green:177.0/255.0 blue:162.0/255.0 alpha:1];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSLog(@"Skill Count Integer is:%d",app.skillCountTag);
    
    [addSkillButton setTitle:[NSString stringWithFormat:@"Add skill-%d",app.skillCountTag] forState:UIControlStateNormal];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == timeView)
        {
            NSLog(@"Ok");
            timeView.hidden=YES;
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
# pragma mark CollectionView

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"my array index is:%@",[DaysNameArray objectAtIndex:indexPath.row]);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [DaysNameArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"AvailabilityDaysCell";
    AvailabilityDaysCell *Colcell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Colcell.addTimeButton.layer.cornerRadius=5;
    Colcell.addTimeButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    Colcell.addTimeButton.layer.borderWidth=2;
    Colcell.addTimeButton.clipsToBounds=YES;
    
    Colcell.plusLbl.layer.cornerRadius=Colcell.plusLbl.frame.size.height/2;
    Colcell.plusLbl.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    Colcell.plusLbl.layer.borderWidth=1;
    Colcell.plusLbl.clipsToBounds=YES;
    
    Colcell.daysLbl.text=[DaysNameArray objectAtIndex:indexPath.row];
    Colcell.addTimeButton.tag=indexPath.row;
    [Colcell.addTimeButton addTarget:self action:@selector(addTimeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[DayTimeArray objectAtIndex:indexPath.row]isEqualToString:@"0"])
    {
        Colcell.timeLbl.text=@"Add times";
    }
    else
    {
        Colcell.timeLbl.text=[DayTimeArray objectAtIndex:indexPath.row];
    }
    
    
    return Colcell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.view.frame.size.width==414)
    {
        return CGSizeMake(70.0f, 110);
    }
    if (self.view.frame.size.width==375)
    {
        return CGSizeMake(70.00f, 110.00f);
    }
    return CGSizeMake(70.00f, 110.00f);
}
-(IBAction)addTimeAction:(id)sender
{
    daysTag=[sender tag];
    
    NSLog(@"days Array Name:%@",[DaysNameArray objectAtIndex:[sender tag]]);
    NSLog(@"days time Array is:%@",DayTimeArray);
    timeView.hidden=NO;
}
- (IBAction)timeDoneAction:(id)sender
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm a"];
    NSString *start = [dateFormat stringFromDate:startTimePikerView.date];
    NSString *end = [dateFormat stringFromDate:endTimeDatepickerView.date];
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:daysTag inSection:0] ;
    AvailabilityDaysCell *cell=(AvailabilityDaysCell *)[availabilityCollectionView cellForItemAtIndexPath:indexpath];
    cell.timeLbl.text=[NSString stringWithFormat:@"%@ To %@",start,end];
    [DayTimeArray replaceObjectAtIndex:daysTag withObject:cell.timeLbl.text];
    timeView.hidden=YES;
}
- (IBAction)AddSkillAction:(id)sender
{
    SkillView *skill=[[SkillView alloc] init];
    [self.navigationController pushViewController:skill animated:YES];
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)passAboutMeApi
{
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    //http://cricyard.com/iphone/rafiki_app/service/register_about_info.php?about_me=samir%20makadia&userid=1&available_days=i%20am%20available%2024x7&skills=1,2,3
    
    NSString *daysConcatStr;
    for (int i=0; i<DayTimeArray.count; i++)
    {
        if ([daysConcatStr isEqualToString:@""]||daysConcatStr.length==0)
        {
            daysConcatStr=[DayTimeArray objectAtIndex:0];
        }
        else
        {
            daysConcatStr=[NSString stringWithFormat:@"%@,%@",daysConcatStr,[DayTimeArray objectAtIndex:i]];
        }
    }
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/register_about_info.php"];
    NSDictionary *dictParams = @{@"about_me":tellUsAboutTxtview.text,@"userid":userId,@"available_days":daysConcatStr,@"skills":app.skillIdStr};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        //Next
        PaymentInfoVC *pay=[[PaymentInfoVC alloc] init];
        [self.navigationController pushViewController:pay animated:YES];
    }
    else
    {
        //Save & Next
        [[NSUserDefaults standardUserDefaults] setObject:@"save" forKey:@"screen6_Aboutme"];
        PaymentInfoVC *pay=[[PaymentInfoVC alloc] init];
        [self.navigationController pushViewController:pay animated:YES];
    }
}
- (IBAction)nextAction:(id)sender
{
    if ([tellUsAboutTxtview.text isEqualToString:@" Tell us About you"]||[DayTimeArray containsObject:@"0"]||[addSkillButton.currentTitle isEqualToString:@"Add skill-1"])
    {
        [[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"Please Enter All Detail" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passAboutMeApi];
    }
}
@end
