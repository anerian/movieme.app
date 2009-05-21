//
//  MovieMeAppDelegate.h
//  MovieMe
//
//  Created by min on 5/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieMeAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window_;
    UITabBarController *tabBarController_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end
