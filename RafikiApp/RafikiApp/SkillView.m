//
//  SkillView.m
//  RafikiApp
//
//  Created by CI-05 on 4/20/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "SkillView.h"

@interface SkillView ()

@end

@implementation SkillView
@synthesize nextButton;
- (void)viewDidLoad
{
    [super viewDidLoad];
    catSubcatSkillPopup.hidden=YES;
    skillAllStr=@"";
    
    /*double chackValue= [addressTextfiled.text doubleValue];
    if (chackValue >0)
    {
        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
        [fmt setPositiveFormat:@"0.##"];
        NSLog(@"%@", [fmt stringFromNumber:[NSNumber numberWithFloat:chackValue]]);
        addressTextfiled.text=[fmt stringFromNumber:[NSNumber numberWithFloat:chackValue]];
    }*/
    
    
    AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
    titleLbl.text=[NSString stringWithFormat:@"Skill-%d",app.skillCountTag];
    
    categoryAndSubcatButton.layer.cornerRadius=5;
    categoryAndSubcatButton.layer.borderWidth=1;
    categoryAndSubcatButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    categoryAndSubcatButton.clipsToBounds=YES;
    
    subCategoryButton.layer.cornerRadius=5;
    subCategoryButton.layer.borderWidth=1;
    subCategoryButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    subCategoryButton.clipsToBounds=YES;
    
    skillButton.layer.cornerRadius=5;
    skillButton.layer.borderWidth=1;
    skillButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    skillButton.clipsToBounds=YES;
    
    addButton.layer.cornerRadius=5;
    addButton.layer.borderWidth=1;
    addButton.layer.borderColor=[UIColor colorWithRed:59.0/255.0 green:177.0/255.0 blue:162.0/255.0 alpha:1.0].CGColor;
    addButton.clipsToBounds=YES;
    
    
    checkAllSkillButton.layer.cornerRadius=5;
    checkAllSkillButton.layer.borderWidth=1;
    checkAllSkillButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    checkAllSkillButton.clipsToBounds=YES;
    
    agesButton.layer.cornerRadius=agesButton.frame.size.width/2;
    agesButton.layer.borderWidth=1;
    agesButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    agesButton.clipsToBounds=YES;
    
    qualificationButton.layer.cornerRadius=qualificationButton.frame.size.width/2;
    qualificationButton.layer.borderWidth=1;
    qualificationButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    qualificationButton.clipsToBounds=YES;
    
    experianceButton.layer.cornerRadius=experianceButton.frame.size.width/2;
    experianceButton.layer.borderWidth=1;
    experianceButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    experianceButton.clipsToBounds=YES;
    
    mustHaveButton.layer.cornerRadius=mustHaveButton.frame.size.width/2;
    mustHaveButton.layer.borderWidth=1;
    mustHaveButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    mustHaveButton.clipsToBounds=YES;
    
    anythingElseButton.layer.cornerRadius=anythingElseButton.frame.size.width/2;
    anythingElseButton.layer.borderWidth=1;
    anythingElseButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    anythingElseButton.clipsToBounds=YES;
    
    addressButton.layer.cornerRadius=addressButton.frame.size.width/2;
    addressButton.layer.borderWidth=1;
    addressButton.layer.borderColor=[UIColor groupTableViewBackgroundColor].CGColor;
    addressButton.clipsToBounds=YES;
    
    agesTxtfiled.hidden=YES;
    qualificationTxtfiled.hidden=YES;
    experianceTxtfiled.hidden=YES;
    mustHaveTextfiled.hidden=YES;
    anythingTextfiled.hidden=YES;
    addressTextfiled.hidden=YES;
    
 /*   CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in skillScrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }*/
    [skillScrollView setContentSize:(CGSizeMake([[UIScreen mainScreen] bounds].size.width,nextButton.frame.origin.y+nextButton.frame.size.height))];
}
-(void)passGetCategoryApi
{
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_cat.php?"];
    //    NSDictionary *dictParams = @{};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        MainCatarray=[[NSMutableArray alloc] init];
        MainCatarray=(NSMutableArray *)[responseObject valueForKey:@"cat"];
        NSLog(@"cat dics :%@",MainCatarray);
        [commonTbl reloadData];
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
-(void)passGetSubCategoryApiWithPeram:(NSString *)peramStr
{
        NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_cat.php"];
        NSDictionary *dictParams = @{@"parent_id":peramStr};
        NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            NSLog(@"Response: %@",responseObject);
            subCatearray=[[NSMutableArray alloc] init];
            subCatearray=(NSMutableArray *)[responseObject valueForKey:@"cat"];
            [commonTbl reloadData];
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
-(void)passGetskillApiWithPeram:(NSString *)peramStr
{
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_cat.php"];
    NSDictionary *dictParams = @{@"parent_id":peramStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"Response: %@",responseObject);
         skillarray=[[NSMutableArray alloc] init];
         skillarray=(NSMutableArray *)[responseObject valueForKey:@"cat"];
         [commonTbl reloadData];
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
    if ([typeStr isEqualToString:@"cat"])
    {
        return [[MainCatarray valueForKey:@"cat"] count];
    }
    else if ([typeStr isEqualToString:@"subcat"])
    {
        return [[subCatearray valueForKey:@"cat"] count];
    }
    else
    {
        return [[skillarray valueForKey:@"cat"] count];
    }
    
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
    cell.textLabel.textColor=[UIColor grayColor];
    cell.backgroundColor=[UIColor clearColor];
    if ([typeStr isEqualToString:@"cat"])
    {
        cell.textLabel.text=[[MainCatarray objectAtIndex:indexPath.row]valueForKey:@"cat_name"];
    }
    else if ([typeStr isEqualToString:@"subcat"])
    {
        cell.textLabel.text=[[subCatearray objectAtIndex:indexPath.row]valueForKey:@"cat_name"];
    }
    else
    {
        cell.textLabel.text=[[skillarray objectAtIndex:indexPath.row]valueForKey:@"cat_name"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([typeStr isEqualToString:@"cat"])
    {
        NSLog(@"cate Id is :%@ And Cate Name is:%@",[[MainCatarray objectAtIndex:indexPath.row] valueForKey:@"cat_id"],[[MainCatarray objectAtIndex:indexPath.row] valueForKey:@"cat_name"]);

        cateIdStr=[[MainCatarray objectAtIndex:indexPath.row] valueForKey:@"cat_id"];
        [categoryAndSubcatButton setTitle:[[MainCatarray objectAtIndex:indexPath.row] valueForKey:@"cat_name"] forState:UIControlStateNormal];
    }
    else if ([typeStr isEqualToString:@"subcat"])
    {
        NSLog(@"cate Id is :%@ And Cate Name is:%@",[[subCatearray objectAtIndex:indexPath.row] valueForKey:@"cat_id"],[[subCatearray objectAtIndex:indexPath.row] valueForKey:@"cat_name"]);

        subcatIdStr=[[subCatearray objectAtIndex:indexPath.row] valueForKey:@"cat_id"];
        [subCategoryButton setTitle:[[subCatearray objectAtIndex:indexPath.row] valueForKey:@"cat_name"] forState:UIControlStateNormal];
    }
    else
    {
        skillIdStr=[[skillarray objectAtIndex:indexPath.row] valueForKey:@"cat_id"];
        [skillButton setTitle:[[skillarray objectAtIndex:indexPath.row] valueForKey:@"cat_name"] forState:UIControlStateNormal];
    }
    catSubcatSkillPopup.hidden=YES;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == catSubcatSkillPopup)
        {
            NSLog(@"Ok");
            catSubcatSkillPopup.hidden=YES;
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)passSkillApi
{
    //http://cricyard.com/iphone/rafiki_app/service/add_user_skill.php?userid=1&category=a&subcategory=a&skill=a&check_all_skill=a&avg_session_time=A&price_per_session=a&ages=a&qulification=a&expiriance=a&certificate=a&must_have=a&anything_else=a&address=a&my_home=1&travel_miles=12
    
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/add_user_skill.php"];
    NSDictionary *dictParams = @{@"userid":userId,@"category":cateIdStr,@"subcategory":subcatIdStr,@"skill":skillIdStr,@"check_all_skill":skillAllStr,@"avg_session_time":avgSessionPerTimeTxt.text,@"price_per_session":pricePerSessionTxt.text,@"ages":agesTxtfiled.text,@"qulification":qualificationTxtfiled.text,@"expiriance":experianceTxtfiled.text,@"certificate":@"",@"must_have":mustHaveTextfiled.text,@"anything_else":anythingTextfiled.text,@"address":addressTextfiled.text,@"my_home":@"1",@"travel_miles":milesTxt.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"skill Response is:%@",responseObject);
         AppDelegate *app=(AppDelegate *)[UIApplication sharedApplication].delegate;
         app.skillCountTag=app.skillCountTag+1;
         if ([app.skillIdStr isEqualToString:@""]||app.skillIdStr.length==0)
         {
             app.skillIdStr=[NSString stringWithFormat:@"%@",[[responseObject valueForKey:@"data"] valueForKey:@"skill_id"]];
         }
         else
         {
             app.skillIdStr=[NSString stringWithFormat:@"%@,%@",app.skillIdStr,[[responseObject valueForKey:@"data"] valueForKey:@"skill_id"]];
         }
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         [self.navigationController popViewControllerAnimated:YES];
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
- (IBAction)nextAction:(id)sender
{
    if ([categoryAndSubcatButton.currentTitle isEqualToString:@"Select Categorie"]||[subCategoryButton.currentTitle isEqualToString:@"Select Subcategorie"]||[avgSessionPerTimeTxt.text isEqualToString:@""]||[pricePerSessionTxt.text isEqualToString:@""]||[agesTxtfiled.text isEqualToString:@""]||[qualificationTxtfiled.text isEqualToString:@""]||[experianceTxtfiled.text isEqualToString:@""]||[mustHaveTextfiled.text isEqualToString:@""]||[addressTextfiled.text isEqualToString:@""]||[milesTxt.text isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"Please enter all detail" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passSkillApi];
    }
}
- (IBAction)agesAction:(id)sender
{
    if ([agesButton.currentTitle isEqualToString:@"+"])
    {
        agesTxtfiled.hidden=NO;
        [agesButton setTitle:@"-" forState:UIControlStateNormal];
    }
    else
    {
        agesTxtfiled.hidden=YES;
        [agesButton setTitle:@"+" forState:UIControlStateNormal];
    }
    
}
- (IBAction)qualificationAction:(id)sender {
    
    if ([qualificationButton.currentTitle isEqualToString:@"+"])
    {
        qualificationTxtfiled.hidden=NO;
        [qualificationButton setTitle:@"-" forState:UIControlStateNormal];
    }
    else
    {
        qualificationTxtfiled.hidden=YES;
        [qualificationButton setTitle:@"+" forState:UIControlStateNormal];
    }
}

- (IBAction)experianceAction:(id)sender
{
    /*experianceTxtfiled.hidden=YES;
     mustHaveTextfiled.hidden=YES;
     anythingTextfiled.hidden=YES;*/
    
    if ([experianceButton.currentTitle isEqualToString:@"+"])
    {
        experianceTxtfiled.hidden=NO;
        [experianceButton setTitle:@"-" forState:UIControlStateNormal];
    }
    else
    {
        experianceTxtfiled.hidden=YES;
        [experianceButton setTitle:@"+" forState:UIControlStateNormal];
    }
}

- (IBAction)mustHaveAction:(id)sender
{
    if ([mustHaveButton.currentTitle isEqualToString:@"+"])
    {
        mustHaveTextfiled.hidden=NO;
        [mustHaveButton setTitle:@"-" forState:UIControlStateNormal];
    }
    else
    {
        mustHaveTextfiled.hidden=YES;
        [mustHaveButton setTitle:@"+" forState:UIControlStateNormal];
    }
}

- (IBAction)anyThingElseAction:(id)sender
{
    if ([anythingElseButton.currentTitle isEqualToString:@"+"])
    {
        anythingTextfiled.hidden=NO;
        [anythingElseButton setTitle:@"-" forState:UIControlStateNormal];
    }
    else
    {
        anythingTextfiled.hidden=YES;
        [anythingElseButton setTitle:@"+" forState:UIControlStateNormal];
    }
}
- (IBAction)addressAction:(id)sender
{
    if ([addressButton.currentTitle isEqualToString:@"+"])
    {
        addressTextfiled.hidden=NO;
        [addressButton setTitle:@"-" forState:UIControlStateNormal];
    }
    else
    {
        addressTextfiled.hidden=YES;
        [addressButton setTitle:@"+" forState:UIControlStateNormal];
    }
}
- (IBAction)categoryAction:(id)sender
{
    popTitleLbl.text=@"Select category";
    typeStr=@"cat";
    
    if (MainCatarray.count==0)
    {
        catSubcatSkillPopup.hidden=NO;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passGetCategoryApi];
    }
    else
    {
        catSubcatSkillPopup.hidden=NO;
        [commonTbl reloadData];
    }
    
}
- (IBAction)subcategoryAction:(id)sender
{
    popTitleLbl.text=@"Select sub category";
    typeStr=@"subcat";
    if ([cateIdStr isEqualToString:@""]||cateIdStr.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"Please select first category and after subcategory" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
            catSubcatSkillPopup.hidden=NO;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self passGetSubCategoryApiWithPeram:cateIdStr];
    }
}
- (IBAction)skillAction:(id)sender
{
    popTitleLbl.text=@"Select skill";
    typeStr=@"skill";
    if ([subcatIdStr isEqualToString:@""]||subcatIdStr.length==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"Please select first category&subcategory and after skill" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        catSubcatSkillPopup.hidden=NO;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self passGetskillApiWithPeram:subcatIdStr];
    }
}
- (IBAction)checkAllSkillAction:(id)sender
{
    UIButton *btn=(UIButton *)sender;
    if ([skillarray count]==0)
    {
          [[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"Please select first category&subcategory and after skill" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        if(btn.selected==YES)
        {
            btn.selected=NO;
            skillAllStr=@"";
            allSkillImgView.image=[UIImage imageNamed:@"unchecked_agree"];
        }
        else
        {
            for (int i=0; i<skillarray.count; i++)
            {
                if ([skillAllStr isEqualToString:@""]||skillAllStr.length==0)
                {
                    skillAllStr=[[skillarray objectAtIndex:i] valueForKey:@"cat_id"];
                }
                else
                {
                    skillAllStr=[NSString stringWithFormat:@"%@,%@",skillAllStr,[[skillarray objectAtIndex:i] valueForKey:@"cat_id"]];
                }
            }
            allSkillImgView.image=[UIImage imageNamed:@"agreed"];
            btn.selected=YES;
        }
    }
//    NSLog(@"All Skill Id is:%@",skillAllStr);
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addAction:(id)sender {
}
@end
