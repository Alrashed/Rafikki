//
//  UUDatePicker.h
//  Yang
//
//  Created by shake on 14-7-24.
//  Copyright (c) 2014 uyiuyao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UUDatePicker;

typedef enum{
    
    UUDateStyle_YearMonthDayHourMinute = 0,
    UUDateStyle_YearMonthDay,
    UUDateStyle_MonthDayHourMinute,
    UUDateStyle_HourMinute
    
}DateStyle;

typedef void (^FinishBlock)(NSString * year,
                            NSString * month,
                            NSString * day,
                            NSString * hour,
                            NSString * minute,
                            NSString * weekDay);


//  Description, uiDatePicker the Size of the smallest is 320x216.
@protocol UUDatePickerDelegate <NSObject>

- (void)uuDatePicker:(UUDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay;
@end


@interface UUDatePicker : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, assign) id <UUDatePickerDelegate> delegate;

@property (nonatomic, assign) DateStyle datePickerStyle;

@property (nonatomic, retain) NSDate *ScrollToDate;//Rolled specified date
@property (nonatomic, retain) NSDate *maxLimitDate;//The maximum time limit (no default 2049)
@property (nonatomic, retain) NSDate *minLimitDate;//The minimum time limit (no default 1970)

- (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
- (id)initWithframe:(CGRect)frame Delegate:(id<UUDatePickerDelegate>)delegate PickerStyle:(DateStyle)uuDateStyle;
- (id)initWithframe:(CGRect)frame PickerStyle:(DateStyle)uuDateStyle didSelected:(FinishBlock)finishBlock;

@end

// Copyright belongs to original author
// http://code4app.net (en) http://code4app.com (cn)
// From the most professional code share website: Code4App.net 
