//
//  PhotoIdVC.h
//  RafikiApp
//
//  Created by CI-05 on 4/9/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AboutMeVC.h"

#import "AFNetworking/AFNetworking.h"
@interface PhotoIdVC : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    IBOutlet UIButton *addImageButton;
    IBOutlet UIImageView *photoimgview;
    IBOutlet UILabel *roundLbl1;
    IBOutlet UILabel *roundLbl2;
    
    UIImage *currentImage;
    IBOutlet UIButton *nextButton;
}
@property(nonatomic,retain)NSString *checkPhotoEditFlag;
- (IBAction)backAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)addImageAction:(id)sender;
@end
