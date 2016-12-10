//
//  HomeViewController.m
//  RafikiApp
//
//  Created by CI-05 on 12/25/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "HomeViewController.h"
#import "CategoryViewController.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


@interface HomeViewController ()
@property (nonatomic) CAPSPageMenu *pageMenu;
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        
      [sliderButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    homeScrollview.contentSize=CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height+50);
    
    UINib *nib = [UINib nibWithNibName:@"SuggestionCollectionCell" bundle: nil];
    [suggestionCollection registerNib:nib forCellWithReuseIdentifier:@"SuggestionCollectionCell"];
    
    
    
    
    
//    self.title = @"PAGE MENU";
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30.0/255.0 green:30.0/255.0 blue:30.0/255.0 alpha:1.0];
//    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor orangeColor]};
//    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<-" style:UIBarButtonItemStyleDone target:self action:@selector(didTapGoToLeft)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"->" style:UIBarButtonItemStyleDone target:self action:@selector(didTapGoToRight)];
    
    TestCollectionViewController *controller1 = [[TestCollectionViewController alloc]initWithNibName:@"TestCollectionViewController" bundle:nil];
    controller1.title = @"o";
    TestCollectionViewController2 *controller2 = [[TestCollectionViewController2 alloc]initWithNibName:@"TestCollectionViewController2" bundle:nil];
    controller2.title = @"o";
    TestCollectionViewController3 *controller3 = [[TestCollectionViewController3 alloc]initWithNibName:@"TestCollectionViewController3" bundle:nil];
    controller3.title = @"o";
    TestCollectionViewController4 *controller4 = [[TestCollectionViewController4 alloc]initWithNibName:@"TestCollectionViewController4" bundle:nil];
    controller4.title = @"o";
    
    NSArray *controllerArray = @[controller1, controller2, controller3, controller4];
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor blackColor],
                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue" size:12],
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor: [UIColor whiteColor],
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor : [UIColor blackColor],
                                 CAPSPageMenuOptionMenuHeight: @(14.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(20.0),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES)
                                 };

    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 300.0, self.view.frame.size.width, 270.0) options:parameters];
    [self.view addSubview:_pageMenu.view];

    
    
    
    
    
    [self passSuggestionApi];
        SMRotaryWheel *wheel;
    if ([[UIScreen mainScreen] bounds].size.height==736)
    {
         wheel= [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 220, 220)
                                                        andDelegate:self
                                                       withSections:11];
        wheel.center = CGPointMake(200, 120);
    }
    else if ([[UIScreen mainScreen] bounds].size.height==667)
    {
        wheel= [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 230, 230)
                                        andDelegate:self
                                       withSections:11];
        
        wheel.center = CGPointMake(180, 100);
    }
    else if ([[UIScreen mainScreen] bounds].size.height==568)
    {
        wheel= [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 230, 230)
                                        andDelegate:self
                                       withSections:11];
        
        wheel.center = CGPointMake(150, 100);
    }
    else
    {
        wheel= [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)
                                        andDelegate:self
                                       withSections:11];
        
        wheel.center = CGPointMake(150, 100);
    }
    
    [catWhileView addSubview:wheel];
    
    [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
//    [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
}
- (void)didTapGoToLeft {
    NSInteger currentIndex = self.pageMenu.currentPageIndex;
    
    if (currentIndex > 0) {
        [_pageMenu moveToPage:currentIndex - 1];
    }
}

- (void)didTapGoToRight {
    NSInteger currentIndex = self.pageMenu.currentPageIndex;
    
    if (currentIndex < self.pageMenu.controllerArray.count) {
        [self.pageMenu moveToPage:currentIndex + 1];
    }
}

