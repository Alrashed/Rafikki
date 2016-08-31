//
//  AddCatViewController.m
//  RafikiApp
//
//  Created by CI-05 on 2/12/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "AddCatViewController.h"

@interface AddCatViewController ()

@end

@implementation AddCatViewController
@synthesize chackEditFlag;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    
    optionView.hidden=YES;
    popview.layer.cornerRadius=10;
    catSelectArray=[[NSMutableArray alloc] init];
    subCatSelectArray=[[NSMutableArray alloc] init];
    skillSelectArray=[[NSMutableArray alloc] init];
    [self getAllMainCat];
}
#pragma mark Pass Api With Get OLD Selection Cat,Skill,Subcat
-(void)passOldSelectionCatAndSubCatAndSkillApi
{
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_user_cat.php"];
        NSDictionary *dictParams = @{@"user_id":userId};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSLog(@"Response: %@",responseObject);
        
        if ([[[responseObject valueForKey:@"data"] objectAtIndex:0] valueForKey:@"cat_id"])
        {
            NSString *catIds=[[[responseObject valueForKey:@"data"] objectAtIndex:0]valueForKey:@"cat_id"];
            NSArray *arr = [catIds componentsSeparatedByString:@","];
            
            for (int c=0; c<arr.count; c++)
            {
                [catSelectArray addObject:[arr objectAtIndex:c]];
            }
        }
        if ([[[responseObject valueForKey:@"data"]objectAtIndex:0] valueForKey:@"sub_cat_id"])
        {
            NSString *catIds=[[[responseObject valueForKey:@"data"]objectAtIndex:0] valueForKey:@"sub_cat_id"];
            NSArray *arr = [catIds componentsSeparatedByString:@","];
            
            for (int c=0; c<arr.count; c++)
            {
                [subCatSelectArray addObject:[arr objectAtIndex:c]];
            }
        }
        if ([[[responseObject valueForKey:@"data"]objectAtIndex:0] valueForKey:@"skill_id"])
        {
            NSString *catIds=[[[responseObject valueForKey:@"data"]objectAtIndex:0] valueForKey:@"skill_id"];
            NSArray *arr = [catIds componentsSeparatedByString:@","];
            
            for (int c=0; c<arr.count; c++)
            {
                [skillSelectArray addObject:[arr objectAtIndex:c]];
            }
        }
        
        [optionTbl reloadData];
        [subCatTbl reloadData];
        [skillTbl reloadData];
        
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
#pragma mark End--
-(void)getAllMainCat
{
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_cat.php?"];
    //    NSDictionary *dictParams = @{};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        MainCatarray=(NSMutableArray *)[responseObject valueForKey:@"cat"];
        NSLog(@"cat dics :%@",MainCatarray);
        if ([chackEditFlag isEqualToString:@"Yes"])
        {
            [self passOldSelectionCatAndSubCatAndSkillApi];
        }
        else
        {
            [optionTbl reloadData];
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
-(void)getSubAndSkillWithPeram:(NSString *)peramStr
{
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_cat.php"];
    NSDictionary *dictParams = @{@"parent_id":peramStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([chackCatTypeStr isEqualToString:@"cat"])
        {
            NSLog(@"Response: %@",responseObject);
            subCatMainArray=[[NSMutableArray alloc] init];
            subCatMainArray=(NSMutableArray *)[responseObject valueForKey:@"cat"];
            [subCatTbl reloadData];
        }
        else
        {
            NSLog(@"Response: %@",responseObject);
            skillMainArray=[[NSMutableArray alloc] init];
            skillMainArray=(NSMutableArray *)[responseObject valueForKey:@"cat"];
            [skillTbl reloadData];
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
-(void)insertCategorySubcategoryAndSkill
{
    NSString  *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];

//     http://cricyard.com/iphone/rafiki_app/service/insert_user_cat.php?user_id=1&cat_id=1&sub_cat_id=2,14,20&skill_id=6,7,8
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/insert_user_cat.php"];
    NSDictionary *dictParams = @{@"user_id":useridStr,@"cat_id":catConcatStr,@"sub_cat_id":subCatConcatStr,@"skill_id":skillConcateStr};
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"Response: %@",responseObject);
        [self.navigationController popViewControllerAnimated:YES];
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
    if (tableView==optionTbl)
    {
        return [[MainCatarray valueForKey:@"cat"] count];
    }
    else if (tableView==subCatTbl)
    {
        return [[subCatMainArray valueForKey:@"cat"] count];
    }
    else
    {
        return [[skillMainArray valueForKey:@"cat"] count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==optionTbl)
    {
        static NSString *MyIdentifier = @"MyIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        cell=nil;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
        }
       UIImageView *selectioImg=[[UIImageView alloc] initWithFrame:CGRectMake(optionTbl.frame.size.width-30, 12, 15 , 15)];
        
        NSLog(@"catid %@main id %@",catSelectArray,[[MainCatarray objectAtIndex:indexPath.row]valueForKey:@"cat_id"] );
        if ([catSelectArray containsObject:[[MainCatarray valueForKey:@"cat_id"] objectAtIndex:indexPath.row]])
        {
            selectioImg.image=[UIImage imageNamed:@"select"];
            cell.selected=YES;
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        else
        {
            selectioImg.image=[UIImage imageNamed:@"unselect"];
            cell.selected=NO;
        }
        [cell addSubview:selectioImg];
        
        cell.textLabel.textColor=[UIColor grayColor];
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.text=[[MainCatarray objectAtIndex:indexPath.row]valueForKey:@"cat_name"];
        return cell;
        
    }
    else if (tableView==subCatTbl)
    {
        static NSString *MyIdentifier = @"MyIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        cell=nil;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
        }
       UIImageView *selectioImg=[[UIImageView alloc] initWithFrame:CGRectMake(optionTbl.frame.size.width-30, 12, 15 , 15)];
        
        NSLog(@"catid %@main id %@",subCatSelectArray,[[subCatMainArray objectAtIndex:indexPath.row]valueForKey:@"cat_id"] );
        if ([subCatSelectArray containsObject:[[subCatMainArray valueForKey:@"cat_id"] objectAtIndex:indexPath.row]])
        {
            selectioImg.image=[UIImage imageNamed:@"select"];
            cell.selected=YES;
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

        }
        else
        {
            selectioImg.image=[UIImage imageNamed:@"unselect"];
            cell.selected=NO;
        }
        [cell addSubview:selectioImg];
        
        cell.textLabel.textColor=[UIColor grayColor];
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.text=[[subCatMainArray objectAtIndex:indexPath.row]valueForKey:@"cat_name"];
        return cell;
    }
    else
    {
        static NSString *MyIdentifier = @"MyIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        cell=nil;
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
        }
        UIImageView *selectioImg=[[UIImageView alloc] initWithFrame:CGRectMake(optionTbl.frame.size.width-30, 12, 15 , 15)];
        
        NSLog(@"catid %@main id %@",skillSelectArray,[[skillMainArray objectAtIndex:indexPath.row]valueForKey:@"cat_id"] );
        if ([skillSelectArray containsObject:[[skillMainArray valueForKey:@"cat_id"] objectAtIndex:indexPath.row]])
        {
            selectioImg.image=[UIImage imageNamed:@"select"];
            [cell setSelected:YES];
            [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

        }
        else
        {
            selectioImg.image=[UIImage imageNamed:@"unselect"];
            [cell setSelected:NO];
        }
        [cell addSubview:selectioImg];
        
        cell.textLabel.textColor=[UIColor grayColor];
        cell.backgroundColor=[UIColor clearColor];
        cell.textLabel.text=[[skillMainArray objectAtIndex:indexPath.row]valueForKey:@"cat_name"];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==optionTbl)
    {
        [catSelectArray addObject:[[MainCatarray valueForKey:@"cat_id"] objectAtIndex:indexPath.row]];
        
        UITableViewCell *cell = (UITableViewCell *) [optionTbl cellForRowAtIndexPath:indexPath];
        
        for (UIView *subview in [cell subviews])
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                UIImageView *img=(UIImageView *)subview;
                img.image=[UIImage imageNamed:@"select"];
                            [cell setSelected:YES];
            }
        }
    }
    else if (tableView==subCatTbl)
    {
        [subCatSelectArray addObject:[[subCatMainArray valueForKey:@"cat_id"] objectAtIndex:indexPath.row]];
        
        UITableViewCell *cell = (UITableViewCell *) [subCatTbl cellForRowAtIndexPath:indexPath];
        
        for (UIView *subview in [cell subviews])
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                UIImageView *img=(UIImageView *)subview;
                img.image=[UIImage imageNamed:@"select"];
                            [cell setSelected:YES];
            }
        }
    }
    else if (tableView==skillTbl)
    {
        [skillSelectArray addObject:[[skillMainArray valueForKey:@"cat_id"] objectAtIndex:indexPath.row]];
        
        UITableViewCell *cell = (UITableViewCell *) [skillTbl cellForRowAtIndexPath:indexPath];
        
        for (UIView *subview in [cell subviews])
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                UIImageView *img=(UIImageView *)subview;
                img.image=[UIImage imageNamed:@"select"];
                            [cell setSelected:YES];
            }
        }
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (tableView==optionTbl)
    {
        [catSelectArray removeObject:[[MainCatarray valueForKey:@"cat_id"] objectAtIndex:indexPath.row]];
        
        UITableViewCell *cell = (UITableViewCell *) [optionTbl cellForRowAtIndexPath:indexPath];
        
        for (UIView *subview in [cell subviews])
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                UIImageView *img=(UIImageView *)subview;
                img.image=[UIImage imageNamed:@"unselect"];
                            [cell setSelected:NO];
            }
        }
    }
    else if (tableView==subCatTbl)
    {
        [subCatSelectArray removeObject:[[subCatMainArray valueForKey:@"cat_id"] objectAtIndex:indexPath.row]];
        
        UITableViewCell *cell = (UITableViewCell *) [subCatTbl cellForRowAtIndexPath:indexPath];
        
        for (UIView *subview in [cell subviews])
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                UIImageView *img=(UIImageView *)subview;
                img.image=[UIImage imageNamed:@"unselect"];
                [cell setSelected:NO];

            }
        }
    }
    else if (tableView==skillTbl)
    {
        [skillSelectArray removeObject:[[skillMainArray valueForKey:@"cat_id"] objectAtIndex:indexPath.row]];
        
        UITableViewCell *cell = (UITableViewCell *) [skillTbl cellForRowAtIndexPath:indexPath];
        
        for (UIView *subview in [cell subviews])
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                UIImageView *img=(UIImageView *)subview;
                img.image=[UIImage imageNamed:@"unselect"];
                [cell setSelected:NO];
            }
        }
    }
}
/*-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch =[touches anyObject];
    if (touch.phase ==UITouchPhaseBegan)
    {
        UITouch *touchs = [[event allTouches] anyObject];
        if ([touchs view] == optionView)
        {
            NSLog(@"Ok");
            optionView.hidden=YES;
        }
        else
        {
            NSLog(@"CANCEL");
        }
        [self.view endEditing:YES];
    }
}*/
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)okAction:(id)sender
{
    if ([chackCatTypeStr isEqualToString:@"cat"])
    {
        if (catSelectArray.count==0)
        {
            [[[UIAlertView alloc] initWithTitle:@"Select atleast one" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
        else
        {
            optionView.hidden=YES;
            catConcatStr=@"";
            for (int i=0; i<catSelectArray.count; i++)
            {
                if ([catConcatStr isEqualToString:@""])
                {
                    catConcatStr=[catSelectArray objectAtIndex:i];
                }
                else
                {
                    catConcatStr=[NSString stringWithFormat:@"%@,%@",catConcatStr,[catSelectArray objectAtIndex:i]];
                }
            }
            cateNameLbl.text=@"";
            for (int j=0;j<catSelectArray.count; j++)
            {
                for (int m=0; m<MainCatarray.count; m++)
                {
                    NSLog(@"my value:%@",[[MainCatarray objectAtIndex:m]valueForKey:@"cat_id"]);
                    NSString *mainStr=[[MainCatarray objectAtIndex:m]valueForKey:@"cat_id"];
                    NSString *selctStr=[catSelectArray objectAtIndex:j];
                    if ([mainStr isEqualToString:selctStr])
                    {
                        if ([cateNameLbl.text isEqualToString:@""])
                        {
                            cateNameLbl.text=[[MainCatarray valueForKey:@"cat_name"] objectAtIndex:m];
                        }
                        else
                        {
                            cateNameLbl.text=[NSString stringWithFormat:@"%@,%@",cateNameLbl.text,[[MainCatarray valueForKey:@"cat_name"] objectAtIndex:m]];
                        }
                    }
                }
            }
//            [subCatMainArray removeAllObjects];
//            [skillMainArray removeAllObjects];
            if ([chackEditFlag isEqualToString:@"Yes"])
            {
                
            }
            else
            {
                [subCatSelectArray removeAllObjects];
                [skillSelectArray removeAllObjects];
            }
            [self getSubAndSkillWithPeram:catConcatStr];
        }
    }
    else if ([chackCatTypeStr isEqualToString:@"subcat"])
    {
        if (subCatSelectArray.count==0)
        {
            [[[UIAlertView alloc] initWithTitle:@"Select atleast one" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
        else
        {
            optionView.hidden=YES;
            subCatConcatStr=@"";
            for (int i=0; i<subCatSelectArray.count; i++)
            {
                if ([subCatConcatStr isEqualToString:@""])
                {
                    subCatConcatStr=[subCatSelectArray objectAtIndex:i];
                }
                else
                {
                    subCatConcatStr=[NSString stringWithFormat:@"%@,%@",subCatConcatStr,[subCatSelectArray objectAtIndex:i]];
                }
            }
            subCatNameLbl.text=@"";
            for (int j=0;j<subCatSelectArray.count; j++)
            {
                for (int m=0; m<subCatMainArray.count; m++)
                {
                    NSLog(@"my value:%@",[[subCatMainArray objectAtIndex:m]valueForKey:@"cat_id"]);
                    NSString *mainStr=[[subCatMainArray objectAtIndex:m]valueForKey:@"cat_id"];
                    NSString *selctStr=[subCatSelectArray objectAtIndex:j];
                    if ([mainStr isEqualToString:selctStr])
                    {
                        if ([subCatNameLbl.text isEqualToString:@""])
                        {
                            subCatNameLbl.text=[[subCatMainArray valueForKey:@"cat_name"] objectAtIndex:m];
                        }
                        else
                        {
                            subCatNameLbl.text=[NSString stringWithFormat:@"%@,%@",subCatNameLbl.text,[[subCatMainArray valueForKey:@"cat_name"] objectAtIndex:m]];
                            
                        }
                    }
                }
            }
            [self getSubAndSkillWithPeram:subCatConcatStr];
        }
    }
    else
    {
        if (skillSelectArray.count==0)
        {
            [[[UIAlertView alloc] initWithTitle:@"Select atleast one" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
        else
        {
            optionView.hidden=YES;
            skillConcateStr=@"";
            for (int i=0; i<skillSelectArray.count; i++)
            {
                if ([skillConcateStr isEqualToString:@""])
                {
                    skillConcateStr=[skillSelectArray objectAtIndex:i];
                }
                else
                {
                    skillConcateStr=[NSString stringWithFormat:@"%@,%@",skillConcateStr,[skillSelectArray objectAtIndex:i]];
                }
            }
            
            skillNameLbl.text=@"";
            for (int j=0;j<skillSelectArray.count; j++)
            {
                for (int m=0; m<skillMainArray.count; m++)
                {
                    NSLog(@"my value:%@",[[skillMainArray objectAtIndex:m]valueForKey:@"cat_id"]);
                    NSString *mainStr=[[skillMainArray objectAtIndex:m]valueForKey:@"cat_id"];
                    NSString *selctStr=[skillSelectArray objectAtIndex:j];
                    if ([mainStr isEqualToString:selctStr])
                    {
                        if ([skillNameLbl.text isEqualToString:@""])
                        {
                            skillNameLbl.text=[[skillMainArray valueForKey:@"cat_name"] objectAtIndex:m];
                        }
                        else
                        {
                            skillNameLbl.text=[NSString stringWithFormat:@"%@,%@",skillNameLbl.text,[[skillMainArray valueForKey:@"cat_name"] objectAtIndex:m]];
                            
                        }
                    }
                }
            }
        }
    }
}
- (IBAction)cancelAction:(id)sender {
        optionView.hidden=YES;
}
- (IBAction)selectCatAction:(id)sender {
    chackCatTypeStr=@"cat";
    titleLbl.text=@"Select Categories";
    optionView.hidden=NO;
    optionTbl.hidden=NO;
    skillTbl.hidden=YES;
    subCatTbl.hidden=YES;
}
- (IBAction)subCatAction:(id)sender {
    chackCatTypeStr=@"subcat";
    titleLbl.text=@"Select Subcategories";
    if (catSelectArray.count==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"select first Category" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        optionView.hidden=NO;
        optionTbl.hidden=YES;
        skillTbl.hidden=YES;
        subCatTbl.hidden=NO;
    }
}
- (IBAction)skillAction:(id)sender {
    
    if (subCatMainArray.count==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"select first Subcategory" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        if ([[skillMainArray valueForKey:@"cat_id"] count]==0)
        {
            [[[UIAlertView alloc] initWithTitle:@"Skill not found" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }
        else
        {
            titleLbl.text=@"Select Skill";
            chackCatTypeStr=@"skill";
            optionView.hidden=NO;
            optionTbl.hidden=YES;
            skillTbl.hidden=NO;
            subCatTbl.hidden=YES;
        }
      
    }
}
- (IBAction)doneAction:(id)sender
{
    if ([catConcatStr isEqualToString:@""]||[subCatConcatStr isEqualToString:@""]||[skillConcateStr isEqualToString:@""])
    {
        [[[UIAlertView alloc] initWithTitle:@"you Have to Choose Category And Skill" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:catConcatStr forKey:@"catIds"];
        [[NSUserDefaults standardUserDefaults] setObject:subCatConcatStr forKey:@"subcatIds"];
        [[NSUserDefaults standardUserDefaults] setObject:skillConcateStr forKey:@"skillIds"];
        
        [self insertCategorySubcategoryAndSkill];
    }
}

- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
