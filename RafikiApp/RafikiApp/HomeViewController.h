//
//  HomeViewController.h
//  RafikiApp
//
//  Created by CI-05 on 12/25/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "SuggestionCollectionCell.h"
#import "AFNetworking/AFNetworking.h"
#import "SearchView.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import <MapKit/MapKit.h>
#import "SubCategoryVC.h"
#import "SMRotaryWheel.h"
#import "SMRotaryProtocol.h"

#import "CAPSPageMenu.h"

#import "TestTableViewController.h"
#import "TestCollectionViewController.h"
#import "TestCollectionViewController2.h"
#import "TestCollectionViewController3.h"
#import "TestCollectionViewController4.h"
#import "TestViewController.h"


@interface HomeViewController : UIViewController<SWRevealViewControllerDelegate,CLLocationManagerDelegate,SMRotaryProtocol>
{
    IBOutlet UIButton *sliderButton;
    IBOutlet UIScrollView *homeScrollview;
    IBOutlet UILabel *suggestionLbl;
    NSMutableArray *suggestionArray;
    IBOutlet UICollectionView *suggestionCollection;
    IBOutlet UISearchBar *homeSearchbar;
    CGPoint lastOffset;
    IBOutlet UIView *navView;
    IBOutlet MKMapView *homeMap;
    
    CLLocationManager *locationManager;
    float curreLat ;
    float curreLongi;
       BOOL first;
    NSString *catIdStr;
    NSMutableDictionary *nearDics;
    NSMutableArray *annotationArray;
    NSMutableArray *pinArray;
    IBOutlet UIView *catWhileView;

}

- (IBAction)getchureAction:(id)sender;
- (IBAction)seeAllAction:(id)sender;
- (IBAction)fitnessAction:(id)sender;
- (IBAction)educationAction:(id)sender;
- (IBAction)computerAction:(id)sender;
- (IBAction)sportAction:(id)sender;
- (IBAction)searchAction:(id)sender;
- (IBAction)homeMapAction:(id)sender;

@end
