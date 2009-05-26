//
//  MMTheatersController.m
//  MovieMe
//
//  Created by min on 5/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MMTheatersController.h"
#import "MMTheaterController.h"
#import "MMLocation.h"
#import "MMTheaterCell.h"


@implementation MMTheatersController

- (id)init {
  if (self = [super init]) {
    theaters_ = nil;
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [[MMLocation instance] start];
  


  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(locationUpdated:) 
                                               name:@"location:updated" 
                                             object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
                                                
  [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                  name:@"location:updated" 
                                                object:nil];
}

- (void)locationUpdated:(NSNotification*)notify {    
  NSLog(@"location updated");
  CLLocationCoordinate2D coordinate = [MMLocation instance].currentLocation.coordinate;
  
  NSString *url = [NSString stringWithFormat:@"http://moviemeapp.com/theaters.json?lat=%f&lng=%f", 38.906786, -77.041787];
  NSLog(url);
  TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
  request.response = [[[TTURLDataResponse alloc] init] autorelease];
  [request send];
}

- (void)loadView {
  [super loadView];
  self.tableView.rowHeight = 80;
}

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

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  MMTheater *theater = [theaters_ objectAtIndex:indexPath.row];
    
  static NSString *CellIdentifier = @"MMTheaterCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[MMTheaterCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
  [(MMTheaterCell *)cell update:theater];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  MMTheater *theater = [theaters_ objectAtIndex:indexPath.row];
  
  MMTheaterController *theaterController = [[[MMTheaterController alloc] initWithTheater:theater] autorelease];
  
  [self.navigationController pushViewController:theaterController animated:YES];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (!theaters_) return 0;
  
	return [theaters_ count];
}

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
  NSString *jsonString = [[[NSString alloc] initWithData:response.data encoding:NSUTF8StringEncoding] autorelease];
  id json = [jsonString JSONValue];

  NSArray *movies = [MMMovie parseJSON:[json objectForKey:@"movies"]];
  [MMMovie saveAll:movies];
  
  theaters_ = [[MMTheater parseJSON:[json objectForKey:@"theaters"]] retain];
  [self.tableView reloadData];
  
  NSLog(@"requestDidFinishLoad: %@", theaters_);
}


@end