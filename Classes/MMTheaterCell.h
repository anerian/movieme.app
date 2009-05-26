//
//  MMTheaterCell.h
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MMTheater.h"


@interface MMTheaterCell : UITableViewCell {
  UILabel *name_;
  UILabel *address_;
  UILabel *distance_;
}

- (void)update:(MMTheater *)theater;

@end
