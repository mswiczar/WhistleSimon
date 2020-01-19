//
//  MSHighScoreInput.h
//  WhistleSimon
//
//  Created by Moises Swiczar on 12/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MSHighScoreInput : UIViewController {

	IBOutlet UITextField * theText;
	
	IBOutlet UILabel * theLabelScore;
	NSInteger thelevel;
	
	
}

@property (nonatomic) NSInteger thelevel;


-(void) show;

@end
