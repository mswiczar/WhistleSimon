//
//  MSGameMode.m
//  WhistleSimon
//
//  Created by Moises Swiczar on 12/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MSGameMode.h"
#import "wistleDogAppDelegate.h"
#import "Movida.h"
#import "Recorder.h"
#import "Score.h"

#define PI_OVER_2 1.57079632679489662f

@implementation MSGameMode
@synthesize isNewGame;




-(void) timercall:(id)aobj
{
	while (1) 
	{
		if(game_over==YES)
		{
			[NSThread sleepForTimeInterval:.6f]; 
			continue;
		}
		if (is_active)
		{
			if (presing==NO)
			{
				if (showTime==NO)
				{
					int valor = silvo();
					if (valor!=0)
					{
						presing=YES;
						switch (valor) 
						{
							case 1:
								[self performSelectorOnMainThread:@selector(click1:) withObject:nil waitUntilDone:YES];  
								break;
							case 2:
								[self performSelectorOnMainThread:@selector(click2:) withObject:nil waitUntilDone:YES];  
								break;
							case 3:
								[self performSelectorOnMainThread:@selector(click3:) withObject:nil waitUntilDone:YES];  
								break;
							case 4:
								[self performSelectorOnMainThread:@selector(click4:) withObject:nil waitUntilDone:YES];  
								break;
						}
					}
				}
				else 
				{
					resetsilvo();
				}

			}
		}
		[NSThread sleepForTimeInterval:.3f]; 
	}
}


- (void)viewWillAppear:(BOOL)animated
{
	if (isNewGame)
	{
		[self newGame];
		label_Level.text =@"";
		label_Lives.text =@"";
		game_over=YES;
		is_active=YES;
		IWGameOver.alpha=0;
		buttonReplay.alpha=0;
	}

}

- (void)viewWillDisappear:(BOOL)animated
{
	[UIApplication sharedApplication].idleTimerDisabled = NO;
	is_active=NO;
}

- (void)viewDidAppear:(BOOL)animated
{
	[UIApplication sharedApplication].idleTimerDisabled = YES;

	wistleDogAppDelegate *appDelegate = (wistleDogAppDelegate *)[[UIApplication sharedApplication] delegate];
	[appDelegate trackpage:@"GameMode"];
	
	if (isNewGame)
	{

		thetimer = [NSTimer scheduledTimerWithTimeInterval:	1		// seconds
												target:		self
											  selector:	@selector (theStart:)
											  userInfo:	self		
											   repeats:	NO];
	}		
	
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		arraymovements = [[NSMutableArray alloc] initWithCapacity:100];
		showTime=NO;
		isNewGame=YES;
		

    }
    return self;
}


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


-(IBAction) click1:(id)aobj
{
	if (showTime)
	{
		return;
	}
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

	[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop4:finished:context:)];

	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];		
	
	
	NSInteger actualmove=0;
	NSLog(@"Click %d, secuencia %d, nivel %d", actualmove,secuencia_actualPress ,nivel);
	
	Movida *amov = [arraymovements objectAtIndex:secuencia_actualPress];
	if (amov.tipo == actualmove)
	{
		if (nivel==secuencia_actualPress)
		{
			showTime=YES;
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.70];
			theimage.alpha=.9;
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView commitAnimations];	

			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.70];
			[UIView setAnimationDelay:0.70 ];	
			theimage.alpha=1;
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop2:finished:context:)];
			
			[UIView commitAnimations];		
		}
		else 
		{
			secuencia_actualPress++;
		}

		
	}
	else 
	{
		showTime=YES;

		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.70];
		theimage.alpha=.9;
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView commitAnimations];	
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.70];
		[UIView setAnimationDelay:0.70 ];	
		theimage.alpha=1;
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop3:finished:context:)];
		
		[UIView commitAnimations];		
		[wistleDogAppDelegate clickSoundEffectBad];		
		
	}
	
	

}
-(IBAction) click2:(id)aobj
{
	if (showTime)
	{
		return;
	}

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

	[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop4:finished:context:)];
	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];		
	

	NSInteger actualmove=1;
	NSLog(@"Click %d, secuencia %d, nivel %d", actualmove,secuencia_actualPress ,nivel);

	Movida *amov = [arraymovements objectAtIndex:secuencia_actualPress];
	if (amov.tipo == actualmove)
	{
		if (nivel==secuencia_actualPress)
		{
			showTime=YES;

			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.70];
			theimage.alpha=.9;
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView commitAnimations];	
			
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.70];
			[UIView setAnimationDelay:0.70 ];	
			theimage.alpha=1;
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop2:finished:context:)];
			
			[UIView commitAnimations];		
			
		}
		else 
		{
			secuencia_actualPress++;
		}
		
		
	}
	else 
	{
		showTime=YES;

		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.70];
		theimage.alpha=.9;
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView commitAnimations];	
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.70];
		[UIView setAnimationDelay:0.70 ];	
		theimage.alpha=1;
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop3:finished:context:)];
		
		[UIView commitAnimations];		
		[wistleDogAppDelegate clickSoundEffectBad];		
		
	}
	
	
	
	

}

