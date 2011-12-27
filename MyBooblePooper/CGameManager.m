//
//  CGameManager.m
//  MyBooblePooper
//
//  Created by iPhone on 25.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CGameManager.h"
#import "CGUIBall.h"
#import "ASD_Soft_ViewController.h"

#import <stdlib.h>
#import <time.h>

#define MAX_COUNT_BALL 10
#define MIN_COUNT_BALL 2



//расстояние которое пролетит UILabel, отображающая очки за убитый шар
#define DISTANCE_POINTS 30
//Время анимации (полета)UILabel, отображающая очки за убитый шар
#define TIME_ANIMATE_POINTS 1.0f

//позиция отображения обратного отсчета
#define GAME_OVER_X 100
#define GAME_OVER_Y 200
#define GAME_OVER_W 150
#define GAME_OVER_H 30

//позиция отображения очков
#define SCORE_X 110
#define SCORE_Y 420
#define SCORE_W 130
#define SCORE_H 30

// ======== Продолжительность раунда в секундах ======
#define SECONDS_FOR_GAME 30

#define BOTTOM_PANEL_HEIGHT 40

#define SCORE_PENALTY 50

#define MIN_X 0
#define MAX_X_PORTRAIT 320
#define MAX_X_LANDSCAPE 480
#define MIN_Y 0
#define MAX_Y_PORTRAIT 480
#define MAX_Y_LANDSCAPE 320

//=================  private методы=============
@interface CGameManager()

//меняем Rect игрового поля в зависимости от toInterfaceOrientation
-(void) ChangeRectOfAreaTo:(UIInterfaceOrientation)toInterfaceOrientation;

//передвигаем все шары в допустимый Rect
-(void) MoveBallsToCurrentRectArea;



@end

// ================ Реализация  ================
@implementation CGameManager

@synthesize _balls;
@synthesize _mainViewController;
@synthesize _scores;
@synthesize _labelGameOver;
@synthesize _rectArea;
@synthesize _labelScores;
@synthesize _btnPenalti;
@synthesize _secondLeftToGameover;
@synthesize _currentNick;
@synthesize _imagesForBall;

//Методы
//конструктор без параметров
-(id) initWithViewController : (UIViewController*) vc
{
    srandom(time(NULL));
    
    self = [super init];
    _currentNick = @"Вася";
    
    if (self != nil) 
    {
         
        _mainViewController = vc;
        _rectArea = _mainViewController.view.frame;
        _rectArea.size.height -= BOTTOM_PANEL_HEIGHT;
        
        //инициализируем массив шаров  
        _balls = [NSMutableArray arrayWithCapacity:1];
        
        //загружаем картинки для шаров в массив картинок
        _imagesForBall = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"01.png"],
                             [UIImage imageNamed:@"02.png"],
                             [UIImage imageNamed:@"03.png"],
                             nil
                          ];

        
//        //--------- создаем кнопку для штрафного нажатия -----------
//        //create the button
//        _btnPenalti = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        //set the position of the button
//        CGRect framePen = _mainViewController.view.frame;         
//        framePen.size.height -= 50.0f;        
//        _btnPenalti.frame = framePen;
//        
//        //добавляем кнопке обработчик
//        [_btnPenalti addTarget:self 
//                    action:@selector(penaltyWasPressed:) 
//          forControlEvents:UIControlEventTouchDown
//         ];
//        
//        //add the button to the view
//        [_mainViewController.view  addSubview:_btnPenalti];

        //============  обратный отсчет секунд для одного раунда ==========
        _secondLeftToGameover = SECONDS_FOR_GAME;
        
        //создаю лэйбу для отображения обратного отсчета
        
        CGRect frameGameOver = CGRectMake(	GAME_OVER_X, GAME_OVER_Y, GAME_OVER_W, GAME_OVER_H);
        
        _labelGameOver = [[UILabel alloc] initWithFrame:frameGameOver] ;
        
        _labelGameOver.textAlignment = UITextAlignmentLeft;
        _labelGameOver.text = [[NSString alloc] initWithFormat:@"Осталось: %d", _secondLeftToGameover];
        _labelGameOver.font = [UIFont boldSystemFontOfSize:17.0];
        _labelGameOver.textColor = [UIColor colorWithRed:130.0/255.0 green:155.0/255.0 blue:108.0/255.0 alpha:1.0];
        _labelGameOver.backgroundColor = [UIColor clearColor];
        _labelGameOver.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        //_labelGameOver.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        
        [_mainViewController.view addSubview:_labelGameOver];
        
        //====================сбрасываю очки  ======================
        _scores = 0;
        //создаю лэйбу для отображения очков
        
        CGRect frame = CGRectMake(	SCORE_X, SCORE_Y, SCORE_W, SCORE_H);
        
        _labelScores = [[UILabel alloc] initWithFrame:frame] ;
        
        _labelScores.textAlignment = UITextAlignmentLeft;
        _labelScores.text = @"Score: 0";
        _labelScores.font = [UIFont boldSystemFontOfSize:17.0];
        _labelScores.textColor = [UIColor colorWithRed:130.0/255.0 green:155.0/255.0 blue:108.0/255.0 alpha:1.0];
        _labelScores.backgroundColor = [UIColor clearColor];
        //_labelScores.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
        _labelScores.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        
        
        [_mainViewController.view addSubview:_labelScores];
         
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
                                availableArea: &_rectArea
                                //center: CGPointMake(80, 80)
                                //radius: 20.0f
                                ];
                
                [_balls addObject:ball];
            }
        }
    }
    
}
//-----------------------------------------------

