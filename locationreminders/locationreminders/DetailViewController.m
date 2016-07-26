//
//  DetailViewController.m
//  locationreminders
//
//  Created by David Swaintek on 7/26/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"TITLE: %@", self.annotationTitle);
    NSLog(@"COORDINATE: %f, %f", self.coordinate.latitude, self.coordinate.longitude);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
