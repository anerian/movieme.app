//
//  MMModel.m
//  MovieMe
//
//  Created by min on 5/26/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#if (! TARGET_OS_IPHONE)
#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif

#import "MMModel.h"
#import "FMResultSet.h"

static FMDatabase *database_ = nil;
static NSMutableDictionary *properties_ = nil;
static NSMutableDictionary *columns_ = nil;

@implementation MMModel

@synthesize pk = pk_;

- (id)initWithDictionary:(NSDictionary *)dictionary {
	if (self = [super init]) {
    NSDictionary *properties = [[self class] properties];
        
    NSMutableArray *attrs = [NSMutableArray arrayWithArray:[[[self class] properties] allKeys]];
    [attrs sortUsingSelector:@selector(caseInsensitiveCompare:)];
        
    NSArray *keys = [properties allKeys];
        
    if ([dictionary objectForKey:@"id"]) {
      self.pk = [[dictionary objectForKey:@"id"] intValue];
    }
      
    for (id attr in keys) {
      NSString *attrType = [properties objectForKey:attr];
      id value = [dictionary objectForKey:[attr ak_snakecase]];
 
      if ([attrType isEqual:@"@\"NSString\""]) {
        [self setValue:MMNullable(value) forKey:attr];
      } else if ([attrType isEqual:@"i"] || [attrType isEqual:@"I"] || [attrType isEqual:@"f"]) {
        if (value && value != [NSNull null]) [self setValue:value forKey:attr];
      }
    }
	}
	
	return self;
}

- (id)initWithFMResultSet:(FMResultSet *)resultSet {
  if (self = [super init]) {
    NSDictionary *properties = [[self class] properties];
    NSArray *keys = [properties allKeys];
        
    for (id attr in keys) {
      NSString *attrType = [properties objectForKey:attr];
      NSString *attrName = [attr ak_snakecase];
            
      if ([attrName isEqual:@"pk"]) {
        self.pk = [resultSet intForColumn:@"id"];
      } else if ([attrType isEqual:@"@\"NSString\""]) {
        [self setValue:[resultSet stringForColumn:attrName] forKey:attr];
      } else if ([attrType isEqual:@"@\"NSDate\""]) {
        [self setValue:[resultSet dateForColumn:attrName] forKey:attr];
      } else if ([attrType isEqual:@"i"] || [attrType isEqual:@"I"]) {
        [self setValue:[NSNumber numberWithInt:[resultSet intForColumn:attrName]] forKey:attr];
      } else if ([attrType isEqual:@"f"]) {
        [self setValue:[NSNumber numberWithDouble:[resultSet doubleForColumn:attrName]] forKey:attr];
      }
    }
	}
	
	return self;
}

+ (void)establishConnection {
  if (database_ == nil) {
    NSString *databaseName = @"movieme.db";

    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath:databasePath]) {
      NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
      [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
      [fileManager release];
    }

    database_ = [[FMDatabase alloc] initWithPath:[[documentPaths objectAtIndex:0] stringByAppendingPathComponent:databaseName]];
    [database_ open];
    [database_ setCrashOnErrors:NO];
  }
}

+ (id)query:(NSString *)sql {
    return [self fromDB:[[MMModel connection] executeQuery:sql]];
}

- (id)query:(NSString *)sql {
    return [[self class] query:sql];
}

- (void)persist {
  NSArray *columns = [[self class] columns];
  NSArray *properties = [[[self class] properties] allKeys];
    
  NSMutableArray *keys = [NSMutableArray arrayWithCapacity:0];
  NSMutableArray *values = [NSMutableArray arrayWithCapacity:0];
  NSMutableArray *placeHolders = [NSMutableArray arrayWithCapacity:0];
    
  for (NSString *column in columns) {        
    NSString *attr = [column ak_camelcase];
        
    if ([attr isEqual:@"id"]) attr = @"pk";
        
    if ([properties containsObject:attr]) {
      [keys addObject:column];
      [placeHolders addObject:@"?"];
      id value = [self valueForKey:attr];
            
      if (value) {
        [values addObject:[self valueForKey:attr]];
      } else {
        [values addObject:[NSNull null]];
      }
    }
  }
    
  NSString *sql = [NSString stringWithFormat:@"insert or replace into %@ (%@) values (%@)", 
    [[self class] tableName], 
    [keys componentsJoinedByString:@","], 
    [placeHolders componentsJoinedByString:@","]
  ];
    
  [[[self class] connection] executeUpdate:sql withArgumentsInArray:values];
}

