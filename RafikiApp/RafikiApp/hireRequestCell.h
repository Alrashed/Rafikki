//
//  hireRequestCell.h
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hireRequestCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *hireUserimageview;
@property (strong, nonatomic) IBOutlet UILabel *hireTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *hireDesignationLbl;
@property (strong, nonatomic) IBOutlet UILabel *hireDetailLbl;
@property (strong, nonatomic) IBOutlet UIButton *acceptBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *profilePictureButton;

@property (strong, nonatomic) IBOutlet UIButton *timeButton;
@property (strong, nonatomic) IBOutlet UILabel *jobStatusLbl;

@end
