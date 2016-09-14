//
//  HelpViewController.h
//  RafikiApp
//
//  Created by CI-05 on 2/15/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "RearViewController.h"
#import "SocialViewController.h"
@interface HelpViewController : UIViewController
{
    
    IBOutlet UITableView *helpTbl;
    NSMutableArray *nameArray;
    IBOutlet UIButton *sliderButton;
}
@end
