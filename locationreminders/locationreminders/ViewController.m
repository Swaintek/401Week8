//
//  ViewController.m
//  locationreminders
//
//  Created by David Swaintek on 7/25/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@import MapKit;

@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)firstLocationButton:(id)sender;
- (IBAction)secondLocationButton:(id)sender;
- (IBAction)thirdLocationButton:(id)sender;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    
//    testObject[@"foo"] = @"bar";
//    
//    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *_Nullable error) {
//       
//        NSLog(@"Succeeded: %i, Error: %@", succeeded, error);
//    }];
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        
//        if (!error) {
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                NSLog(@"Objects: %@", objects);
//            }];
//        }
//    }];
    
    [self requestPermissions];
    [self.mapView.layer setCornerRadius:20.0];
}

- (void)requestPermissions {
    [self setLocationManager:[[CLLocationManager alloc] init]];
    [self.locationManager requestAlwaysAuthorization];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstLocationButton:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6566674, -122.35109699999998);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)secondLocationButton:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(34.2943, -116.4037);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)thirdLocationButton:(id)sender {
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(39.6654, -105.2057);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
    [self.mapView setRegion:region animated:YES];
}


@end
