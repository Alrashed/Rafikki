//
//  MapViewController.m
//  RafikiApp
//
//  Created by CI-05 on 12/26/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import "MapViewController.h"
#import "AFNetworking/AFNetworking.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize catIdStr,buttonHideshowFlag;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // [START create_database_reference]
    self.ref = [[FIRDatabase database] reference];
    // [END create_database_reference]

    filterView.hidden=YES;
    catView.hidden=YES;
    
    catSelectArray=[[NSMutableArray alloc] init];
    
    annotationView.hidden=YES;
    userImgView.layer.cornerRadius=userImgView.frame.size.width/2;
    userImgView.layer.borderWidth=2;
    userImgView.layer.borderColor=[UIColor colorWithRed:0.0/255 green:0.0/255 blue:0.0/255 alpha:0.5].CGColor;
    userImgView.clipsToBounds=YES;
    
    nearMapview.showsUserLocation=YES;
   /* self.switcher = [[DVSwitch alloc] initWithStringsArray:@[@"Man", @"Woman",@"All"]];
    self.switcher.frame = CGRectMake(10,55, filterView.frame.size.width -20, 30);
    [self.switcher forceSelectedIndex:2 animated:NO];
    self.switcher.font = [UIFont fontWithName:@"Roboto-Regular" size:13];//2 113 151
    self.switcher.backgroundColor = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0];
    self.switcher.sliderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.switcher.labelTextColorInsideSlider = [UIColor colorWithRed:46/255.0 green:139/255.0 blue:111/255.0 alpha:1.0];
    [filterView addSubview:self.switcher];
    [self.switcher setPressedHandler:^(NSUInteger index)
     {
         if (index==0)
         {
            genderStr=@"1";
         }
         else if (index==1)
         {
             genderStr=@"0";
         }
         else
         {
             genderStr=@"";
         }
         NSLog(@"Did press position on first switch at index: %lu", (unsigned long)index);
     }];*/
    if ([buttonHideshowFlag isEqualToString:@"Yes"])
    {
        [sliderButtton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        filterButton.hidden=YES;
        [sliderButtton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        
        
        [sliderButtton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addGestureRecognizer:[self.revealViewController tapGestureRecognizer]];
        [self.view addGestureRecognizer:[self.revealViewController panGestureRecognizer]];
    }
}
- (IBAction)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    [self setNeedsStatusBarAppearanceUpdate];
    [self getCurrentLoc];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)passGetCategorys
{
    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_cat.php"];
    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager GET:encodedString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response: %@",responseObject);
        NSMutableDictionary *cat = (NSMutableDictionary *)responseObject;
        catDics=[cat valueForKey:@"cat"];
        NSLog(@"cat dics :%@",catDics);
        [catTbl reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
                                                             message:[error localizedDescription]
                                                            delegate:nil
                                                   cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
         [alertView show];
     }];
