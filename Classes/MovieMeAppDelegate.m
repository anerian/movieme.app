//
//  MovieMeAppDelegate.m
//  MovieMe
//
//  Created by min on 5/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "MovieMeAppDelegate.h"
#import "MMTheatersController.h"
#import "MMMoviesController.h"
#import "MMUpcomingController.h"
#import "MMBoxOfficeController.h"
#import "MMFavoritesController.h"


@implementation MovieMeAppDelegate

@synthesize window = window_;

- (UINavigationController *)createNavItem:(UIViewController *)viewController withName:(NSString *)name {
  viewController.title = name;
  viewController.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"tab%@.png", name]];
    
  UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];
    
  [viewController release];
    
  return navigationController;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  NSLog(@"applicationDidFinishLaunching");
	NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:5];

  tabBarController_ = [[UITabBarController alloc] init];

  [viewControllers addObject:[self createNavItem:[[MMTheatersController alloc] init] withName:@"Theaters"]];
  [viewControllers addObject:[self createNavItem:[[MMMoviesController alloc] init] withName:@"Movies"]];
  [viewControllers addObject:[self createNavItem:[[MMFavoritesController alloc] init] withName:@"Favorites"]];
  [viewControllers addObject:[self createNavItem:[[MMBoxOfficeController alloc] init] withName:@"Box Office"]];

  tabBarController_.viewControllers = viewControllers;

  [window_ addSubview:tabBarController_.view];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
    [tabBarController_ release];
    [window_ release];
    [super dealloc];
}

@end

