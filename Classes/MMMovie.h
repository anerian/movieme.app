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
  NSString *imageUrl_;
  NSString *thumbUrl_;  
  
}

@end
