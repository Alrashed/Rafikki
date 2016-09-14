//
//  PastJobCell.h
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PastJobCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *img1;
@property (strong, nonatomic) IBOutlet UIImageView *img2;
@property (strong, nonatomic) IBOutlet UIImageView *img3;
@property (strong, nonatomic) IBOutlet UIImageView *img4;
@property (strong, nonatomic) IBOutlet UIImageView *img5;

@property (strong, nonatomic) IBOutlet UIImageView *pastjobUserimageView;
@property (strong, nonatomic) IBOutlet UILabel *pastjobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *pastjobDesignationLbll;
@property (strong, nonatomic) IBOutlet UILabel *pastjobDetailLbl;

@property (strong, nonatomic) IBOutlet UIButton *profilePictureButton;

@property (strong, nonatomic) IBOutlet UIButton *nameButton;

@end
