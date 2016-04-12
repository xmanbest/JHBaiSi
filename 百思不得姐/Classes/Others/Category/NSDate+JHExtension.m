//
//  NSDate+JHExtension.m
//  百思不得姐
//
//  Created by 李建華 on 16/4/6.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import "NSDate+JHExtension.h"

@implementation NSDate (JHExtension)
- (NSDateComponents *)deltaFromDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *deltaCompos = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self toDate:date options:0];

//    JHLog(@"year:%zd, month:%zd, day:%zd, hour:%zd, minute:%zd, second:%zd", deltaCompos.year, deltaCompos.month, deltaCompos.day, deltaCompos.hour, deltaCompos.minute, deltaCompos.second);
    return deltaCompos;
}

- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

- (BOOL)isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *nowCompos = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *selfCompos = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    return nowCompos.year == selfCompos.year && nowCompos.month == selfCompos.month && nowCompos.day == selfCompos.day;
}

- (BOOL)isYesterday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 忽略时间，只考虑日期
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy:MM:dd";
    // 二次转换 屏蔽时间 保留日期
    NSDate *nowDate = [format dateFromString:[format stringFromDate:[NSDate date]]];
    NSDate *selfDate = [format dateFromString:[format stringFromDate:self]];
    
    NSDateComponents *deltaCompos = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return deltaCompos.year == 0 && deltaCompos.month == 0 && deltaCompos.day == 1;

}
@end
