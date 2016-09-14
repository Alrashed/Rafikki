//
//  SearchView.m
//  RafikiApp
//
//  Created by CI-05 on 1/19/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import "SearchView.h"
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"
#import "SuggestionCell.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "ProfileViewController.h"
@interface SearchView ()

@end

@implementation SearchView

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self passSearchApiPass];
    // Do any additional setup after loading the view from its nib.
}
-(void)passSearchApiPass
{
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_allexpert.php"];
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        allExpertArray=[[NSMutableArray alloc] init];
        //allExpertArray  = [responseObject valueForKey:@"data"];
       // NSMutableArray *aa = [responseObject valueForKey:@"data"];
        for (int i=0; i < [[responseObject valueForKey:@"data"] count]; i++)
        {
            [allExpertArray addObject:[[responseObject valueForKey:@"data"] objectAtIndex:i]];
        }
        tempArray=[[NSMutableArray alloc] initWithArray:allExpertArray];
        NSLog(@"allExpertArray is :%@",allExpertArray);
        [searchTbl reloadData];
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
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    userSearchbar.showsCancelButton = YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if([searchBar.text isEqualToString:@""] || searchBar.text==nil)
    {
        [allExpertArray removeAllObjects];
        [allExpertArray addObjectsFromArray:tempArray];
        searchTbl.hidden=YES;
    }
    else
    {
        searchTbl.hidden=NO;
        [allExpertArray  removeAllObjects];
        NSInteger counter = 0;
        for(int i=0; i<[tempArray count]; i++)
        {
            NSString *name=[[tempArray  objectAtIndex:i] valueForKey:@"firstname"];
            
            NSRange r ;
            r =[[name lowercaseString] rangeOfString:[searchBar.text lowercaseString]];
            if(r.location != NSNotFound)
            {
                NSLog(@"%@",[tempArray objectAtIndex:i]);
                [allExpertArray addObject:[tempArray objectAtIndex:i]];
            }
            counter++;
        }
    }
    [searchTbl reloadData];
    [searchBar resignFirstResponder];
    return;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchTbl.hidden=NO;

    if([searchBar.text isEqualToString:@""] || searchBar.text==nil)
    {
        [allExpertArray removeAllObjects];
        [allExpertArray addObjectsFromArray:tempArray];
        searchTbl.hidden=YES;
    }
    else
    {
        searchTbl.hidden=NO;
        [allExpertArray  removeAllObjects];
        NSInteger counter = 0;
        for(int i=0; i<[tempArray count]; i++)
        {
            
            NSString *name=[NSString stringWithFormat:@"%@ %@",[[tempArray  objectAtIndex:i] valueForKey:@"firstname"],[[tempArray  objectAtIndex:i] valueForKey:@"lastname"]];

            
            NSRange r ;
            r =[[name lowercaseString] rangeOfString:[searchBar.text lowercaseString]];
            if(r.location != NSNotFound)
            {
                NSLog(@"%@",[tempArray objectAtIndex:i]);
                [allExpertArray addObject:[tempArray objectAtIndex:i]];
            }
            counter++;
        }
    }
    [searchTbl reloadData];
    return;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if (scrollView.contentOffset.y <= lastOffset.y) {
        [self.navigationController.navigationBar setHidden:NO];
        NSLog(@"helllo%f",searchTbl.frame.origin.y);
        float tableFrem=searchTbl.frame.origin.y;
        if (tableFrem==0) {
            searchTbl.frame=CGRectMake(0, 44, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        }
    }
    else{
        if (scrollView.contentOffset.y>0) {
            float tableFrem=searchTbl.frame.origin.y;
            if (tableFrem==44) {

                searchTbl.frame=CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
            }
            [self.navigationController.navigationBar setHidden:YES];
            self.navigationController.navigationBar.translucent=YES;
        }
    }
    lastOffset = scrollView.contentOffset;
}
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[allExpertArray valueForKey:@"data"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SuggestionCell";
    SuggestionCell *cell = (SuggestionCell *)[searchTbl dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    cell=nil;
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SuggestionCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.TitleLbl.text=[NSString stringWithFormat:@"%@ %@",[[allExpertArray  objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[allExpertArray  objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
    cell.subTitleLbl.text=[[allExpertArray  objectAtIndex:indexPath.row] valueForKey:@"designation"];
    cell.profilePic.layer.cornerRadius=cell.profilePic.frame.size.width/2;
    cell.profilePic.clipsToBounds=YES;
    [cell.profilePic setImageWithURL:[NSURL URLWithString:[[allExpertArray  objectAtIndex:indexPath.row]valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileViewController *pro=[[ProfileViewController alloc] init];
    pro.expertIdStr=[[allExpertArray objectAtIndex:indexPath.row]valueForKey:@"user_id"];
    pro.userFlag=@"expert";
    [self.navigationController pushViewController:pro animated:YES];
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
    [searchTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    userSearchbar = [[UISearchBar alloc] init];
    [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];

    [userSearchbar sizeToFit];
    userSearchbar.delegate = self;
    userSearchbar.placeholder=@"Learn how to...";
    userSearchbar.tintColor=[UIColor whiteColor];
    userSearchbar.searchBarStyle=UISearchBarStyleMinimal;
    // Add search bar to navigation bar
    self.navigationItem.titleView = userSearchbar;
    [userSearchbar becomeFirstResponder];
    

    
    for (UIView *subView in userSearchbar.subviews)
    {
        for (UIView *secondLevelSubview in subView.subviews){
            if ([secondLevelSubview isKindOfClass:[UITextField class]])
            {
                UITextField *searchBarTextField = (UITextField *)secondLevelSubview;
                
                //set font color here
                searchBarTextField.textColor = [UIColor whiteColor];
                break;
            }
        }
    }
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,nil] forState:UIControlStateNormal];
    
//    searchTbl.hidden=YES;
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:0.8];
    self.navigationController.navigationItem.backBarButtonItem.title = nil;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent=NO;
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
