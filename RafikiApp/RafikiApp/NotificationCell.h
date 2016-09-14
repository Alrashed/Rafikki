//
//  NotificationCell.h
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *notifUserimageview;
@property (strong, nonatomic) IBOutlet UILabel *notifTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *notifDetailLbl;
@property (strong, nonatomic) IBOutlet UILabel *notifTimeLbl;

@property (strong, nonatomic) IBOutlet UIButton *profilePictureButton;

@end
