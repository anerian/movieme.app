//
//  AKNSString+Utils.m
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AKNSString+Utils.h"


@implementation NSString (AKUtils)

- (NSString *)ak_gsub:(NSString *)pattern withReplacement:(NSString *)replacement {
    return [self stringByReplacingOccurrencesOfRegex:pattern withString:replacement];
}

- (NSString *)ak_camelcase {
    unichar *buffer = calloc([self length], sizeof(unichar));
    [self getCharacters:buffer];
    NSMutableString *underscored = [NSMutableString string];

    BOOL capitalizeNext = NO;
    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"-_"];
    for (int i = 0; i < [self length]; i++) {
        NSString *currChar = [NSString stringWithCharacters:buffer+i length:1];
        if ([delimiters characterIsMember:buffer[i]]) {
            capitalizeNext = YES;
        } else {
            if (capitalizeNext) {
                [underscored appendString:[currChar uppercaseString]];
                capitalizeNext = NO;
            } else {
                [underscored appendString:currChar];
            }
        }
    }
    free(buffer);
    
    return underscored;
}

- (NSString *)ak_snakecase {
    NSString *cased = [[[self ak_gsub:@"([A-Z]+)([A-Z][a-z])" withReplacement:@"$1_$2"] ak_gsub:@"([a-z\\d])([A-Z])" withReplacement:@"$1_$2"] lowercaseString];

    return [cased stringByReplacingOccurrencesOfString:@"-" withString:@"_"];
}

- (NSString *)ak_lchomp:(NSString *)match {
    if (match && [match length] <= [self length] && [[self substringToIndex:[match length]] isEqual:match]) {
        return [self substringFromIndex:1];
    }
    
    return [[self copy] autorelease];
}

@end