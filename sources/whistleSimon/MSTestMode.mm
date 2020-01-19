//
//  MSTestMode.m
//  WhistleSimon
//
//  Created by Moises Swiczar on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MSTestMode.h"
#import "wistleDogAppDelegate.h"
#import "Recorder.h"

@implementation MSTestMode



- (void)viewDidAppear:(BOOL)animated
{
	[UIApplication sharedApplication].idleTimerDisabled = YES;

	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	[appDelegate trackpage:@"TestMode"];
	
};

-(void) timercall:(id)aobj
{
	while (1) 
	{
	 if (is_active)
		{
			if (presing==NO)
			{
				int valor = silvo();
				if (valor!=0)
				{
					presing=YES;
					switch (valor) 
					{
					case 1:
						[self performSelectorOnMainThread:@selector(clicGo1:) withObject:nil waitUntilDone:YES];  
						break;
					case 2:
						[self performSelectorOnMainThread:@selector(clicGo2:) withObject:nil waitUntilDone:YES];  
						break;
					case 3:
						[self performSelectorOnMainThread:@selector(clicGo3:) withObject:nil waitUntilDone:YES];  
						break;
					case 4:
						[self performSelectorOnMainThread:@selector(clicGo4:) withObject:nil waitUntilDone:YES];  
						break;
					}
				}
			}
		}
		[NSThread sleepForTimeInterval:.3f]; 
	}
}


- (void)viewWillAppear:(BOOL)animated
{
	is_active=YES;
	[UIApplication sharedApplication].idleTimerDisabled = NO;
	
}

- (void)viewWillDisappear:(BOOL)animated
{
	is_active=NO;
}



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
	button1.alpha=.3;
	button2.alpha=.3;
	button3.alpha=.3;
	button4.alpha=.3;
	theThread = [[NSThread alloc] initWithTarget:self selector:@selector(timercall:) object:self];
	[theThread start];

	
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

-(IBAction) clicGo1:(id)aobj
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.30];
	button1.alpha=1;
	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];			
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.30];
	[UIView setAnimationDelay:0.30 ];	
	button1.alpha=.3;
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop3:finished:context:)];

	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];		
	
	
}


-(IBAction) clicGo2:(id)aobj
{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.30];
	button2.alpha=1;
	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];			
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.30];
	[UIView setAnimationDelay:0.30 ];	
	button2.alpha=.3;
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop3:finished:context:)];

	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];		
	
	
}
-(IBAction) clicGo3:(id)aobj
{
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.30];
	button3.alpha=1;
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];			
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.30];
	[UIView setAnimationDelay:0.30 ];	
	button3.alpha=.3;
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop3:finished:context:)];

	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];		
	
	
}
-(IBAction) clicGo4:(id)aobj
{

	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.30];
	button4.alpha=1;
	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];			
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.30];
	[UIView setAnimationDelay:0.30 ];	
	button4.alpha=.3;
	
	
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop3:finished:context:)];

	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];		
	
	
}



-(void)theAnimationDidStop3:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	
	
	presing=NO;
	resetsilvo();

}





@end
