//
//  CGUIBall.h
//  MyBooblePooper
//
//  Created by iPhone on 25.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CBall.h"
#import "CGameManager.h"

@interface CGUIBall : CBall

@property (retain, nonatomic) UIButton * _button;
@property (retain, nonatomic) UIViewController * _mainViewController;

//Методы
//-(id) initWithViewController: (UIViewController*)vc  
                 //gameManager:(CGameManager*) gm
//;
-(id) initWithViewController: (UIViewController*)vc  
                 gameManager:(CGameManager*) gm
               availableArea:(CGRect*)rectArea
;
-(id) initWithViewController: (UIViewController*)vc  
                 gameManager:(CGameManager*) gm
                      center:(CGPoint)point 
                      radius:(CGFloat)radius
               availableArea:(CGRect*)rectArea;

-(void) tick;

-(IBAction) ballWasPressed:(id)selector;

-(NSInteger) getTag;

@end
