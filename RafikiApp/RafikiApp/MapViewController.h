//
//  MapViewController.h
//  RafikiApp
//
//  Created by CI-05 on 12/26/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "JPSThumbnailAnnotation.h"
#import "DVSwitch.h"
#import "ProfileViewController.h"


#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "RearViewController.h"
@interface MapViewController : UIViewController<CLLocationManagerDelegate,SWRevealViewControllerDelegate>
{
    
    IBOutlet MKMapView *nearMapview;
    IBOutlet UIButton *sliderButtton;
    NSMutableArray *annotationArray;
    NSMutableArray *pinArray;
   
    IBOutlet UIButton *filterButton;
    
    IBOutlet UIView *filterView;
    BOOL filterFlag;
    CLLocationManager *locationManager;
    NSMutableDictionary *nearDics;

    IBOutlet UISlider *rangeSlider;
    IBOutlet UISlider *priceSlider;
    IBOutlet UIButton *categoryButton;
    IBOutlet UILabel *rangeLbl;
    IBOutlet UILabel *priceLbl;
    IBOutlet UISwitch *onlineSwitch;
    NSString *genderStr;
    NSMutableDictionary *catDics;
    IBOutlet UITableView *catTbl;
    IBOutlet UIView *catView;
    NSString *filterStr;
    NSString *loginStatusStr;
    NSString *filterCatIdStr;
    
    float latPub ;
    float longiPub;
    
    IBOutlet UIView *annotationView;
    IBOutlet UIImageView *userImgView;
    IBOutlet UILabel *userNameLbl;
    IBOutlet UILabel *DesignationLbl;
    IBOutlet UILabel *QualificationLbl;
    IBOutlet UIImageView *img1;
    IBOutlet UIImageView *img2;
    IBOutlet UIImageView *img3;
    IBOutlet UIImageView *img4;
    IBOutlet UIImageView *img5;
    IBOutlet UILabel *expirianceLbl;
    
    int  ClickTag;
    
    NSMutableArray *catSelectArray;
    
}
- (IBAction)okAction:(id)sender;
@property(nonatomic,retain)NSString *buttonHideshowFlag;
- (IBAction)profileAction:(id)sender;
@property (retain, nonatomic) DVSwitch *switcher;
@property(retain,nonatomic)NSString *catIdStr;
- (IBAction)filterAction:(id)sender;
- (IBAction)categoryAction:(id)sender;
- (IBAction)applyAction:(id)sender;
- (IBAction)rangeSliderAction:(id)sender;
- (IBAction)priceSliderAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
@end
