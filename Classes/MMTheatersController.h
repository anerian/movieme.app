//
//  MMTheatersController.h
//  MovieMe
//
//  Created by min on 5/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTheater.h"


@interface MMTheatersController : UITableViewController<TTURLRequestDelegate> {
@private
  NSArray *theaters_;
}

@end
