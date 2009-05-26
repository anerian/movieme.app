//
//  AKNSString+Utils.h
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RegexKitLite.h"


@interface NSString(AKUtils)

- (NSString *)ak_gsub:(NSString *)pattern withReplacement:(NSString *)replacement;
- (NSString *)ak_camelcase;
- (NSString *)ak_snakecase;
- (NSString *)ak_lchomp:(NSString *)match;

@end
