//
//  XMLReaderCategories.m
//  iPhoneList
//
//  Created by macmini on 01/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "XMLReaderScore.h"
#import "wistleDogAppDelegate.h"


@implementation XMLReaderScore
@synthesize curCategory;
@synthesize contentOfCurrentNoticia;
@synthesize contenedor;


//

/*
 <xml>
 <entry>
 <cdCategoryId>1</cdCategoryId>
 <cdCategoryName>Category 1</cdCategoryName>
 <cdCategoryDescription>Desc Category 1</cdCategoryDescription>
 </entry>
 </xml>
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	//    parsedEarthquakesCounter = 0;
}


- (void)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error
{	
	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	database = appDelegate.database;
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	self.curCategory = nil;
	
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    [parser setDelegate:self];
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
    }
    
    [parser release];
}

- (NSInteger)parseXML: (NSString *)data;
{	
	
	
	BOOL salida;
	salida = YES;
	self.curCategory = nil;
	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	database = appDelegate.database;
	
	dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	
	NSData *d = [ data dataUsingEncoding:NSUTF8StringEncoding];
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:d];
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [parser setDelegate:self];
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    [parser parse];
    
    NSError *parseError = [parser parserError];
    if (parseError)  {
		salida = -100;
    }
	else
	{
		salida=1;
	}
	[parser release];
	return salida;
	
}


/*
 <entry><name>binugeorge</name><score>10</score><level>5</level><Date>2008-12-10</Date></entry>
 */

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	
    if ([elementName isEqualToString:@"entry"]) 
	{
        self.curCategory = [[Score alloc] init];
		self.contentOfCurrentNoticia = [[NSMutableString alloc] init];
    }
	
	if ([elementName isEqualToString:@"name"]) 
	{
		self.contentOfCurrentNoticia = [[NSMutableString alloc] init];
	}
	
	if ([elementName isEqualToString:@"score"]) 
	{
		self.contentOfCurrentNoticia = [[NSMutableString alloc] init];
    }
	
	if ([elementName isEqualToString:@"level"]) 
	{
		self.contentOfCurrentNoticia = [[NSMutableString alloc] init];
    }
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{   
    if (qName) {
        elementName = qName;
    }
    
    if ([elementName isEqualToString:@"entry"]) 
	{
		if (self.curCategory!=nil)
		{
			[self.contenedor addObject:self.curCategory];
		}
	}	
	
	if ([elementName isEqualToString:@"name"]) {
		curCategory.nombre= contentOfCurrentNoticia;
        [self.contentOfCurrentNoticia release];
    }
	
	
    if ([elementName isEqualToString:@"score"]) {
		curCategory.puntos= [contentOfCurrentNoticia integerValue];
        [self.contentOfCurrentNoticia release];
    }

    if ([elementName isEqualToString:@"level"]) {
		curCategory.level = [contentOfCurrentNoticia integerValue];
        [self.contentOfCurrentNoticia release];
    }
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [self.contentOfCurrentNoticia appendString:string];
}

@end
