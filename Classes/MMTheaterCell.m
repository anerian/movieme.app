//
//  MMTheaterCell.m
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MMTheaterCell.h"

@interface MMTheaterCell(Private)

- (UILabel *)labelForFrame:(CGRect)frame withText:(NSString *)text withFontSize:(double)fontSize;

@end

@implementation MMTheaterCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)identifier {
  if (self = [super initWithFrame:frame reuseIdentifier:identifier]) {
    self.backgroundColor = [UIColor clearColor];
    
    name_ = [[self labelForFrame:CGRectMake(70, 10, 250, 20) withText:@"" withFontSize:14] retain];
    name_.textColor = HexToUIColor(0x25190c);
    
    address_ = [[self labelForFrame:CGRectMake(70, 30, 250, 40) withText:@"" withFontSize:14] retain];
    address_.font = [UIFont systemFontOfSize:14];
    address_.numberOfLines = 2;
    
    [self.contentView addSubview:name_];
    [self.contentView addSubview:address_];
  }
  return self;
}

- (void)update:(MMTheater *)theater {
  name_.text = theater.name;
  address_.text = [theater address];
}

- (UILabel *)labelForFrame:(CGRect)frame withText:(NSString *)text withFontSize:(double)fontSize {
  UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
  
  label.text = text;
	label.font = [UIFont boldSystemFontOfSize:fontSize];
  label.backgroundColor = [UIColor clearColor];
  label.shadowOffset = CGSizeMake(0,1);
  label.shadowColor = [UIColor whiteColor];
  label.textColor = [UIColor blackColor];
  return label;
}

- (void)dealloc {
  [name_ release];
  [address_ release];
  [super dealloc];
}

@end
