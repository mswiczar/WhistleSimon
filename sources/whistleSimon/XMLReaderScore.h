//
//  XMLReaderCategories.h
//  iPhoneList
//
//  Created by macmini on 01/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Score.h"
#import <sqlite3.h>
    
@interface XMLReaderScore: NSObject {
	
@private
	sqlite3         *database;
	NSDateFormatter *dateFormatter;
    Score			*curCategory;
    NSMutableString *contentOfCurrentNoticia;
	NSMutableArray  *contenedor;
}

@property (nonatomic, retain) Score       *curCategory;
@property (nonatomic, retain) NSMutableString *contentOfCurrentNoticia;
@property (nonatomic, assign) NSMutableArray  *contenedor;

- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;
- (NSInteger)parseXML: (NSString *)data;

@end