- (void) wheelDidChangeValue:(NSString *)newValue
{
  NSLog(@"%@", newValue);
    
    if (!first)
    {
        first=YES;
    }
    else
    {
        SubCategoryVC *cat=[[SubCategoryVC alloc] init];
        if ([newValue isEqualToString:@"Fitness"])
        {
            cat.catName=@"Fitness";
            cat.catIdStr=@"1";
        }
        else if ([newValue isEqualToString:@"Sports"])
        {
            cat.catName=@"Sports";
            cat.catIdStr=@"13";
        }
        else if ([newValue isEqualToString:@"Beauty"])
        {
            cat.catName=@"Beauty";
            cat.catIdStr=@"38";
        }
        else if ([newValue isEqualToString:@"Thereputic"])
        {
            cat.catName=@"Thereputic";
            cat.catIdStr=@"44";
        }
        else if ([newValue isEqualToString:@"Instrumental"])
        {
            cat.catName=@"Instrumental";
            cat.catIdStr=@"48";
        }
        else if ([newValue isEqualToString:@"Education"])
        {
            cat.catName=@"Education";
            cat.catIdStr=@"77";
        }
        else if ([newValue isEqualToString:@"Food"])
        {
            cat.catName=@"Food";
            cat.catIdStr=@"78";
        }
        else if ([newValue isEqualToString:@"Photography"])
        {
            cat.catName=@"Photography";
            cat.catIdStr=@"79";
        }
        else if ([newValue isEqualToString:@"Automotive"])
        {
            cat.catName=@"Automotive";
            cat.catIdStr=@"80";
        }
        else if ([newValue isEqualToString:@"Tech"])
        {
            cat.catName=@"Tech";
            cat.catIdStr=@"81";
        }
        else if ([newValue isEqualToString:@"Pets"])
        {
            cat.catName=@"Pets";
            cat.catIdStr=@"82";
        }
        [self.navigationController pushViewController:cat animated:YES];
    }
}
-(void)passSuggestionApi
{
//        NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//        NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_suggestions.php"];
//        NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        [manager GET:encodedString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            
//            NSLog(@"Response: %@",responseObject);
//            suggestionArray  =(NSMutableArray *)[responseObject valueForKey:@"data"];
//            NSLog(@"suggestionArray is :%@",suggestionArray);
//            [suggestionCollection reloadData];
//            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//         {
//             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
//                                                                 message:[error localizedDescription]
//                                                                delegate:nil
//                                                       cancelButtonTitle:@"Ok"
//                                                       otherButtonTitles:nil];
//             [alertView show];
//         }];
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (scrollView == homeScrollview)
//    {
//        if (scrollView.contentOffset.y>=suggestionLbl.frame.origin.y+20)
//        {
//            [scrollView setContentOffset:CGPointMake(0,suggestionLbl.frame.origin.y) animated:YES];
//            NSLog(@" Offset = %@ ",NSStringFromCGPoint(scrollView.contentOffset));
//        }
//    }
//}
# pragma mark CollectionView

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileViewController *pro=[[ProfileViewController alloc] init];
    pro.expertIdStr=[[suggestionArray objectAtIndex:indexPath.row]valueForKey:@"user_id"];
    pro.userFlag=@"expert";
    [self.navigationController pushViewController:pro animated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [suggestionArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SuggestionCollectionCell";
    SuggestionCollectionCell *Colcell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    Colcell.TitleLbl.text=[NSString stringWithFormat:@"%@ %@",[[suggestionArray  objectAtIndex:indexPath.row] valueForKey:@"firstname"],[[suggestionArray  objectAtIndex:indexPath.row] valueForKey:@"lastname"]];
    Colcell.subTitleLbl.text=[[suggestionArray  objectAtIndex:indexPath.row] valueForKey:@"catname"];
    Colcell.profilePic.layer.cornerRadius=Colcell.profilePic.frame.size.width/2;
    Colcell.profilePic.clipsToBounds=YES;
    [Colcell.profilePic setImageWithURL:[NSURL URLWithString:[[suggestionArray  objectAtIndex:indexPath.row]valueForKey:@"user_image"]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    return Colcell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.view.frame.size.width==414)
    {
        return CGSizeMake(199.0f, 96.00f);
    }
   else if (self.view.frame.size.width==375)
    {
        return CGSizeMake(180.0f, 96.00f);
    }
    else
    {
        return CGSizeMake(152.66f, 100.00f);
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == homeScrollview)
    {
        NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
        NSLog(@"%f",lastOffset.y);
        if (scrollView.contentOffset.y < lastOffset.y)
        {
            navView.hidden = NO;
            homeScrollview.frame=CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, homeScrollview.frame.size.height);
        }
        else
        {
            if (scrollView.contentOffset.y>0) {
                navView.hidden = YES;
                homeScrollview.frame=CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, homeScrollview.frame.size.height);
            }
        }
        NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
        lastOffset = scrollView.contentOffset;
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UILabel appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor whiteColor]];
    [self performSelector:@selector(homeMapGetLoctationAndZoom)
               withObject:nil
               afterDelay:0.5];
    self.navigationController.navigationBarHidden=YES;
    [homeSearchbar resignFirstResponder];
    [self setNeedsStatusBarAppearanceUpdate];
}
-(void)homeMapGetLoctationAndZoom
{
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    if(IS_OS_8_OR_LATER)
    {        [locationManager requestAlwaysAuthorization];
        //[locationManagerApp requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    CLLocation *location1 = [locationManager location];
    CLLocationCoordinate2D coordinate = [location1 coordinate];
     curreLat =coordinate.latitude;
     curreLongi = coordinate.longitude;
    NSLog(@"Latitude  = %f", curreLat);
    NSLog(@"Longitude = %f", curreLongi);
    
    /*MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude =lat;
    region.center.longitude =longi;
    region.span.longitudeDelta = 1.03f;
    region.span.latitudeDelta = 1.01f;
    [homeMap setRegion:region animated:YES];*/
    homeMap.showsUserLocation=YES;
    MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = curreLat;//-33.853698
    region.center.longitude = curreLongi;//151.217458
    region.span.longitudeDelta = .03f;
    region.span.latitudeDelta = .01f;
    [homeMap setRegion:region animated:YES];
    
    [self PassgetExpertWithLat:[NSString stringWithFormat:@"%f",curreLat] AndLongi:[NSString stringWithFormat:@"%f", curreLongi]];
}
-(void)PassgetExpertWithLat:(NSString *)lat AndLongi:(NSString *)longi
{
    NSString *urlStr;
    NSMutableDictionary *dictParams=[[NSMutableDictionary alloc] init];
    
        if ([catIdStr isEqualToString:@""]||catIdStr.length==0||catIdStr==(id)[NSNull null])
        {
            urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_expert_by_cat.php"];
            dictParams = (NSMutableDictionary *)@{@"lat":lat,@"long":longi};
        }
        else
        {
            urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_expert_by_cat.php"];
            dictParams =(NSMutableDictionary *)@{@"catid":catIdStr,@"lat":lat,@"long":longi};
        }
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@",responseObject);
        NSDictionary *cat=(NSDictionary *)responseObject;
        
        nearDics=[cat valueForKey:@"data"];
        if (![[nearDics valueForKey:@"data"]count]==0)
        {
            [self setMapPins];
        }
        else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }];
    
}
-(void)setMapPins
{
    annotationArray=[[NSMutableArray alloc] init];
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.02);
//    MKCoordinateRegion region = MKCoordinateRegionMake(homeMap.userLocation.coordinate, span);
//    [homeMap setRegion:region animated:YES];
//    [homeMap regionThatFits:region];
    //    [annotationArray removeAllObjects];
    [annotationArray addObjectsFromArray:[self annotations]];
    [homeMap addAnnotations:annotationArray];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (NSArray *)annotations
{
    pinArray=[[NSMutableArray alloc] init];
    for (int i=0 ; i<[nearDics count]; i++)
    {
        NSString *latStr=[[nearDics valueForKey:@"latitude"] objectAtIndex:i];
        NSString *longStr=[[nearDics valueForKey:@"longitude"] objectAtIndex:i];
        
        if (![latStr isEqualToString:@"0.0"]||![longStr isEqualToString:@"0.0"])
        {
            JPSThumbnail *users = [[JPSThumbnail alloc] init];
            
            users.image=[[nearDics valueForKey:@"user_image"] objectAtIndex:i];
            //            users.innerimage = [[nearDics valueForKey:@"user_image"] objectAtIndex:i];
            users.title = [NSString stringWithFormat:@"%@ %@",[[nearDics valueForKey:@"firstname"]objectAtIndex:i],[[nearDics valueForKey:@"lastname"]objectAtIndex:i]];
            users.subtitle = [[nearDics valueForKey:@"qulification"] objectAtIndex:i];
            double Lat=[[[nearDics valueForKey:@"latitude"] objectAtIndex:i] floatValue];
            double Long=[[[nearDics valueForKey:@"longitude"] objectAtIndex:i] floatValue];
            
            users.coordinate = CLLocationCoordinate2DMake(Lat ,Long);
            users.disclosureBlock = ^{  NSLog(@"selected %i",i);
//                [self detailButtonClicked:i];
            };
            NSLog(@"value is:%f : long: %f",Lat,Long);
            [pinArray addObject:[JPSThumbnailAnnotation annotationWithThumbnail:users]];
        }
    }
    return pinArray;
}
#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)])
    {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)])
    {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
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
- (IBAction)seeAllAction:(id)sender
{
    CategoryViewController *cat=[[CategoryViewController alloc] init];
    [self.navigationController pushViewController:cat animated:YES];
}
- (IBAction)fitnessAction:(id)sender
{
    SubCategoryVC *cat=[[SubCategoryVC alloc] init];
    cat.catName=@"Fitness";
    cat.catIdStr=@"1";
    [self.navigationController pushViewController:cat animated:YES];
   /* MapViewController *map=[[MapViewController alloc] init];
    map.catIdStr=@"1";
    [self.navigationController pushViewController:map animated:YES];*/
}
- (IBAction)educationAction:(id)sender
{
    SubCategoryVC *cat=[[SubCategoryVC alloc] init];
    cat.catName=@"Education";
    cat.catIdStr=@"77";
    [self.navigationController pushViewController:cat animated:YES];
    /*MapViewController *map=[[MapViewController alloc] init];
    map.catIdStr=@"2";
    [self.navigationController pushViewController:map animated:YES];*/
}
- (IBAction)computerAction:(id)sender
{
    SubCategoryVC *cat=[[SubCategoryVC alloc] init];
    cat.catName=@"Tech";
    cat.catIdStr=@"81";
    [self.navigationController pushViewController:cat animated:YES];
   /* MapViewController *map=[[MapViewController alloc] init];
    map.catIdStr=@"3";
    [self.navigationController pushViewController:map animated:YES];*/
}
- (IBAction)sportAction:(id)sender
{
    SubCategoryVC *cat=[[SubCategoryVC alloc] init];
    cat.catName=@"Business";
    cat.catIdStr=@"85";
    [self.navigationController pushViewController:cat animated:YES];
    
   /* MapViewController *map=[[MapViewController alloc] init];
    map.catIdStr=@"4";
    [self.navigationController pushViewController:map animated:YES];*/
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    SearchView *search=[[SearchView alloc] init];
    [self.navigationController pushViewController:search animated:NO];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}
- (IBAction)homeMapAction:(id)sender
{
    MapViewController *map=[[MapViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];
}
@end
