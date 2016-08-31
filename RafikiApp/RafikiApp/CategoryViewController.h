//
//  CategoryViewController.h
//  RafikiApp
//
//  Created by CI-05 on 1/2/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ASIHTTPRequest.h"
//#import "JSON.h"

#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "MapViewController.h"
#import "MBProgressHUD.h"
#import "SubCategoryVC.h"
#import "MBProgressHUD.h"
@interface CategoryViewController : UIViewController
{
    IBOutlet UITableView *catTbl;
    NSMutableDictionary *catDics;
}
- (IBAction)backAction:(id)sender;
@end
