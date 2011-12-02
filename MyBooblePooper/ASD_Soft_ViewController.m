//
//  ASD_Soft_ViewController.m
//  MyBooblePooper
//
//  Created by iPhone on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ASD_Soft_ViewController.h"

@implementation ASD_Soft_ViewController

@synthesize myTimer;
@synthesize btnStart;
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
    
}

- (IBAction)startTimer {
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:0.02f 
                                                    target:_manager 
                                                  selector:@selector(tick) 
                                                  userInfo:nil 
                                                   repeats:YES];
}

- (IBAction)stopTimer {
    if ([myTimer isValid]) {
        [myTimer invalidate];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
