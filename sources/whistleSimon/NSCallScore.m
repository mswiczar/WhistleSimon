//
//  NSCallScore.m
//  EvO
//
//  Created by macmini on 19/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "NSCallScore.h"
#import "XMLReaderScore.h"

@implementation NSCallScore


/*
 to get scores use http://66.197.85.68/evo/evoscores.php
 
 to put scores use http://66.197.85.68/evo/evoscores.php?name=chuck&score=10&level=8
 */

+(BOOL)callSetScore:(NSInteger)level points:(NSInteger)points nombre:(NSString*)nombre
{
	NSString *mystringURL = [NSString stringWithFormat:@"http://66.197.85.68/evo/evoscores.php?name=%@&score=%d&level=%d",nombre,points,level];
	NSString *mystringURLok = [mystringURL stringByAddingPercentEscapesUsingEncoding:NSStringEncodingConversionAllowLossy];

	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setTimeoutInterval:5]; 
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[request setURL:[NSURL URLWithString:mystringURLok]];
	[request setHTTPMethod:@"GET"];
	NSURLResponse *response;
	NSError *error=nil;
	NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

	if ( (d) && (error.code == 0))
	{
		return YES;
	}	
	else
	{
		return NO;
	}
	
}

+(BOOL)callGetscore:(NSMutableArray*)aaray;
{
	BOOL salida;
	NSString *mystringURL = [NSString stringWithFormat:@"http://66.197.85.68/evo/evoscores.php"];
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setTimeoutInterval:5]; 
	[request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	[request setURL:[NSURL URLWithString:mystringURL]];
	[request setHTTPMethod:@"GET"];
	NSURLResponse *response;
	NSError *error=nil;
	NSData *d = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	if ( (d) && (error.code == 0))
	{
		NSString *myResponse = [ [NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
		XMLReaderScore *ret = [[XMLReaderScore alloc] init];
		[aaray removeAllObjects];
		ret.contenedor  = aaray;
		if ([ret parseXML:myResponse ]==1)
		{
			salida= YES;
		}
		else
		{
			salida= NO;
		}
		[myResponse release];
		[ret release];
	}	
	else
	{
		salida= NO;
	}
	return salida;
}


	

@end
