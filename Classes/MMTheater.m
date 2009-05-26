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
latitude = latitude_, longitude = longitude_, distance = distance_;

- (id)initWithDictionary:(NSDictionary *)dictionary {
  if (self = [super initWithDictionary:dictionary]) {
    shows_ = [[dictionary objectForKey:@"shows"] copy];
  }
  return self;
}

- (NSString *)address {
  return [NSString stringWithFormat:@"%@\n%@, %@. %@", street_, city_, state_, zip_];
}

- (NSArray *)shows {
  return shows_;
}

- (NSString *)description {
  return [self address];
}

- (NSString *)tableName {
  return @"theaters";
}

- (void)dealloc {
  [name_ release];
  [street_ release];
  [city_ release];
  [state_ release];
  [zip_ release];
  [phone_ release];
  [latitude_ release];
  [longitude_ release];
  [distance_ release];
  [shows_ release];
  [super dealloc];
}

@end
