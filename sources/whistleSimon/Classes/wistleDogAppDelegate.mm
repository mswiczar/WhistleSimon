//
//  wistleDogAppDelegate.m
//  wistleDog
//
//  Created by Moises Swiczar on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "wistleDogAppDelegate.h"
#import "MSWhistleMain.h"
#import "Score.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Recorder.h"


@implementation wistleDogAppDelegate

@synthesize window;
@synthesize is_ipod,is_simulator;
@synthesize database;


#pragma mark -
#pragma mark Application lifecycle








static __inline__ int SSRandomIntBetween(int a, int b)
{
    int range = b - a < 0 ? b - a - 1 : b - a + 1;
    int value = (int)(range * ((float) rand() / (float) RAND_MAX));
    return value == range ? a : a + value;
}

-(void) startEngine
{
	AVAudioSession *mySession = [AVAudioSession sharedInstance];
	NSError *audioSessionError = nil;
	[mySession setCategory: AVAudioSessionCategoryPlayAndRecord
					 error: &audioSessionError];
	startRecording();

}

- (void)createEditableCopyOfDatabaseIfNeeded 
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"scores.sql"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    _firsttime=YES;
	if (success)
	{
		_firsttime = NO;
		return;
	}
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"scores.sql"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) 
	{
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}


- (void)initializeDatabase
{
    // The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"scores.sql"];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) 
	{
	} 
	else 
	{
		// Even though the open failed, call close to properly clean up resources.
		sqlite3_close(database);
		NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
		// Additional error handling, as appropriate...
	}
}


-(void)startdatabase
{
	[self createEditableCopyOfDatabaseIfNeeded];
	[self initializeDatabase];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
	[wistleDogAppDelegate clickSoundEffectBad];
	
	window.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
	srand(time(NULL));
	[self startdatabase];

	[[GANTracker sharedTracker] startTrackerWithAccountID:TRAKERGOOGLE
										   dispatchPeriod:5
												 delegate:nil];
	is_ipod =(([[[UIDevice currentDevice]model]isEqualToString:@"iPod touch"]) || ([[[UIDevice currentDevice]model]isEqualToString:@"iPad"]));
	is_simulator = ([[[UIDevice currentDevice]model]isEqualToString:@"iPhone Simulator"] || [[[UIDevice currentDevice]model]isEqualToString:@"iPad Simulator"]);
	[self trackpage:@"/StartApp"];
	
	
    // Override point for customization after application launch.
	
	NSString *xib_name = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"MSWhistleMain-iPad":@"MSWhistleMain";

	
	MSWhistleMain * themain =[[MSWhistleMain alloc] initWithNibName:xib_name bundle:nil];

	thenavigationMain = [[UINavigationController alloc] initWithRootViewController:themain];
	thenavigationMain.navigationBarHidden=YES;
	[themain release];
    [self.window addSubview:thenavigationMain.view];
    [self.window makeKeyAndVisible];
	[self startEngine];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	[[GANTracker sharedTracker]stopTracker ];

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	stopRecording();

    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	[[GANTracker sharedTracker] startTrackerWithAccountID:TRAKERGOOGLE
										   dispatchPeriod:5
												 delegate:nil];
	
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	startRecording();

    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
	[Score finalizeStatements];
	sqlite3_close(database);
	stopRecording();

}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [thenavigationMain release];
	[window release];
    [super dealloc];
}

-(void) trackpage:(NSString*) thestr
{
	
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:thestr
										 withError:&error]) 
	{
		// Handle error here
		// NSLog(@"Error");
		
	}
}


+ (void) clickSoundEffect
{
	
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",@"blip_click"] ofType:@"aif"];
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
	
	AVAudioPlayer *audioPlayer;
	NSError* theerror;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&theerror] ;
	[audioPlayer play];
	[fileURL release];
	
}	


+ (void) clickSoundGameOver
{
	
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",@"lose"] ofType:@"caf"];
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
	
	AVAudioPlayer *audioPlayer;
	NSError* theerror;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&theerror] ;
	[audioPlayer play];
	[fileURL release];
	
}	






+ (void) clickSoundEffectBad
{
	
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",@"wrong"] ofType:@"mp3"];
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
	
	AVAudioPlayer *audioPlayer;
	NSError* theerror;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&theerror] ;
	[audioPlayer play];
	[fileURL release];
	
	
}	

+ (void) clickSoundEffectOK
{
	
	NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",@"right"] ofType:@"mp3"];
	NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
	
	AVAudioPlayer *audioPlayer;
	NSError* theerror;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&theerror] ;
	[audioPlayer play];
	
	[fileURL release];
	
}

@end
