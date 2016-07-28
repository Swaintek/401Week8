//
//  Reminder.h
//  locationreminders
//
//  Created by David Swaintek on 7/27/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject<PFSubclassing>

@property(strong, nonatomic)NSString *name;
@property(strong, nonatomic)NSNumber *radius;
@property(strong, nonatomic)PFGeoPoint *location;

@end
