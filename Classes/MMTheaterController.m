//
//  MMTheaterController.m
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MMTheaterController.h"


@implementation MMTheaterController

- (id)initWithTheater:(MMTheater *)theater {
  if (self = [super init]) {
    theater_ = [theater retain];
    
    NSArray *shows_ = [theater shows];
    NSMutableArray *movieIds = [NSMutableArray arrayWithCapacity:[shows_ count]];
    for (NSDictionary *show in shows_) {
      [movieIds addObject:[show objectForKey:@"movie_id"]];
    }
    NSArray *movies = [MMMovie query:[NSString stringWithFormat:@"select * from movies where id in (%@)", [movieIds componentsJoinedByString:@","]]];
    
    movies_ = [[[NSMutableArray alloc] initWithCapacity:[shows_ count]] retain];
    for (int i = 0; i < [shows_ count]; i++) {
      NSDictionary *show = [shows_ objectAtIndex:i];
      [movies_ addObject:
        [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[movies objectAtIndex:i], [show objectForKey:@"times"], nil]
                                    forKeys:[NSArray arrayWithObjects:@"movie", @"times", nil]]
      ];
    }
    
    NSLog(@"movies_ %@", movies_);
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
