//
//  SettingViewController.h
//  RafikiApp
//
//  Created by CI-05 on 1/2/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "RearViewController.h"

//#import "BraintreeCore.h"
//#import "BraintreeUI.h"
//#import "BraintreePayPal.h"
//#import "BecomeRafikkiVC.h"

@interface SettingViewController : UIViewController//<BTDropInViewControllerDelegate,BTAppSwitchDelegate, BTViewControllerPresentingDelegate>
{
    IBOutlet UIButton *sliderButton;
}
- (IBAction)becomeRaffikiAction:(id)sender;
//@property (nonatomic, strong) BTPayPalDriver *payPalDriver;
//@property (nonatomic, strong) BTAPIClient *braintreeClient;
@end
