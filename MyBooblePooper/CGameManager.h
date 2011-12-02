//
//  CGameManager.h
//  MyBooblePooper
//
//  Created by iPhone on 25.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CGameManager : NSObject

@property (retain, nonatomic) NSMutableArray * _balls;
@property (retain, nonatomic) UIViewController* _mainViewController;

//Методы

-(id) initWithViewController: (UIViewController*) vc;
-(void) tick;
-(IBAction) ballWasPressed:(id)selector;
-(void) deleteBallByTag: (NSInteger)buttonTag;

@end
