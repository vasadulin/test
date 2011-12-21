//
//  ASD_Soft_ViewController.h
//  MyBooblePooper
//
//  Created by iPhone on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGameManager.h"

//Class CGameManager;

@interface ASD_Soft_ViewController : UIViewController <UIActionSheetDelegate >	// for UIActionSheet

@property (nonatomic, retain) NSTimer *tickTimer;
@property (nonatomic, retain) NSTimer *gameOverTimer;

@property (nonatomic, retain) IBOutlet UIButton * btnStart;  
@property (nonatomic, retain) IBOutlet UIButton * btnStop; 

@property (nonatomic, retain) CGameManager * _manager;

//Методы
//- (void) tick;
- (IBAction)startTimer;
- (IBAction)stopTimer;

//передвигаем кнопки управления и очки в допустимый Rect
-(void) moveControlsToCurrentRectArea;


@end
