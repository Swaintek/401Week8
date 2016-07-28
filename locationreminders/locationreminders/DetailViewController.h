//
//  DetailViewController.h
//  locationreminders
//
//  Created by David Swaintek on 7/26/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MapKit;

typedef void(^DetailViewControllerCompletion)(MKCircle *circle);

@interface DetailViewController : UIViewController

@property(strong, nonatomic)NSString *annotationTitle;
@property(nonatomic)CLLocationCoordinate2D coordinate;

@property(copy, nonatomic)DetailViewControllerCompletion completion;

@end
