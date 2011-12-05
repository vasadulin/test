//
//  CGameManager.m
//  MyBooblePooper
//
//  Created by iPhone on 25.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CGameManager.h"
#import "CGUIBall.h"

#import <stdlib.h>
#import <time.h>

#define MAX_COUNT_BALL 10
#define MIN_COUNT_BALL 2

//расстояние которое пролетит UILabel, отображающая очки за убитый шар
#define DISTANCE_POINTS 30
//Время анимации (полета)UILabel, отображающая очки за убитый шар
#define TIME_ANIMATE_POINTS 1.0f

@implementation CGameManager

@synthesize _balls;
@synthesize _mainViewController;

//Методы
//конструктор без параметров
-(id) initWithViewController : (UIViewController*) vc
{
    srandom(time(NULL));
    
    self = [super init];
    if (self != nil) 
    {
        _mainViewController = vc;
        //инициализируем массив шаров  
        _balls = [NSMutableArray arrayWithCapacity:1];
    
//                
//        //добавляем один шар
//        CBall * ball = [[CGUIBall alloc] 
//                        initWithViewController: _mainViewController 
//                        gameManager:self
//                        //center: CGPointMake(80, 80)
//                        //radius: 20.0f
//                        ];
//
//        [_balls addObject:ball];
//        
//        //добавляем один шар
//        ball = [[CGUIBall alloc] 
//                        initWithViewController: _mainViewController 
//                        gameManager:self
//                        //center: CGPointMake(80, 280)
//                        //radius: 25.0f
//                        ];
//        
//        [_balls addObject:ball];
//
        
    }
    return self;
}


-(void) tick    /// --------------TICK-----------
{
    
#if TEST_MODE
    //NSLog(@"CGameManager: Time tick");
#endif
    
    for (NSUInteger i=0; i<_balls.count; i++) 
    {
        CBall * ball = [_balls objectAtIndex:i];
        if(ball)
        {
            [ball tick];
        }
    }
    
    static NSUInteger countTick = 0;
    countTick++;
    if (countTick%30 == 0) 
    {
        //если шарикам есть куда плодиться  
        if (_balls.count < MAX_COUNT_BALL)
        {
            //рождаем новые шары
            int rnd = random()%1000;
            if (rnd<500 || _balls.count < MIN_COUNT_BALL) 
            {
                //добавляем один шар
                CBall * ball = [[CGUIBall alloc] 
                                initWithViewController: _mainViewController 
                                gameManager:self
                                //center: CGPointMake(80, 80)
                                //radius: 20.0f
                                ];
                
                [_balls addObject:ball];
            }
        }
    }
    
}
//-----------------------------------------------
-(void) deleteBallByTag: (NSInteger)buttonTag
{
#if TEST_MODE
    NSLog(@"==CGameManager: deleteBallByTag==");
#endif    
    for (NSUInteger i=0; i<_balls.count; i++) 
    {
        CGUIBall * ball = [_balls objectAtIndex:i];
        if(ball)
        {
            NSInteger curTag= [ball getTag];
            if (curTag == buttonTag) 
            {
                //------------- Всплывающие очки ------------
                //CGRect кнопки
                CGRect rect = [ball._button frame];
                
                //очки за шар
                NSInteger points = [ball points];
                 
                //TODO Добавить красивую анимацию исчезновения кнопки
                //удалаяем кнопку из _balls и из ViewController
                [_balls removeObjectAtIndex:i];
                [ball._button removeFromSuperview];
                ball = nil;
                
                //делаем всплывающие очки
                UILabel * labelPoints = [[UILabel alloc] initWithFrame:rect];
                [labelPoints setText:[[NSString alloc] initWithFormat:@"%d", points]];
                labelPoints.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
                labelPoints.textColor = [UIColor orangeColor];

                
                //add the button to the view
                [_mainViewController.view  addSubview:labelPoints];
                
                
                //--------------- Всплывание очков  (анимация) ------------------
                //изменяем координаты надписи очков
                rect.origin.y -= DISTANCE_POINTS;
                
                [UIView animateWithDuration:TIME_ANIMATE_POINTS
                    animations:^
                    {
                        // set new position of label which it will animate to
                        labelPoints.frame = rect;
                    }
                    completion:^(BOOL finished)
                    {
                        [labelPoints removeFromSuperview];
                    }
                 
                ];
                labelPoints = nil;
                
                //--------------------------------------------
                
                
                
                return;
            }
        }
    }
}

-(IBAction) ballWasPressed:(id)selector
{
#if TEST_MODE
    NSLog(@"==CGameManager: ballWasPressed==");
#endif
    UIButton * btn = (UIButton*)selector;
    if (btn)
    {
        
        
        //удалаям кнопку
        int buttonTag = [btn tag];
        [self deleteBallByTag: buttonTag];
        
        
    }
    else
    {
#if TEST_MODE
        NSLog(@"!!!CGameManager: Указатель на кнопку не преобразовался!!!");
#endif        
        
    }
}






@end


