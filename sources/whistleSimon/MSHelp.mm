//
//  MSHelp.m
//  WhistleSimon
//
//  Created by Moises Swiczar on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MSHelp.h"
#import "wistleDogAppDelegate.h"


@implementation MSHelp

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (void)viewDidAppear:(BOOL)animated
{
	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate trackpage:@"Help"];
	
};


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
