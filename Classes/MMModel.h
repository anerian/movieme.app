//
//  MMModel.h
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FMDatabase.h"


@protocol MMModel

- (id)initWithDictionary:(NSDictionary *)dictionary;

@optional

- (id)initWithFMResultSet:(FMResultSet *)resultSet;

@end

@interface MMModel : NSObject {
  int pk_;
}

@property (nonatomic, assign) int pk;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithFMResultSet:(FMResultSet *)resultSet;

// Connections
+ (FMDatabase *)connection;
+ (void)establishConnection;

// Conversions
+ (id)parseJSON:(id)json;
+ (id)fromDB:(FMResultSet *)result;

// Query helpers
+ (id)query:(NSString *)sql;
- (id)query:(NSString *)sql;

- (void)persist;

- (void)save;
+ (void)saveAll:(NSArray *)models;
+ (id)find:(int)pk;

// Accessors
+ (NSString *)tableName;
+ (NSDictionary *)properties;
+ (NSArray *)columns;

@end
