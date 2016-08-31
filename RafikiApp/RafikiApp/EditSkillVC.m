//
//  EditSkillVC.m
//  RafikiApp
//
//  Created by CI-05 on 5/18/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "EditSkillVC.h"

@interface EditSkillVC ()

@end

@implementation EditSkillVC
@synthesize detailSkillArray;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [skillScrollView setContentSize:(CGSizeMake([[UIScreen mainScreen] bounds].size.width,nextButton.frame.origin.y+nextButton.frame.size.height))];
    
    catSubcatSkillPopup.hidden=YES;
    
    if ([_ViewtypeStr isEqualToString:@"Add"])
    {
        [nextButton setTitle:@"Add" forState:UIControlStateNormal];
        checkAllSkillButton.enabled=NO;
        checkAllSkillButton.alpha=0.5;
    }
    else
    {
        NSLog(@"Skill Name is:%@",[detailSkillArray  valueForKey:@"user_skill_id"]);
        
        [categoryAndSubcatButton setTitle:[detailSkillArray valueForKey:@"category_name"] forState:UIControlStateNormal];
        [subCategoryButton setTitle:[detailSkillArray valueForKey:@"subcategory_name"] forState:UIControlStateNormal];
        [skillButton setTitle:[detailSkillArray valueForKey:@"skill_name"] forState:UIControlStateNormal];
        checkAllSkillButton.enabled=NO;
        checkAllSkillButton.alpha=0.5;
        
        avgSessionPerTimeTxt.text=[detailSkillArray valueForKey:@"avg_session_time"];
        pricePerSessionTxt.text=[detailSkillArray valueForKey:@"price_per_session"];
        agesTxtfiled.text=[detailSkillArray valueForKey:@"ages"];
        qualificationTxtfiled.text=[detailSkillArray valueForKey:@"qulification"];
        experianceTxtfiled.text=[detailSkillArray valueForKey:@"expiriance"];
        mustHaveTextfiled.text=[detailSkillArray valueForKey:@"must_have"];
        anythingTextfiled.text=[detailSkillArray valueForKey:@"anything_else"];
        addressTextfiled.text=[detailSkillArray valueForKey:@"address"];
        milesTxt.text=[detailSkillArray valueForKey:@"travel_miles"];
    }
}
#pragma mark -Pass Api
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
-(void)passEditSkillApi
{
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/edit_user_skill.php"];
    /*user_skill_id&user_id&category&subcategory&skill&avg_session_time&price_per_session&ages&qulification&expiriance&certificate&must_have&anything_else&address& my_home&travel_miles&check_all_skill*/
    NSDictionary *dictParams = @{@"user_skill_id":[detailSkillArray valueForKey:@"user_skill_id"],@"user_id":userId,@"category":cateIdStr,@"subcategory":subcatIdStr,@"skill":skillIdStr,@"check_all_skill":@"",@"avg_session_time":avgSessionPerTimeTxt.text,@"price_per_session":pricePerSessionTxt.text,@"ages":agesTxtfiled.text,@"qulification":qualificationTxtfiled.text,@"expiriance":experianceTxtfiled.text,@"certificate":@"",@"must_have":mustHaveTextfiled.text,@"anything_else":anythingTextfiled.text,@"address":addressTextfiled.text,@"my_home":@"1",@"travel_miles":milesTxt.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"skill Response is:%@",responseObject);
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
-(void)passSkillApi
{
    //http://cricyard.com/iphone/rafiki_app/service/add_user_skill.php?userid=1&category=a&subcategory=a&skill=a&check_all_skill=a&avg_session_time=A&price_per_session=a&ages=a&qulification=a&expiriance=a&certificate=a&must_have=a&anything_else=a&address=a&my_home=1&travel_miles=12
    
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/add_user_skill.php"];
    NSDictionary *dictParams = @{@"userid":userId,@"category":cateIdStr,@"subcategory":subcatIdStr,@"skill":skillIdStr,@"check_all_skill":skillIdStr,@"avg_session_time":avgSessionPerTimeTxt.text,@"price_per_session":pricePerSessionTxt.text,@"ages":agesTxtfiled.text,@"qulification":qualificationTxtfiled.text,@"expiriance":experianceTxtfiled.text,@"certificate":@"",@"must_have":mustHaveTextfiled.text,@"anything_else":anythingTextfiled.text,@"address":addressTextfiled.text,@"my_home":@"1",@"travel_miles":milesTxt.text};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:urlStr parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSLog(@"skill Response is:%@",responseObject);
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
#pragma mark -Tableview delegate methods
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
- (IBAction)nextAction:(id)sender
{
    if ([categoryAndSubcatButton.currentTitle isEqualToString:@"Select Categorie"]||[subCategoryButton.currentTitle isEqualToString:@"Select Subcategorie"]||[avgSessionPerTimeTxt.text isEqualToString:@""]||[pricePerSessionTxt.text isEqualToString:@""]||[agesTxtfiled.text isEqualToString:@""]||[qualificationTxtfiled.text isEqualToString:@""]||[experianceTxtfiled.text isEqualToString:@""]||[mustHaveTextfiled.text isEqualToString:@""]||[addressTextfiled.text isEqualToString:@""]||[milesTxt.text isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"Rafikki App" message:@"Please enter all required info" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if ([_ViewtypeStr isEqualToString:@"Add"])
        {
            [self passSkillApi];
        }
        else
        {
            [self passEditSkillApi];
        }
    }
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)catAction:(id)sender
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
- (IBAction)subCatAction:(id)sender
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
@end
