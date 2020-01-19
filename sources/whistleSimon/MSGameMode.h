//
//  MSGameMode.h
//  WhistleSimon
//
//  Created by Moises Swiczar on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSHighScoreInput.h"

@interface MSGameMode : UIViewController {
	
	IBOutlet UIButton * buttonDone;
	IBOutlet UIButton * buttonReplay;

	
	IBOutlet UIImageView * IWGameOver;
	
	IBOutlet UIImageView * button1;
	IBOutlet UIImageView * button2;
	IBOutlet UIImageView * button3;
	IBOutlet UIImageView * button4;

	NSMutableArray *arraymovements;
	NSInteger secuencia_actual;
	
	NSInteger secuencia_actualPress;
	BOOL showTime;
	NSInteger nivel;
	IBOutlet UIImageView * theimage;
	
	
	BOOL presing;
	NSThread * theThread;
	BOOL is_active;
	
	
	IBOutlet UILabel * label_Level;
	IBOutlet UILabel * label_Lives;
	
	NSUInteger  theLives;
	
	
	BOOL game_over;
	NSTimer* thetimer ;
	MSHighScoreInput *theInputScore;
	
	BOOL isNewGame;
	
}




-(IBAction) clickDone:(id)aobj;

-(IBAction) click1:(id)aobj;
-(IBAction) click2:(id)aobj;
-(IBAction) click3:(id)aobj;
-(IBAction) click4:(id)aobj;

-(IBAction) clickStart:(id)aobj;

-(void) playSecuencia;
-(void) newGame;


@property BOOL isNewGame;

@end



