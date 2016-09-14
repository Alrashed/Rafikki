//
//  SearchView.h
//  RafikiApp
//
//  Created by CI-05 on 1/19/16.
//  Copyright © 2016 CI-05. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchView : UIViewController<UISearchBarDelegate>
{
    
    IBOutlet UISearchBar *userSearchbar;
    NSMutableArray *allExpertArray;
    NSMutableArray *tempArray;
    IBOutlet UITableView *searchTbl;
    CGPoint lastOffset;
    
    IBOutlet UIView *navView;
    
}
- (IBAction)backAction:(id)sender;
@end