//    catDics = [NSMutableDictionary dictionary];
//   // [catDics setObject:@"" forKey:@"cat"];
//    FIRDatabaseQuery *mycatQuery = [_ref child:@"cat"];
//////    FIRDatabaseQuery *myTopPostsQuery = [[[_ref child:@"categories"]
//////                                          child:[super getUid]]
//////                                         queryOrderedByChild:@"starCount"];
//    [mycatQuery observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
////    //    [[mycatQuery queryOrderedByChild:@"cat_name"]observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
//        
//        //catDics = (NSMutableDictionary *)snapshot.value;
//        //NSMutableDictionary *categ = (NSMutableDictionary *)snapshot.value;
//        catDics = (NSMutableDictionary *)snapshot.value;
//        //catDics=[categ valueForKey:@"cat"];
//        //[catDics setObject:categ forKey:@"cat"];
////       //[catDics setValue:snapshot.key forKey:@"cat"];
////            //cats = (NSArray *)snapshot.key;
//        NSLog(@"%@catDics", catDics);
//        //NSLog(@"%@categ", categ);
//    }];
//    [catTbl reloadData];
    
}
-(void)getCurrentLoc
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
     latPub =coordinate.latitude;
     longiPub = coordinate.longitude;
    NSLog(@"Latitude  = %f", latPub);
    NSLog(@"Longitude = %f", longiPub);
    NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];

    if ([useridStr isEqualToString:@""]||useridStr ==nil||useridStr ==(id)[NSNull null])
    {
        [self PassgetExpertWithLat:[NSString stringWithFormat:@"%f",latPub] AndLongi:[NSString stringWithFormat:@"%f",longiPub]];
    }
    else
    {
        [self passUpdateLocationApiWithLat:[NSString stringWithFormat:@"%f",latPub] Withlong:[NSString stringWithFormat:@"%f",longiPub]];
    }
}
-(void)passUpdateLocationApiWithLat:(NSString *)lat Withlong:(NSString *)longi
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    FIRUser *user = [FIRAuth auth].currentUser;
    //NSString *useridStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    //make request to the server
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/update_user_location.php?userid=%@&latitude=%f&longitude=%f",useridStr,lat,longi];
    
    
//    NSString *urlStr =[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/update_user_location.php"];
//    NSDictionary *dictParams = @{@"latitude":lat,
//                                 @"longitude":longi,
//                                 @"userid":useridStr
//                                 };
//    NSString *encodedString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager GET:encodedString parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"Response: %@",responseObject);
//        NSDictionary *cat=(NSDictionary *)responseObject;
//        if ([[cat valueForKey:@"msg"]isEqualToString:@"update success"])
//        {
//            [self PassgetExpertWithLat:lat AndLongi:longi];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving"
//                                                             message:[error localizedDescription]
//                                                            delegate:nil
//                                                   cancelButtonTitle:@"Ok"
//                                                   otherButtonTitles:nil];
//         [alertView show];
//         [MBProgressHUD hideHUDForView:self.view animated:YES];
//     }];
    
    [[[[_ref child:@"users"] child:user.uid] child:@"latitude"] setValue:lat];
    [[[[_ref child:@"users"] child:user.uid] child:@"longitude"] setValue:longi];
    [self PassgetExpertWithLat:lat AndLongi:longi];
    
}
-(void)PassgetExpertWithLat:(NSString *)lat AndLongi:(NSString *)longi
{
    NSString *urlStr;
    NSMutableDictionary *dictParams=[[NSMutableDictionary alloc] init];
    if ([filterStr isEqualToString:@"Yes"])
    {
        //http://cricyard.com/iphone/rafiki_app/service/get_expert_by_cat.php?catid=1&lat=21.00&long=23.00&gender=1&online=0&price_range_low=1&price_range_high=20
        int price=priceSlider.value;
        
        urlStr=[NSString stringWithFormat:@"http://cricyard.com/iphone/rafiki_app/service/get_expert_by_cat.php"];
        [dictParams setObject:lat forKey:@"lat"];
        [dictParams setObject:longi forKey:@"long"];
        [dictParams setObject:loginStatusStr forKey:@"online"];
        [dictParams setObject:@"0" forKey:@"price_range_low"];
        [dictParams setObject:[NSString stringWithFormat:@"%d",price*60] forKey:@"price_range_high"];
        [dictParams setObject:[NSString stringWithFormat:@"%.2f",rangeSlider.value] forKey:@"mile"];

        NSLog(@"%@ %ld",filterCatIdStr,filterCatIdStr.length);
        if (filterCatIdStr.length!=0)//(filterCatIdStr!=(id)[NSNull null])
        {
            [dictParams setObject:filterCatIdStr forKey:@"catid"];
        }
        if (genderStr.length!=0)
        {
            [dictParams setObject:genderStr forKey:@"gender"];
        }
    }
    else
    {
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
        filterStr=@"No";
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
    MKCoordinateSpan span = MKCoordinateSpanMake(0.01, 0.02);
    MKCoordinateRegion region = MKCoordinateRegionMake(nearMapview.userLocation.coordinate, span);
    [nearMapview setRegion:region animated:YES];
    [nearMapview regionThatFits:region];
//    [annotationArray removeAllObjects];
    [annotationArray addObjectsFromArray:[self annotations]];
    [nearMapview addAnnotations:annotationArray];
    [self zoomInToMyLocation];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self passGetCategorys];
}
-(void)zoomInToMyLocation
{
    NSUInteger abc=nearDics.count;
    NSLog(@"%f dics",[[[nearDics valueForKey:@"latitude"] objectAtIndex:abc-1] floatValue]);
    
        MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = [[[nearDics valueForKey:@"latitude"] objectAtIndex:abc-1] floatValue];//-33.853698
        region.center.longitude = [[[nearDics valueForKey:@"longitude"] objectAtIndex:abc-1] floatValue];//151.217458
        region.span.longitudeDelta = .03f;
        region.span.latitudeDelta = .01f;
        [nearMapview setRegion:region animated:YES];
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
                [self detailButtonClicked:i];
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
    annotationView.hidden=YES;
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
-(void) detailButtonClicked :(int) tag
{
    annotationView.hidden=NO;
     ClickTag=tag;
    
 [userImgView setImageWithURL:[NSURL URLWithString:[[nearDics valueForKey:@"user_image"] objectAtIndex:tag]] placeholderImage:[UIImage imageNamed:@"photo"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    userNameLbl.text=[NSString stringWithFormat:@"%@ %@",[[nearDics valueForKey:@"firstname"]objectAtIndex:tag],[[nearDics valueForKey:@"lastname"]objectAtIndex:tag]];
    
    DesignationLbl.text=[[nearDics valueForKey:@"email"] objectAtIndex:tag];
    QualificationLbl.text=[[nearDics valueForKey:@"phone_no"] objectAtIndex:tag];
//    expirianceLbl.text=[[nearDics valueForKey:@"experience"] objectAtIndex:tag];
    
    float  ratestar=[[[nearDics valueForKey:@"ratings"] objectAtIndex:tag] floatValue];
//                     [[[nearDics  valueForKey:@"ratings"] objectAtIndex:tag] floatValue]
    int rate=floor(ratestar);
    if (rate==1)
    {
        img1.image=[UIImage imageNamed:@"star_s"];
        img2.image=[UIImage imageNamed:@"star_d"];
        img3.image=[UIImage imageNamed:@"star_d"];
        img4.image=[UIImage imageNamed:@"star_d"];
        img5.image=[UIImage imageNamed:@"star_d"];
    }
    else if(rate==2)
    {
        img1.image=[UIImage imageNamed:@"star_s"];
        img2.image=[UIImage imageNamed:@"star_s"];
        img3.image=[UIImage imageNamed:@"star_d"];
        img4.image=[UIImage imageNamed:@"star_d"];
        img5.image=[UIImage imageNamed:@"star_d"];
        
    }
    else if(rate==3)
    {
        img1.image=[UIImage imageNamed:@"star_s"];
        img2.image=[UIImage imageNamed:@"star_s"];
        img3.image=[UIImage imageNamed:@"star_s"];
        img4.image=[UIImage imageNamed:@"star_d"];
        img5.image=[UIImage imageNamed:@"star_d"];

    }
    else if(rate==4)
    {
        img1.image=[UIImage imageNamed:@"star_s"];
        img2.image=[UIImage imageNamed:@"star_s"];
        img3.image=[UIImage imageNamed:@"star_s"];
        img4.image=[UIImage imageNamed:@"star_s"];
        img5.image=[UIImage imageNamed:@"star_d"];
    }
    else if(rate==5)
    {
        img1.image=[UIImage imageNamed:@"star_s"];
        img2.image=[UIImage imageNamed:@"star_s"];
        img3.image=[UIImage imageNamed:@"star_s"];
        img4.image=[UIImage imageNamed:@"star_s"];
        img5.image=[UIImage imageNamed:@"star_s"];
    }
    else
    {
        img1.image=[UIImage imageNamed:@"star_d"];
        img2.image=[UIImage imageNamed:@"star_d"];
        img3.image=[UIImage imageNamed:@"star_d"];
        img4.image=[UIImage imageNamed:@"star_d"];
        img5.image=[UIImage imageNamed:@"star_d"];
    }
}
-(IBAction)profileAction:(id)sender
{
    ProfileViewController *pro=[[ProfileViewController alloc] init];
    NSLog(@"bdvbbvv:%@",[[nearDics valueForKey:@"user_id"] objectAtIndex:ClickTag]);
    pro.expertIdStr=[[nearDics valueForKey:@"user_id"] objectAtIndex:ClickTag];
    pro.userFlag=@"expert";
    [self.navigationController pushViewController:pro animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)filterAction:(id)sender
{
    if (filterFlag == YES)
    {
        filterView.hidden=YES;
        filterFlag=NO;
    }
    else
    {
        filterView.hidden=NO;
        filterFlag=YES;
    }
}
- (IBAction)categoryAction:(id)sender
{
    catView.hidden=NO;
}
- (IBAction)applyAction:(id)sender
{
    [nearMapview removeAnnotations:annotationArray];
    [annotationArray removeAllObjects];
    [pinArray removeAllObjects];
    [catSelectArray removeAllObjects];
    
    filterView.hidden=YES;
     filterFlag=NO;
    if (onlineSwitch.on)
    {
        NSLog(@"On");
        loginStatusStr=@"0";
    }
    else
    {
        NSLog(@"Off");
        loginStatusStr=@"1";
    }
    filterStr=@"Yes";
    [self PassgetExpertWithLat:[NSString stringWithFormat:@"%f",latPub] AndLongi:[NSString stringWithFormat:@"%f",longiPub]];
}
- (IBAction)rangeSliderAction:(id)sender
{
    int range=rangeSlider.value;
    rangeLbl.text=[NSString stringWithFormat:@"%d Mile",range];
}
- (IBAction)priceSliderAction:(id)sender
{
    float price=priceSlider.value;
    priceLbl.text=[NSString stringWithFormat:@"%.2f $",price];
}
- (IBAction)cancelAction:(id)sender
{
    catView.hidden=YES;
}
#pragma mark Tableview delegate methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return catDics.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
//    cell=nil;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    if ([catSelectArray containsObject:[[catDics valueForKey:@"cat_id"] objectAtIndex:indexPath.row]])
    {
        [cell setSelected:YES];
    }
    else
    {
        [cell setSelected:NO];
    }

    cell.textLabel.textColor=[UIColor grayColor];
//    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.text=[[catDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [categoryButton setTitle:[[catDics valueForKey:@"cat_name"] objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [catSelectArray addObject:[[catDics valueForKey:@"cat_id"] objectAtIndex:indexPath.row]];
    UITableViewCell *cell = (UITableViewCell *) [catTbl cellForRowAtIndexPath:indexPath];
     [cell setSelected:YES];
    
  }
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [catSelectArray removeObject:[[catDics valueForKey:@"cat_id"] objectAtIndex:indexPath.row]];
    UITableViewCell *cell = (UITableViewCell *) [catTbl cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    [catTbl setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
}

- (IBAction)okAction:(id)sender
{
    filterCatIdStr=@"";
    
    if (catSelectArray.count==0)
    {
        [[[UIAlertView alloc] initWithTitle:@"No One Selected" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    else
    {
        for (int i=0; i<catSelectArray.count; i++)
        {
            if ([filterCatIdStr isEqualToString:@""]||filterCatIdStr.length==0)
            {
                filterCatIdStr=[[catDics valueForKey:@"cat_id"] objectAtIndex:i];
            }
            else
            {
                filterCatIdStr=[NSString stringWithFormat:@"%@,%@",filterCatIdStr,[[catDics valueForKey:@"cat_id"] objectAtIndex:i]];
            }
        }
    }
    catView.hidden=YES;
    NSLog(@"%@",filterCatIdStr);
}
@end
