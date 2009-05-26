//
//  MMTheaterController.h
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTheater.h"
#import "MMMovie.h"


@interface MMTheaterController : UIViewController {
  MMTheater *theater_;
  NSMutableArray *movies_;
}

- (id)initWithTheater:(MMTheater *)theater;

@end
