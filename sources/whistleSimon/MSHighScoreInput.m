//
//  MSHighScoreInput.m
//  WhistleSimon
//
//  Created by Moises Swiczar on 12/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MSHighScoreInput.h"
#import "wistleDogAppDelegate.h"
#import "Score.h"

@implementation MSHighScoreInput

@synthesize thelevel;



- (void)viewDidAppear:(BOOL)animated
{
	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate trackpage:@"HighScoreInput"];
	
};

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[theText becomeFirstResponder];
	theText.text = @"";
	theLabelScore.text =@"0";
	theLabelScore.text =[NSString stringWithFormat:@"%d",thelevel];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

	
	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	NSString *nombre=@"No Name :(";
	
	if (![textField.text isEqualToString:@""])
	{
		nombre = textField.text ;
	}
	Score * thescore = [[Score alloc] init];
	thescore.database = appDelegate.database;
	
	thescore.level=thelevel;
	thescore.nombre = nombre;
	[thescore insert];
	
	[self dismissModalViewControllerAnimated:YES];

	return YES;

}


-(void) show
{
	theText.text = @"";
	theLabelScore.text =[NSString stringWithFormat:@"%d",thelevel];
	[theText becomeFirstResponder];

}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


@end
