//
//  DetailViewController.m
//  locationreminders
//
//  Created by David Swaintek on 7/26/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"

#import "LocationController.h"

@interface DetailViewController ()
- (IBAction)createReminderButtonSelected:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *locationName;
@property (weak, nonatomic) IBOutlet UITextField *userRadius;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"TITLE: %@", self.annotationTitle);
    NSLog(@"COORDINATE: %f, %f", self.coordinate.latitude, self.coordinate.longitude);
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TestNotification" object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)createReminderButtonSelected:(UIButton *)sender {
//    NSString *reminderName = @"Test Reminder";
//    NSNumber *radius = [NSNumber numberWithFloat:100.0];
    
    Reminder *reminder = [Reminder object];
    
    reminder.name = _locationName.text;
    reminder.radius = [NSNumber numberWithFloat:_userRadius.text.floatValue];
    
    reminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    __weak typeof(self) weakSelf = self;
    [reminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        NSLog(@"Reminder Saved to our Parse Server");
        
        if (strongSelf.completion) {
            if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]){
                CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:strongSelf.coordinate radius:reminder.radius.floatValue identifier:reminder.name];
                
                [[[LocationController sharedController]locationManager]startMonitoringForRegion:region];
                
                strongSelf.completion([MKCircle circleWithCenterCoordinate:strongSelf.coordinate radius:reminder.radius.floatValue]);
                
                [strongSelf.navigationController popViewControllerAnimated:YES];
            }
        }
        
    }];
    
//    if (self.completion) {
////        self.completion([MKCircle circleWithCenterCoordinate:self.coordinate radius:radius.floatValue]);
////        
////        [self.navigationController popViewControllerAnimated:YES];
//
//    }
}
@end
