//
//  jobHistoryTableViewCell.h
//  RafikiApp
//
//  Created by CI-05 on 12/29/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jobHistoryTableViewCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *img1;
@property (strong, nonatomic) IBOutlet UIImageView *img2;
@property (strong, nonatomic) IBOutlet UIImageView *img3;
@property (strong, nonatomic) IBOutlet UIImageView *img4;
@property (strong, nonatomic) IBOutlet UIImageView *img5;


@property (strong, nonatomic) IBOutlet UIImageView *userimgView;
@property (strong, nonatomic) IBOutlet UILabel *jobTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *jobDetailLbl;

@property (strong, nonatomic) IBOutlet UIButton *profilePictureButton;

@end
