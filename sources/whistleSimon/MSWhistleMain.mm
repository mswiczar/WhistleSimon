//
//  MSWhistleMain.m
//  wistleDog
//
//  Created by Moises Swiczar on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MSWhistleMain.h"
#import "wistleDogAppDelegate.h"


@implementation MSWhistleMain


-(void) nextScreen
{
	[wistleDogAppDelegate clickSoundEffect];
	
	
	[UIView beginAnimations:@"1" context:NULL];
	[UIView setAnimationDuration:0.15];
	theimageDoYou.alpha=0;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];
	
	
	[UIView beginAnimations:@"2" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:0.15];	
	button_About.alpha=0;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"3" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:0.40];	
	button_HighScores2.alpha=0;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"4" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:.65];	
	button_GameMode.alpha=0;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];
	
	
	[UIView beginAnimations:@"6" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:0.90];	
	button_TestMode.alpha=0;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"6" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:1.15];	
	theimageTitle.alpha=0;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];
	
	
	
	[UIView beginAnimations:@"7" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:1.4];	
	button_info.alpha=0;
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop:finished:context:)];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];	
	
}






// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
 
		 
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	self.view.alpha=1;
}

- (void)viewDidAppear:(BOOL)animated
{
	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate trackpage:@"Main"];
	

	button_info.alpha=0;;
	theimageTitle.alpha=0;
	button_TestMode.alpha=0;;
	button_GameMode.alpha=0;;
	button_HighScores2.alpha=0;;
	button_About.alpha=0;;
	theimageDoYou.alpha=0;
	
	
	
	[UIView beginAnimations:@"1" context:NULL];
	[UIView setAnimationDuration:0.15];
	button_info.alpha=1;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];

	
	[UIView beginAnimations:@"2" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:0.15];	
	theimageTitle.alpha=1;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	[UIView commitAnimations];

	[UIView beginAnimations:@"3" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:0.40];	
	button_TestMode.alpha=1;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	[UIView commitAnimations];

	[UIView beginAnimations:@"4" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:.65];	
	button_GameMode.alpha=1;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	[UIView commitAnimations];

	
	[UIView beginAnimations:@"6" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:0.90];	
	button_HighScores2.alpha=1;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	[UIView commitAnimations];
	
	[UIView beginAnimations:@"6" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:1.15];	
	button_About.alpha=1;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	[UIView commitAnimations];

	[UIView beginAnimations:@"7" context:NULL];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationDelay:1.4];	
	theimageDoYou.alpha=1;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	[UIView commitAnimations];
	
	
	
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	button_info.alpha=0;;
	theimageTitle.alpha=0;
	button_TestMode.alpha=0;;
	button_GameMode.alpha=0;;
	button_HighScores2.alpha=0;;
	button_About.alpha=0;;
	theimageDoYou.alpha=0;
	
	
 }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {	
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation ==  UIInterfaceOrientationPortraitUpsideDown));
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    

	if (theHelp!=nil)
	{
		[theHelp release];
		theHelp=nil;
	}

	if (theTestMode!=nil)
	{
		[theTestMode release];
		theTestMode=nil;
	}

	
	if (theGameMode!=nil)
	{
		[theGameMode release];
		theGameMode=nil;
	}
	
	
	if (theHighScore!=nil)
	{
		[theHighScore release];
		theHighScore=nil;
	}

	if (theAbout!=nil)
	{
		[theAbout release];
		theAbout=nil;
	}
	
	
	
	[super didReceiveMemoryWarning];
    
	
	
	
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {

    [super dealloc];
}


-(IBAction) clickHelp:(id) aobj
{
	
	screentogo=1;
	[self nextScreen];

	
	
	

	
	
}





-(IBAction) clickTestMode:(id) aobj
{
	screentogo=2;
	[self nextScreen];

	
}

-(IBAction) clickGameMode:(id) aobj
{
	screentogo=3;
	[self nextScreen];

	
}


-(IBAction) clickHighScores:(id) aobj
{
	
	screentogo=4;
	[self nextScreen];
}




-(IBAction) clickAbout:(id) aobj;
{
	screentogo=5;
	[self nextScreen];
	
	
	
	
	
}


-(void)theAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	
	switch (screentogo) {
		case 1:
			if (theHelp==nil)
			{
				NSString *xib_name = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"MSHelp-iPad":@"MSHelp";

				theHelp = [[MSHelp alloc] initWithNibName:xib_name bundle:nil];
			}
			[self.navigationController pushViewController:theHelp animated:NO];
			
			break;
		case 2:
			
			if (theTestMode==nil)
			{
				NSString *xib_name = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"MSTestMode-iPad":@"MSTestMode";
				
				theTestMode = [[MSTestMode alloc] initWithNibName:xib_name bundle:nil];
			}
			[self.navigationController pushViewController:theTestMode animated:NO];
			
			break;
		case 3:
			if (theGameMode==nil)
			{
				NSString *xib_name = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"MSGameMode-iPad":@"MSGameMode";
				
				theGameMode = [[MSGameMode alloc] initWithNibName:xib_name bundle:nil];
			}
			theGameMode.isNewGame=YES;
			[self.navigationController pushViewController:theGameMode animated:NO];
			
			break;
		case 4:
			if (theHighScore==nil)
			{
				NSString *xib_name = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"MSHighScores-iPad":@"MSHighScores";
				
				theHighScore = [[MSHighScores alloc] initWithNibName:xib_name bundle:nil];
			}
			[self.navigationController pushViewController:theHighScore animated:NO];
			
			break;
		case 5:
			if (theAbout==nil)
			{
				NSString *xib_name = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"MSAbout-iPad":@"MSAbout";
				theAbout = [[MSAbout alloc] initWithNibName:xib_name bundle:nil];
			}
			[self.navigationController pushViewController:theAbout animated:NO];
			
			break;

			
	}
	
	

}





@end

