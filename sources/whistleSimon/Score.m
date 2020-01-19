//
//  Score.m
//  EvO
//
//  Created by macmini on 06/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.


#import "Score.h"
#import "wistleDogAppDelegate.h"

static sqlite3_stmt * insert_statement=nil;
static sqlite3_stmt * init_statement=nil;
static sqlite3_stmt * select_statement=nil;


@implementation Score
@synthesize nombre;
@synthesize puntos;
@synthesize level;
@synthesize database;
/*
 CREATE TABLE highscore (id integer primary key autoincrement,  points integer, name varchar(64), nivel integer);

 */
//create table highscore (points integer, name varchar(64));
+ (void)finalizeStatements 
{
    if (init_statement) sqlite3_finalize(init_statement);
    if (insert_statement) sqlite3_finalize(insert_statement);
    if (select_statement) sqlite3_finalize(select_statement);
};


+(NSInteger)getMinScore
{
	
	NSInteger salida = 0;
	NSInteger cantidad=0;
	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	Score * aevent;
	const char *sql = "SELECT id  FROM highscore order by nivel desc";
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(appDelegate.database, sql, -1, &statement, NULL) == SQLITE_OK) 
	{
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			cantidad++;
			int primaryKey = sqlite3_column_int(statement, 0);
			aevent = [[Score alloc] initWithPrimaryKey:primaryKey database:appDelegate.database];
			salida= aevent.level;
			[aevent release];
			if (cantidad==10)
			{
				return salida;

			}
			
		}
		sqlite3_finalize(statement);
    } 
	return 0;
}

+(void)gethigh:(NSMutableArray*)aarray
{
	NSInteger cantidad=0;
	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	Score * aevent;
	const char *sql = "SELECT id  FROM highscore order by nivel desc";
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(appDelegate.database, sql, -1, &statement, NULL) == SQLITE_OK) 
	{
		while (sqlite3_step(statement) == SQLITE_ROW) 
		{
			cantidad++;
			int primaryKey = sqlite3_column_int(statement, 0);
			aevent = [[Score alloc] initWithPrimaryKey:primaryKey database:appDelegate.database];
			[aarray addObject:aevent];
			[aevent release];
		}
		sqlite3_finalize(statement);
    } 
	int total_arrat=[aarray count];
	for (int i= total_arrat; i<10 ;i++)
	{
		aevent = [[Score alloc] init];
		aevent.database = appDelegate.database;
		aevent.nombre = @"----------";
		aevent.puntos = 0;
		[aarray addObject:aevent];
		[aevent release];
	}
	return;
}


- (id)initWithPrimaryKey:(NSInteger)pk database:(sqlite3 *)db {
    if (self = [super init]) {
        database = db;
		char * str;
        if (init_statement == nil) {
            const char *sql = "SELECT name, points,nivel  FROM highscore where id=?";
            if (sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK) {
                NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
            }
        }
		sqlite3_bind_int(init_statement, 1 , pk);

		if (sqlite3_step(init_statement) == SQLITE_ROW) 
		{
			str = (char *)sqlite3_column_text(init_statement, 0);
			self.nombre = (str) ? [NSString stringWithUTF8String:str] : @"";
			self.puntos = sqlite3_column_int(init_statement,1);
			self.level = sqlite3_column_int(init_statement,2);
			
        } else 
		{
			
			self.nombre = @"";
			self.puntos = 0;
			self.level = 0;
		}			
		sqlite3_reset(init_statement);
    }
    return self;
}


-(void)insert;
{
    if (insert_statement == nil) {
		static char *sql = "INSERT INTO highscore (points,name,nivel ) VALUES (?,?,?)";
		
        if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to prepare statement with message '%s'.", sqlite3_errmsg(database));
        }
    }
	sqlite3_bind_int(insert_statement, 1 , self.puntos);
	sqlite3_bind_text(insert_statement, 2 , [self.nombre UTF8String],-1,SQLITE_STATIC );	
	sqlite3_bind_int(insert_statement, 3 , self.level);
	
    sqlite3_step(insert_statement);
    sqlite3_reset(insert_statement);
	return;
}


@end
