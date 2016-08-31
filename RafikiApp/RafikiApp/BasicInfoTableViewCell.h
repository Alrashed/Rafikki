//
//  BasicInfoTableViewCell.h
//  RafikiApp
//
//  Created by CI-05 on 12/29/15.
//  Copyright © 2015 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInfoTableViewCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *iconImageview;
@property (strong, nonatomic) IBOutlet UILabel *infoTitleLbl;
@property (strong, nonatomic) IBOutlet UILabel *infoDetailLbl;
@end
