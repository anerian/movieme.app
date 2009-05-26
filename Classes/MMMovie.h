//
//  MMMovie.h
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MMModel.h"


@interface MMMovie : MMModel<MMModel> {
  
@private
  NSString *title_;
  NSString *rating_;
  NSString *description_;
  NSString *image_;
  NSString *thumb_;  
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *rating;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *thumb;

@end