+ (FMDatabase *)connection {
    return database_;
}

+ (id)parseJSON:(id)json {
	if ([json isKindOfClass:[NSArray class]]) {
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:0];
    for (id object in json) {
      [results addObject:[[self class] parseJSON:object]];
    }
    return results;
	}
	return [[[[self class] alloc] initWithDictionary:json] autorelease];
}

+ (id)fromDB:(FMResultSet *)result {
  NSMutableArray *results = [NSMutableArray arrayWithCapacity:0];
    
  while ([result next]) [results addObject:[[[[self class] alloc] initWithFMResultSet:result] autorelease]];
    
  [result close];
    
  if ([results count] == 1) return [results lastObject];
    
  return results;
}

+ (void)saveAll:(NSArray *)models {
  [[MMModel connection] beginTransaction];
    
  for (id model in models) [model persist];
    
  [[MMModel connection] commit];
}

- (void)save {
  [[MMModel connection] beginTransaction];
    
  [self persist];
    
  [[MMModel connection] commit];
}

+ (NSArray *)all {
  return [self query:[NSString stringWithFormat:@"select * from %@;", [self tableName]]];
}

+ (void)deleteAll {
  [self query:[NSString stringWithFormat:@"delete from %@;", [self tableName]]];
}

+ (id)find:(int)pk {
  id result = [self query:[NSString stringWithFormat:@"select * from %@ where id = %d limit 1;", [self tableName], pk]];
    
  if ([result isKindOfClass:[NSArray class]]) {
    return ([result count] > 0) ? [result lastObject] : nil;
  }
    
  return result;
}

+ (NSString *)tableName {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

+ (NSArray *)columns {
  if (columns_ == nil) columns_ = [[NSMutableDictionary alloc] initWithCapacity:0];
    
  NSMutableArray *cols = [columns_ objectForKey:[self class]];
    
  if (cols == nil) {
    cols = [NSMutableArray arrayWithCapacity:0];
                
    FMResultSet * result = [[MMModel connection] executeQuery:[NSString stringWithFormat:@"PRAGMA table_info(%@)", [self tableName]]];
        
    while ([result next]) {
      [cols addObject:[result stringForColumnIndex:1]];
    }
    [result close];
        
    [columns_ setObject:cols forKey:[self class]];
  }
    
  return cols;
}

+ (NSDictionary *)properties {
  if (properties_ == nil) properties_ = [[NSMutableDictionary alloc] initWithCapacity:0];
    
  NSMutableDictionary *props = [properties_ objectForKey:[self class]];
    
  if (props == nil) {
    if ([self superclass] != [NSObject class]) {
      props = [NSMutableDictionary dictionaryWithDictionary:[[self superclass] properties]];
    } else {
      props = [NSMutableDictionary dictionaryWithCapacity:0];
    }
            
    unsigned int count;

    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    	
    for (int i = 0; i < count; i++) {
      objc_property_t p = propertyList[i];
    		
      NSArray *parts = [[NSString stringWithCString:property_getAttributes(p)] componentsSeparatedByString:@","];
    		
      if (parts != nil && [parts count] > 0) {
        [props setObject:[[parts objectAtIndex:0] substringFromIndex:1] forKey:[NSString stringWithCString:property_getName(p)]];
      }
    }	
    free(propertyList);
    	
    [properties_ setObject:props forKey:[self class]];
  }
  return props;
}

@end