//
//  AvibilityCell.h
//  RafikiApp
//
//  Created by CI-05 on 3/23/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvibilityCell : UITableViewCell
{
    
   
}
@property (nonatomic,retain)IBOutlet UILabel *monTimeLbl;
@property (nonatomic,retain)IBOutlet UILabel *tueTimeLbl;
@property (nonatomic,retain)IBOutlet UILabel *wedTimeLbl;
@property (nonatomic,retain)IBOutlet UILabel *thuTimeLbl;
@property (nonatomic,retain)IBOutlet UILabel *friTimeLbl;
@property (nonatomic,retain)IBOutlet UILabel *satTimeLbl;
@property (nonatomic,retain)IBOutlet UILabel *sunTimeLbl;

@property (strong, nonatomic) IBOutlet UILabel *firstLineLbl;
@property (strong, nonatomic) IBOutlet UILabel *secondLineLbl;
@property (strong, nonatomic) IBOutlet UILabel *thirdLineLbl;
@property (strong, nonatomic) IBOutlet UILabel *forthLineLbl;
@property (strong, nonatomic) IBOutlet UILabel *fifthLineLbl;
@property (strong, nonatomic) IBOutlet UILabel *sixthLineLbl;
@property (strong, nonatomic) IBOutlet UILabel *lastLine;
@end
