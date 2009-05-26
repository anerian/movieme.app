//
//  MMMovie.m
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MMMovie.h"


@implementation MMMovie

@synthesize title = title_, rating = rating_, description = description_, image = image_, 
thumb = thumb_;

+ (NSString *)tableName {
  return @"movies";
}

- (NSString *)description {
  return title_;
}

- (void)dealloc {
  [title_ release];
  [rating_ release];
  [description_ release];
  [image_ release];
  [thumb_ release];
  [super dealloc];
}

@end
