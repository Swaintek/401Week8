//
//  Reminder.m
//  locationreminders
//
//  Created by David Swaintek on 7/27/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic name;
@dynamic location;
@dynamic radius;

+(void)load{
    [self registerSubclass];
}

+(NSString *)parseClassName{
    return @"Reminder";
}

@end