-(IBAction) click3:(id)aobj
{
	if (showTime)
	{
		return;
	}

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

	[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop4:finished:context:)];
	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];		
	
	NSInteger actualmove=2;
	NSLog(@"Click %d, secuencia %d, nivel %d", actualmove,secuencia_actualPress ,nivel);
	
	Movida *amov = [arraymovements objectAtIndex:secuencia_actualPress];
	if (amov.tipo == actualmove)
	{
		if (nivel==secuencia_actualPress)
		{
			showTime=YES;

			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.70];
			theimage.alpha=.9;
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView commitAnimations];	
			
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.70];
			[UIView setAnimationDelay:0.70 ];	
			theimage.alpha=1;
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop2:finished:context:)];
			
			[UIView commitAnimations];		
			
		}
		else 
		{
			secuencia_actualPress++;
		}
		
		
	}
	else 
	{
		showTime=YES;

		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.70];
		theimage.alpha=.9;
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView commitAnimations];	
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.70];
		[UIView setAnimationDelay:0.70 ];	
		theimage.alpha=1;
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop3:finished:context:)];
		
		[UIView commitAnimations];	
		[wistleDogAppDelegate clickSoundEffectBad];		

	}
	
	

}

-(IBAction) click4:(id)aobj
{
	if (showTime)
	{
		return;
	}

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
	
	[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop4:finished:context:)];
	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView commitAnimations];		
	
	
	NSInteger actualmove=3;
	NSLog(@"Click %d, secuencia %d, nivel %d", actualmove,secuencia_actualPress ,nivel);
	
	Movida *amov = [arraymovements objectAtIndex:secuencia_actualPress];
	if (amov.tipo == actualmove)
	{
		if (nivel==secuencia_actualPress)
		{
			showTime=YES;

			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:.70];
			theimage.alpha=.9;
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView commitAnimations];	
			
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDuration:0.70];
			[UIView setAnimationDelay:0.70 ];	
			theimage.alpha=1;
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop2:finished:context:)];
			
			[UIView commitAnimations];		
			
		}
		else 
		{
			secuencia_actualPress++;
		}
		
		
	}
	else 
	{
		showTime=YES;

		//error
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:.70];
		theimage.alpha=.9;
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView commitAnimations];	
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.70];
		[UIView setAnimationDelay:0.70 ];	
		theimage.alpha=1;
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop3:finished:context:)];
		
		[UIView commitAnimations];		
		[wistleDogAppDelegate clickSoundEffectBad];		

		
	}
	

}


-(void) play:(NSInteger)theBoton thePosicion:(NSInteger)thePosicion
{
	NSString * strAnim=[NSString stringWithFormat:@"%d",thePosicion];
	switch (theBoton) 
	{
		case 0:

			
			
			[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:0.30];
				button1.alpha=1;
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView commitAnimations];			

			
			
			[UIView beginAnimations:strAnim context:NULL];
			[UIView setAnimationDuration:0.30];
				[UIView setAnimationDelay:0.30 ];	
				button1.alpha=.3;
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				[UIView setAnimationDelegate:self];
				[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop:finished:context:)];
			
			[UIView commitAnimations];		
			NSLog(@"posicion %d , boton %d", thePosicion, theBoton );

			
			break;

		case 1:
			[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:0.30];
				button2.alpha=1;
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView commitAnimations];			

			[UIView beginAnimations:strAnim context:NULL];
				[UIView setAnimationDuration:0.30];
				[UIView setAnimationDelay:0.30 ];	
				button2.alpha=.3;
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				[UIView setAnimationDelegate:self];
				[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop:finished:context:)];
			
			[UIView commitAnimations];		
			NSLog(@"posicion %d , boton %d", thePosicion, theBoton );

			
			break;
		case 2:
			
			
			
			[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:0.30];
				button3.alpha=1;
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView commitAnimations];	

			
			[UIView beginAnimations:strAnim context:NULL];
				[UIView setAnimationDuration:0.30];
				[UIView setAnimationDelay:0.30 ];	
				button3.alpha=.3;
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				[UIView setAnimationDelegate:self];
				[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop:finished:context:)];
			[UIView commitAnimations];			
			NSLog(@"posicion %d , boton %d", thePosicion, theBoton );

			break;
		case 3:
			
			
			
			[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:0.30];
				button4.alpha=1;
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView commitAnimations];		

			
			[UIView beginAnimations:strAnim context:NULL];
				[UIView setAnimationDuration:0.30];
				[UIView setAnimationDelay:0.30 ];	
				button4.alpha=.3;
				[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
				[UIView setAnimationDelegate:self];
				[UIView setAnimationDidStopSelector:@selector(theAnimationDidStop:finished:context:)];
			
			[UIView commitAnimations];			
			NSLog(@"posicion %d , boton %d", thePosicion, theBoton );

			break;

		default:
			break;
	}
	
}


