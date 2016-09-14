//
//  SelectAndAddPaymentVC.h
//  RafikiApp
//
//  Created by CI-05 on 3/18/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "MBProgressHUD.h"

#import <Stripe/Stripe.h>


@interface SelectAndAddPaymentVC : UIViewController<UIActionSheetDelegate,STPPaymentCardTextFieldDelegate>
{
    
    IBOutlet UIImageView *line2Img;
    IBOutlet UIImageView *line1Img;
    IBOutlet UIImageView *popIconImg;
    IBOutlet UILabel *popTileLbl;
    IBOutlet UIView *paymentPopView;
    IBOutlet UIButton *sliderButton;
    IBOutlet UIView *paypalPopView;
    IBOutlet UITableView *paymentTbl;
    NSMutableArray *monthArray;
    NSMutableArray *yearArray;

    IBOutlet UIButton *addAccountBtn;
    IBOutlet UIImageView *popBgImg;
    IBOutlet UILabel *hintLbl;
}
@property (strong, nonatomic) IBOutlet STPPaymentCardTextField *paymentDetailTxt;
- (IBAction)addMethodAction:(id)sender;
- (IBAction)addAcoountAction:(id)sender;
@end
