//
//  VeryficationVC.h
//  RafikiApp
//
//  Created by CI-05 on 2/3/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalViewController.h"
#import "AFNetworking/AFNetworking.h"
@interface VeryficationVC : UIViewController
{
    
    IBOutlet UITextField *emailTxt;
    IBOutlet UIButton *verfyButton;
    IBOutlet UIButton *sendAginButton;
}
- (IBAction)sendAginAction:(id)sender;
- (IBAction)veryfyAction:(id)sender;
@property(nonatomic,retain)NSString *signupFlag;
@property(nonatomic,retain)NSString *codeStr;
@end
