//
//  MSTestMode.h
//  WhistleSimon
//
//  Created by Moises Swiczar on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MSTestMode : UIViewController {

	IBOutlet UIButton * buttonDone;
	
	IBOutlet UIImageView * button1;
	IBOutlet UIImageView * button2;
	IBOutlet UIImageView * button3;
	IBOutlet UIImageView * button4;
	
	IBOutlet UIImageView * theimage;

	BOOL presing;
	NSThread * theThread;
	BOOL is_active;
	
	
	
}

-(IBAction) clickDone:(id)aobj;


-(IBAction) clicGo1:(id)aobj;
-(IBAction) clicGo2:(id)aobj;
-(IBAction) clicGo3:(id)aobj;
-(IBAction) clicGo4:(id)aobj;


@end
