//
//  BecomeRafikkiVC.h
//  RafikiApp
//
//  Created by CI-05 on 3/25/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "check&DiclosesVC.h"

@interface BecomeRafikkiVC : UIViewController
{
    
    IBOutlet UIButton *startButton;
    IBOutlet UILabel *roundLbl1;
    IBOutlet UILabel *roundLbl2;
    IBOutlet UILabel *roundLbl3;
    IBOutlet UILabel *roundLbl4;
}
- (IBAction)startAction:(id)sender;
- (IBAction)backAction:(id)sender;
@end
