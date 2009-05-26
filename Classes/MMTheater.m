//
//  CMTheater.m
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MMTheater.h"


@implementation MMTheater

@synthesize name = name_, street = street_, city = city_, state = state_, zip = zip_, phone = phone_, 
coordinate = coordinate_, distance = distance_;

- (NSString *)address {
  return [NSString stringWithFormat:@"%@\n%@, %@. %@", street_, city_, state_, zip_];
}

- (NSString *)description {
  return [self address];
}

- (void)dealloc {
  [name_ release];
  [street_ release];
  [city_ release];
  [state_ release];
  [zip_ release];
  [phone_ release];
  [super dealloc];
}

@end
