//
//  Score.h
//  EvO
//
//  Created by macmini on 06/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface Score : NSObject {
	sqlite3 * database;
	NSInteger puntos;
	NSInteger level;
	NSString*  nombre;
}
@property (nonatomic,copy) 	NSString*  nombre;
@property (nonatomic) NSInteger puntos;
@property (nonatomic) NSInteger level;

@property (nonatomic) sqlite3 * database;

+(NSInteger)getMinScore;
+(void)gethigh:(NSMutableArray*)aarray;
-(void)insert;
- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db;
+ (void)finalizeStatements;


@end
