//
//  MSHighScores.h
//  WhistleSimon
//
//  Created by Moises Swiczar on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MSHighScores : UIViewController {
	IBOutlet UIButton * buttonDone;
	
	IBOutlet UILabel * labelName1;
	IBOutlet UILabel * labelName2;
	IBOutlet UILabel * labelName3;
	IBOutlet UILabel * labelName4;
	IBOutlet UILabel * labelName5;
	IBOutlet UILabel * labelName6;
	IBOutlet UILabel * labelName7;
	IBOutlet UILabel * labelName8;
	IBOutlet UILabel * labelName9;
	IBOutlet UILabel * labelName10;
	
	
	
	IBOutlet UILabel * labelLevel1;
	IBOutlet UILabel * labelLevel2;
	IBOutlet UILabel * labelLevel3;
	IBOutlet UILabel * labelLevel4;
	IBOutlet UILabel * labelLevel5;
	IBOutlet UILabel * labelLevel6;
	IBOutlet UILabel * labelLevel7;
	IBOutlet UILabel * labelLevel8;
	IBOutlet UILabel * labelLevel9;
	IBOutlet UILabel * labelLevel10;

	NSMutableArray *thearray;

}

-(IBAction) clickDone:(id)aobj;

@end
