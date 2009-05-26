//
//  MMLocation.h
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MMLocation : NSObject<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

+ (MMLocation *)instance;

- (void)start;
- (void)stop;
- (BOOL)locationKnown;

@property(nonatomic, retain) CLLocation *currentLocation;

@end
