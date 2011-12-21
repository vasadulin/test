//
//  ASD_Soft_ViewController.m
//  MyBooblePooper
//
//  Created by iPhone on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ASD_Soft_ViewController.h"
#import "CGameManager.h"

@implementation ASD_Soft_ViewController

@synthesize tickTimer;
@synthesize gameOverTimer;

@synthesize btnStart;
@synthesize btnStop;
@synthesize _manager;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //инициализация менеджера игры
    _manager  =[[CGameManager alloc] initWithViewController: self];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"black_background.png"]];
    self.tickTimer = nil;
    self.gameOverTimer = nil;
    
}

- (IBAction)startTimer 
{
    if (self.tickTimer == nil)
    {
        self.tickTimer = [NSTimer scheduledTimerWithTimeInterval:0.02f 
                                                    target:_manager 
                                                  selector:@selector(tick) 
                                                  userInfo:nil 
                                                   repeats:YES];
        
        self.gameOverTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f 
                                                              target:_manager 
                                                            selector:@selector(gameOverTick) 
                                                            userInfo:nil 
                                                             repeats:YES];
    }
}

- (IBAction)stopTimer 
{
    if ([self.tickTimer isValid]) 
    {
        [self.tickTimer invalidate];
        self.tickTimer = nil;
        
        [self.gameOverTimer invalidate];
        self.gameOverTimer = nil;
    }
}

//- (void)tick 
//{
//    NSLog(@"Time tick");
//    
//    CGRect r = btnStart.frame;
//    r.origin.x +=0.01;
//    btnStart.frame = r;
//    
//    CGPoint c = btnStart.center;
//    c.y +=0.03;
//    btnStart.center = c;
//    
//   }

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;//(interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

//прикосновение к ViewController
- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{
	
	// Retrieve the touch point
	CGPoint pt = [[touches anyObject] locationInView:self.view];
    [_manager penaltyWasPressed:pt];
	//startLocation = pt;
	//[[self superview] bringSubviewToFront:self];
	
}

//перемещаем шары в новую область экрана
-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                         duration:(NSTimeInterval)duration
{
    //перемещаем шары в новую область экрана 
    [_manager ChangeOrientationAreaTo:toInterfaceOrientation];
    
}



@end
