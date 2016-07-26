//
//  ViewController.m
//  locationreminders
//
//  Created by David Swaintek on 7/25/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

#import "ViewController.h"

#import "LocationController.h"
#import "DetailViewController.h"
#import <Parse/Parse.h>

@import MapKit;

@interface ViewController ()<MKMapViewDelegate, LocationControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)firstLocationButton:(id)sender;
- (IBAction)secondLocationButton:(id)sender;
- (IBAction)thirdLocationButton:(id)sender;

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender;

- (IBAction)setPerimeter:(id)sender;

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
    
    [self.mapView.layer setCornerRadius:20.0];
    [self.mapView setDelegate:self];
    [self.mapView setShowsUserLocation:YES];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];
    
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

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        CGPoint touchPoint = [sender locationInView:self.mapView];
        CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        
        newPoint.coordinate = touchMapCoordinate;
        
        newPoint.title = @"New Location";
        
        [self.mapView addAnnotation:newPoint];
    }
}

- (IBAction)setPerimeter:(id)sender {
    
    double perimeterDistance = 0.001;
    
    CLLocation *userLocation = [[LocationController sharedController]location];
    
    CLLocation *northLocation = [[CLLocation alloc]initWithLatitude:(userLocation.coordinate.latitude + perimeterDistance) longitude:userLocation.coordinate.longitude];
    
    CLLocationCoordinate2D coordinate = userLocation.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
    [self.mapView setRegion:region animated:YES];
    
    MKPointAnnotation *north = [[MKPointAnnotation alloc]init];
    north.coordinate = northLocation.coordinate;
    north.title = @"N";
    
    CLLocation *southLocation = [[CLLocation alloc]initWithLatitude:(userLocation.coordinate.latitude - perimeterDistance) longitude:userLocation.coordinate.longitude];
    
    MKPointAnnotation *south = [[MKPointAnnotation alloc]init];
    south.coordinate = southLocation.coordinate;
    south.title = @"S";
    
    CLLocation *eastLocation = [[CLLocation alloc]initWithLatitude:userLocation.coordinate.latitude longitude:(userLocation.coordinate.longitude + perimeterDistance)];
    
    MKPointAnnotation *east = [[MKPointAnnotation alloc]init];
    east.coordinate = eastLocation.coordinate;
    east.title = @"E";
    
    CLLocation *westLocation = [[CLLocation alloc]initWithLatitude:userLocation.coordinate.latitude longitude:(userLocation.coordinate.longitude - perimeterDistance)];
    
    MKPointAnnotation *west = [[MKPointAnnotation alloc]init];
    west.coordinate = westLocation.coordinate;
    west.title = @"W";
    
    CLLocation *northEastLocation = [[CLLocation alloc]initWithLatitude:(userLocation.coordinate.latitude + perimeterDistance/2) longitude:(userLocation.coordinate.longitude + perimeterDistance/2)];
    
    MKPointAnnotation *northEast = [[MKPointAnnotation alloc]init];
    northEast.coordinate = northEastLocation.coordinate;
    northEast.title = @"NE";
    
    CLLocation *northWestLocation = [[CLLocation alloc]initWithLatitude:(userLocation.coordinate.latitude + perimeterDistance/2) longitude:(userLocation.coordinate.longitude - perimeterDistance/2)];
    
    MKPointAnnotation *northWest = [[MKPointAnnotation alloc]init];
    northWest.coordinate = northWestLocation.coordinate;
    northWest.title = @"NW";
    
    CLLocation *southEastLocation = [[CLLocation alloc]initWithLatitude:(userLocation.coordinate.latitude - perimeterDistance/2) longitude:(userLocation.coordinate.longitude + perimeterDistance/2)];
    
    MKPointAnnotation *southEast = [[MKPointAnnotation alloc]init];
    southEast.coordinate = southEastLocation.coordinate;
    southEast.title = @"SE";
    
    CLLocation *southWestLocation = [[CLLocation alloc]initWithLatitude:(userLocation.coordinate.latitude - perimeterDistance/2) longitude:(userLocation.coordinate.longitude - perimeterDistance/2)];
    
    MKPointAnnotation *southWest = [[MKPointAnnotation alloc]init];
    southWest.coordinate = southWestLocation.coordinate;
    southWest.title = @"SW";


    [self.mapView addAnnotations:@[north,south,east,west,northEast,northWest,southEast,southWest]];
//    [self.mapView addAnnotation:south];
//    [self.mapView addAnnotation:east];
//    [self.mapView addAnnotation:west];
//    [self.mapView addAnnotation:northEast];
//    [self.mapView addAnnotation:northWest];
//    [self.mapView addAnnotation:southEast];
//    [self.mapView addAnnotation:southWest];
    
    
}

-(void)locationControllerDidUpdateLocation:(CLLocation *)location{
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.0) animated:YES];
}

#pragma mark - MapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]) {return nil; }
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    if(!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    }
    
    annotationView.canShowCallout = YES;
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    
    annotationView.pinTintColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    UIButton *rightCalloutButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    annotationView.rightCalloutAccessoryView = rightCalloutButton;
    
    return annotationView;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"DetailViewController"]){
        if([sender isKindOfClass:[MKAnnotationView class]]){
            
            MKAnnotationView *annotationView = (MKAnnotationView *)sender;
            
            DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
            
            detailViewController.annotationTitle = annotationView.annotation.title;
            
            detailViewController.coordinate = annotationView.annotation.coordinate;
        }
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    [self performSegueWithIdentifier:@"DetailViewController" sender:view];
    
}

























@end
