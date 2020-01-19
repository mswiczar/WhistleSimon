//
//  MSHighScores.m
//  WhistleSimon
//
//  Created by Moises Swiczar on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MSHighScores.h"
#import "wistleDogAppDelegate.h"
#import "Score.h"


@implementation MSHighScores



- (void)viewDidAppear:(BOOL)animated
{
	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate trackpage:@"HighScores"];
	
};

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		thearray = [[NSMutableArray alloc] initWithCapacity:10];
        // Custom initialization.
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{
	[thearray removeAllObjects];
	[Score gethigh:thearray];

	
	
	labelName1.text = 	((Score *)[thearray objectAtIndex:0]).nombre;
	labelLevel1.text = [NSString stringWithFormat:@"%d",	((Score *)[thearray objectAtIndex:0]).level];

	labelName2.text = 	((Score *)[thearray objectAtIndex:1]).nombre;
	labelLevel2.text = 	 [NSString stringWithFormat:@"%d",	((Score *)[thearray objectAtIndex:1]).level];

	labelName3.text = 	((Score *)[thearray objectAtIndex:2]).nombre;
	labelLevel3.text =  [NSString stringWithFormat:@"%d",	((Score *)[thearray objectAtIndex:2]).level];

	labelName4.text = 	((Score *)[thearray objectAtIndex:3]).nombre;
	labelLevel4.text = 	 [NSString stringWithFormat:@"%d",	((Score *)[thearray objectAtIndex:3]).level];

	labelName5.text = 	((Score *)[thearray objectAtIndex:4]).nombre;
	labelLevel5.text =  [NSString stringWithFormat:@"%d",	((Score *)[thearray objectAtIndex:4]).level];

	labelName6.text = 	((Score *)[thearray objectAtIndex:5]).nombre;
	labelLevel6.text =  [NSString stringWithFormat:@"%d",	((Score *)[thearray objectAtIndex:5]).level];

	labelName7.text = 	((Score *)[thearray objectAtIndex:6]).nombre;
	labelLevel7.text = 	 [NSString stringWithFormat:@"%d",	((Score *)[thearray objectAtIndex:6]).level];

	labelName8.text = 	((Score *)[thearray objectAtIndex:7]).nombre;
	labelLevel8.text = 	 [NSString stringWithFormat:@"%d",	((Score *)[thearray objectAtIndex:7]).level];

	labelName9.text = 	((Score *)[thearray objectAtIndex:8]).nombre;
	labelLevel9.text = 	 [NSString stringWithFormat:@"%d",	((Score *)[thearray objectAtIndex:8]).level];
	
	labelName10.text = 	((Score *)[thearray objectAtIndex:9]).nombre;
	labelLevel10.text =  [NSString stringWithFormat:@"%d",	((Score *)[thearray objectAtIndex:9]).level];

	
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {	
    return ((interfaceOrientation == UIInterfaceOrientationPortrait) || (interfaceOrientation ==  UIInterfaceOrientationPortraitUpsideDown));
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
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

-(IBAction) clickDone:(id)aobj
{
	[wistleDogAppDelegate clickSoundEffect];

	[self.navigationController popViewControllerAnimated:NO];
	
}




@end
