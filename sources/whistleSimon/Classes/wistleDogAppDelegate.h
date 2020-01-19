//
//  wistleDogAppDelegate.h
//  wistleDog
//
//  Created by Moises Swiczar on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GANTracker.h"
#import <sqlite3.h>


#define TRAKERGOOGLE @"UA-27926216-1"

@interface wistleDogAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	sqlite3 * database;

	UINavigationController * thenavigationMain;
	BOOL is_simulator;
	BOOL is_ipod;
	BOOL _firsttime;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic) BOOL is_ipod;
@property (nonatomic) BOOL is_simulator;
@property (nonatomic) sqlite3 * database;

-(void) trackpage:(NSString*) thestr;



+ (void) clickSoundEffect;
+ (void) clickSoundEffectBad;
+ (void) clickSoundEffectOK;
+ (void) clickSoundGameOver;


@end