-(void) gameOverTick    /// -------------- GAMEOVER TICK -----------
{
    
#if TEST_MODE
    //NSLog(@"CGameManager: gameOverTick ");
#endif
    _secondLeftToGameover--;
    _labelGameOver.text = [[NSString alloc] initWithFormat:@"Осталось: %d", _secondLeftToGameover];
    
    if (_secondLeftToGameover <= 0)
    {
       

        [self gameOverHandler];

    }
       
}
//-----------------------------------------------
// обработка окончания игры
-(void) gameOverHandler
{
    
    //_labelGameOver.text = @"Конец игры!!!";
    //остановка таймеров
    ASD_Soft_ViewController * mc = (ASD_Soft_ViewController *)_mainViewController;
    [mc.tickTimer invalidate];
    [mc.gameOverTimer invalidate];
    mc.tickTimer =nil;
    mc.gameOverTimer =nil;
    
    //установка времени для следующей игры !!!!!!!!!! перенести в старт игры!!!!!!!
    _secondLeftToGameover = SECONDS_FOR_GAME;
    
    //выдать сообщение на экран (Алерт) игра закончена вы набрали столько то очков
    NSString* title = [[NSString alloc] initWithFormat:@"Вы набрали %d очков. \nКто Вы?", _scores];
    NSString* txtButton1 = [[NSString alloc] initWithFormat:@"Я - %@", _currentNick];
    NSString* txtButton2 = [[NSString alloc] initWithFormat:@"Ввести другое имя"];
    // open a dialog with two custom buttons
    //ASD_Soft_ViewController * mc = (ASD_Soft_ViewController *)_mainViewController;
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
                                                             delegate:mc 
                                                    cancelButtonTitle:nil 
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:txtButton1, txtButton2, nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	//actionSheet.destructiveButtonIndex = 1;	// make the second button red (destructive)
	[actionSheet showInView:mc.view]; // show from our table view (pops up in the middle of the table)

    

}

//Обработка нажатия на кнопку Кого записать в топ: текущее имя или ввести новое имя 
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{

    //ввести свое имя если необходимо
    if (buttonIndex == 1)
    {
        _currentNick = [self enterNewNick];
    }
    
    //записать очки и имя в таблицу очков
    //[self insertToTableScore name: _currentNick score:_scores];
    
    //предложить посмотреть топ игроков
    
    
    //показать топ игроков
    [self showTableScore];
    
    //if(actionSheet.tag == 1) {
        //NSLog(@"%@ (Кнопка по индексу %d)",[actionSheet buttonTitleAtIndex:buttonIndex],buttonIndex);
    //} else {
        //Если это другой UIActionSheet
    //}
}

//
-(NSString*) enterNewNick
{
    return @"Петя";
}

//показать топ игроков
-(void)showTableScore
 {
     UIAlertView *simpleAlert = [[UIAlertView alloc] initWithTitle:@"Лучшие игроки" 
                                                           message:_currentNick 
                                                          delegate:self 
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil];
     [simpleAlert show];
 }

//------------------------------------------------

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
                
                //очки за шар
                NSInteger points = [ball points];
                //-------------- подсчет очков --------------------
                [self addPointsToSumScore:points];
                [self showScores];
                
                //------------- Всплывающие очки ------------
                //CGRect кнопки
                CGRect rect = [ball._button frame];
            
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

-(void) addPointsToSumScore: (NSInteger)points
{
    _scores += points;

}

-(void) showScores
{
    if (_labelScores) 
    {
        
        [_labelScores setText:[[NSString alloc] initWithFormat:@"Очки: %d", _scores]];
        
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

-(IBAction) penaltyWasPressed:(CGPoint) point
{
#if TEST_MODE
    NSLog(@"==CGameManager: penaltyWasPressed==");
#endif

    // минусуем очки
    _scores -= SCORE_PENALTY;
    
    // всплывание лэйбы со штрафом
    
    //делаем всплывающие очки
    CGRect  rect = CGRectMake(	point.x, point.y, 40, 30);
    UILabel * labelPoints = [[UILabel alloc] initWithFrame:rect];
    [labelPoints setText:[[NSString alloc] initWithFormat:@"%d", -SCORE_PENALTY]];
    labelPoints.backgroundColor = [UIColor clearColor]; // [UIColor brownColor];
    labelPoints.textColor = [UIColor redColor];
    
    
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
    
    [self showScores];
    
 }

-(void) ChangeOrientationAreaTo:(UIInterfaceOrientation)toInterfaceOrientation
{
    [self ChangeRectOfAreaTo:toInterfaceOrientation];
    [self MoveBallsToCurrentRectArea];
    //[self moveControlsToCurrentRectArea];

}

-(void) ChangeRectOfAreaTo:(UIInterfaceOrientation)toInterfaceOrientation;
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight
        ||toInterfaceOrientation ==UIInterfaceOrientationLandscapeLeft)
    {//альбомная ориентация
        _rectArea.origin.x = MIN_X;
        _rectArea.origin.y = MIN_Y;
        _rectArea.size.width = MAX_X_LANDSCAPE;
        //contentStretch   bounds   accessibilityFrame
        _rectArea.size.height = MAX_Y_LANDSCAPE - BOTTOM_PANEL_HEIGHT;
    }
    else
    {//портретная ориентация
        _rectArea.origin.x = 0;
        _rectArea.origin.y = 0;
        _rectArea.size.width = MAX_X_PORTRAIT;
        //contentStretch   bounds   accessibilityFrame
        _rectArea.size.height = MAX_Y_PORTRAIT - BOTTOM_PANEL_HEIGHT;
    }
}


-(void) MoveBallsToCurrentRectArea
{
    //перебираем массив шаров и каждому сообщаем о новой допустимой области
    
    for (NSUInteger i=0; i< _balls.count; i++) 
    {
        CBall * ball = [_balls objectAtIndex:i];
        if(ball)
        {
            [ball moveToAvailableArea];
        }
    }
}




@end


