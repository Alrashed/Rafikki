//
//  MessageListCell.h
//  RafikiApp
//
//  Created by CI-05 on 12/30/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MessageListCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UILabel *messageCounterLbl;

@property(nonatomic,retain)UIImageView  *messageUserImageview;
@property (strong, nonatomic) IBOutlet UIButton *messageTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *messageDetailLbl;
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;

@property (strong, nonatomic) IBOutlet UIButton *profilePictureButton;

@end
