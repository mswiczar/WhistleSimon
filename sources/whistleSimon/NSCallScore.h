//
//  NSCallScore.h
//  EvO
//
//  Created by macmini on 19/12/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSCallScore : NSObject {

}
+(BOOL)callSetScore:(NSInteger)level points:(NSInteger)points nombre:(NSString*)nombre;
+(BOOL)callGetscore:(NSMutableArray*)aaray;



@end
