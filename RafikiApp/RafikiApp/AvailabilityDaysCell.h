//
//  AvailabilityDaysCell.h
//  RafikiApp
//
//  Created by CI-05 on 4/19/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvailabilityDaysCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIButton *addTimeButton;
@property (strong, nonatomic) IBOutlet UILabel *daysLbl;
@property (strong, nonatomic) IBOutlet UILabel *plusLbl;
@property (strong, nonatomic) IBOutlet UILabel *timeLbl;
@end
