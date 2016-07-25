//
//  AppDelegate.m
//  locationreminders
//
//  Created by David Swaintek on 7/25/16.
//  Copyright © 2016 David Swaintek. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration > _Nonnull configuration) {
        
        configuration.applicationId = @"appId";
        configuration.clientKey = @"myMasterKey";
        configuration.server = @"https://ds-locationreminders-server.herokuapp.com/parse";
    }]];
    
    return YES;
}


@end