-(void)theAnimationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{

	if (secuencia_actual<nivel)
	{
		secuencia_actual++;
		Movida *amov = [arraymovements objectAtIndex:secuencia_actual];
		[self play:amov.tipo thePosicion:secuencia_actual];
	}
	else 
	{
		showTime=NO;	
	}

	
}



-(void)theAnimationDidStop2:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	nivel++;
	NSLog (@"Comienza Secuencia %d",nivel);
	[self playSecuencia];
	
}


-(void)theAnimationDidStop3:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	theLives--;
	label_Lives.text =[NSString stringWithFormat:@"%d",theLives];
	if (theLives==0)
	{
		
		[wistleDogAppDelegate clickSoundGameOver];
		NSInteger thescore =  [Score getMinScore];
		isNewGame=NO;
		
		if (thescore < (nivel+1))
		{
			if (theInputScore==nil)
			{
				NSString *xib_name = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?@"MSHighScoreInput-iPad":@"MSHighScoreInput";
	
				theInputScore = [[MSHighScoreInput alloc] initWithNibName:xib_name bundle:nil];
			}
			theInputScore.thelevel = (nivel+1);
			[theInputScore show];
			[self.navigationController presentModalViewController:theInputScore animated:YES];
		}
		
		game_over=YES;
		showTime=NO;
		IWGameOver.alpha=1;
		buttonReplay.alpha=1;


		return;
	}

	NSLog(@"Error Secuencia %d",nivel);
	NSLog (@"Comienza Secuencia %d NUEVAMENTE",nivel);
	[self playSecuencia];
	
}



-(void)theAnimationDidStop4:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	
	
	presing=NO;
	resetsilvo();
	
}



-(void) playSecuencia
{
	if(game_over==NO)
	{
		label_Level.text =[NSString stringWithFormat:@"%d",nivel+1];
	
		button1.alpha=.3;
		button2.alpha=.3;
		button3.alpha=.3;
		button4.alpha=.3;
		secuencia_actual=0;
		secuencia_actualPress=0;

		Movida *amov = [arraymovements objectAtIndex:secuencia_actual];
		[self play:amov.tipo thePosicion:secuencia_actual];
	}
	

}

-(void) newGame
{
	srand ( time(NULL) );
	[arraymovements removeAllObjects];
	for (NSInteger  i = 0 ; i<100 ; i++)
	{
		Movida*  amovida  = [[ Movida alloc] init];
		amovida.numero = i;
		NSInteger aint =(rand() % 	4);
		amovida.tipo =  aint;
		[arraymovements addObject:amovida];
		[amovida release];
	}	
	nivel=0;
	secuencia_actualPress=0;

	
	

}


-(void) theStart:(id) aobj
{
	presing=NO;
	resetsilvo();
	
	IWGameOver.alpha=0;
	buttonReplay.alpha=0;
	
	if (showTime)
	{
		return;
	}
	showTime=YES;
	
	[self newGame];
	nivel=0;
	secuencia_actual=0;
	secuencia_actualPress=0;
	theLives=3;
	game_over=NO;
	label_Level.text =[NSString stringWithFormat:@"%d",nivel+1];
	label_Lives.text =[NSString stringWithFormat:@"%d",theLives];
	
	[self playSecuencia];
}


-(IBAction) clickStart:(id)aobj
{
	IWGameOver.alpha=0;
	buttonReplay.alpha=0;
	game_over=YES;
	isNewGame=YES;
	is_active=YES;
	thetimer = [NSTimer scheduledTimerWithTimeInterval:	1		// seconds
												target:		self
											  selector:	@selector (theStart:)
											  userInfo:	self		
											   repeats:	NO];
	
}







@end
