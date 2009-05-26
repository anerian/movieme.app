//
//  CMTheater.h
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MMModel.h"


@interface MMTheater : MMModel<MMModel> {

@private
  NSString *name_;
  NSString *street_;
  NSString *city_;
  NSString *state_;
  NSString *zip_;
  NSString *phone_;
  
  NSNumber *latitude_;
  NSNumber *longitude_;
  NSNumber *distance_;
  
  NSArray *shows_;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *street;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *phone;

@property (nonatomic, retain) NSNumber *latitude;
@property (nonatomic, retain) NSNumber *longitude;
@property (nonatomic, retain) NSNumber *distance;

- (NSString *)address;
- (NSArray *)shows;

@end