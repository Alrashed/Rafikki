//
//  SocialViewController.h
//  RafikiApp
//
//  Created by CI-05 on 1/1/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "RearViewController.h"

#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
@interface SocialViewController : UIViewController{

    IBOutlet UITableView *socialTbl;
    NSMutableArray *iconArray;
    NSMutableArray *nameArray;
}
- (IBAction)backAction:(id)sender;
@end
