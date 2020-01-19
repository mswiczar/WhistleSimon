//
//  MSWhistleMain.h
//  wistleDog
//
//  Created by Moises Swiczar on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MSHelp.h"
#import "MSTestMode.h"
#import "MSGameMode.h"
#import "MSHighScores.h"
#import "MSAbout.h"



@interface MSWhistleMain : UIViewController {
	IBOutlet UIImageView *theimageBG;

	
	IBOutlet UIImageView *theimageDoYou;
	IBOutlet UIImageView *theimageTitle;

	
	IBOutlet UIButton    *button_info;
	IBOutlet UIButton    *button_TestMode;
	IBOutlet UIButton    *button_GameMode;
	IBOutlet UIButton    *button_HighScores2;
	IBOutlet UIButton    *button_About;
	
	
	MSHelp       * theHelp;
	MSTestMode   * theTestMode;
	MSGameMode   * theGameMode;
	MSHighScores * theHighScore;
	MSAbout      * theAbout;
	
	
	NSInteger screentogo;
	
	
}

-(IBAction) clickHelp:(id) aobj;

-(IBAction) clickTestMode:(id) aobj;
-(IBAction) clickGameMode:(id) aobj;
-(IBAction) clickHighScores:(id) aobj;
-(IBAction) clickAbout:(id) aobj;



@end
