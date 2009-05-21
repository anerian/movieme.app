//
//  MMTheatersController.m
//  MovieMe
//
//  Created by min on 5/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MMTheatersController.h"


@implementation MMTheatersController

- (id)init {
  if (self = [super init]) {

  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  TTURLRequest* request = [TTURLRequest requestWithURL:@"http://localhost:3000/theaters.json?postal_code=20036" delegate:self];
  request.response = [[[TTURLDataResponse alloc] init] autorelease];
  [request send];
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

- (void)requestDidFinishLoad:(TTURLRequest*)request {
  TTURLDataResponse *response = (TTURLDataResponse *)request.response;
  NSString *json = [[[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding] autorelease];
  
  id theaters = [json JSONValue];
  
  NSLog(@"requestDidFinishLoad: %@", theaters);
}


@end