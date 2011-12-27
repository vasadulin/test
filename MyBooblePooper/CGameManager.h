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
@property (retain, nonatomic) UILabel * _labelScores;
@property (retain, nonatomic) UILabel * _labelGameOver;
@property (retain, nonatomic) UIButton * _btnPenalti;
@property (retain, nonatomic) NSString* _currentNick;
@property (retain, nonatomic) NSArray * _imagesForBall;

@property (nonatomic) NSInteger _scores;
@property (nonatomic) NSInteger _secondLeftToGameover;
@property (nonatomic) CGRect _rectArea;

    



//Методы

-(id) initWithViewController: (UIViewController*) vc;
-(void) tick;
-(void) gameOverTick;
-(void) gameOverHandler;
-(IBAction) ballWasPressed:(id)selector;
-(IBAction) penaltyWasPressed:(CGPoint) point;
-(void) deleteBallByTag: (NSInteger)buttonTag;
-(void) addPointsToSumScore: (NSInteger)points;
-(void) showScores;
//меняет ориентацию игрового поля на toInterfaceOrientation
-(void) ChangeOrientationAreaTo:(UIInterfaceOrientation)toInterfaceOrientation;

//открывает дополнительное окно ввода
//возвращает введенную строку
-(NSString*) enterNewNick;

//показать топ игроков
-(void)showTableScore;



@end
