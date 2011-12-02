//
//  ASD_Soft_ViewController.h
//  MyBooblePooper
//
//  Created by iPhone on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGameManager.h"

@interface ASD_Soft_ViewController : UIViewController

@property (nonatomic, retain) NSTimer *myTimer;

@property (nonatomic, retain) IBOutlet UIButton * btnStart;  

@property (nonatomic, retain) CGameManager * _manager;

//Методы
//- (void) tick;
- (IBAction)startTimer;
- (IBAction)stopTimer;

@end
