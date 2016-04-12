//
//  NSDate+JHExtension.h
//  百思不得姐
//
//  Created by 李建華 on 16/4/6.
//  Copyright © 2016年 lijianhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (JHExtension)
- (NSDateComponents *)deltaFromDate:(NSDate *)date;

- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;
@end
