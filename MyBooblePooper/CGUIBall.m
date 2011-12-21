//
//  CGUIBall.m
//  MyBooblePooper
//
//  Created by iPhone on 25.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CGUIBall.h"

@implementation CGUIBall

@synthesize _button;
@synthesize _mainViewController;

//Методы
-(void) tick
{
#if TEST_MODE
    //NSLog(@"CGUIBall: Time tick");
#endif
    
    [super tick];
    _button.center = super._center;
  
}

//-(id) initWithViewController: (UIViewController*)vc  
//                 //gameManager:(CGameManager*) gm
//{
//    self = [super init];
//    if (self != nil) 
//    {
//        _mainViewController = vc;
//        //create the button
//        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//                                      
//        //set the position of the button
//        _button.frame = CGRectMake(super._center.x, super._center.y, super._r , super._r );
//                   
//        //устанавливаем тэг для кнопки, чтобы проще было ее искать
//        static int buttonTag = 0;
//        [_button setTag:buttonTag];
//        buttonTag++;
//        
//        //set the button's title
//        //[_button setTitle:@"Kill" forState:UIControlStateNormal];
//        
//        //добавляем кнопке обработчик
//        [_button addTarget:self 
//                    action:@selector(ballWasPressed:) 
//          forControlEvents:UIControlEventTouchDown
//         ];
//                   
//        //add the button to the view
//        [_mainViewController.view  addSubview:_button];
//                   
//                   
//    }
//    return self;
//}

-(id) initWithViewController: (UIViewController*)vc  
                 gameManager:(CGameManager*) gm
               availableArea:(CGRect*)rectArea
{
    self = [super initWithAvailableArea:rectArea];
    
    if (self != nil) 
    {
        super._availableArea = rectArea;

        _mainViewController = vc;
                //create the button
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //set the position of the button
        _button.frame = CGRectMake(super._center.x, super._center.y, 
                                   super._r*2 , super._r*2 );
        
        //set the button's title
        //[_button setTitle:@"Kill" forState:UIControlStateNormal];
        
        //устанавливаем тэг для кнопки, чтобы проще было ее искать
        static int buttonTag = 0;
        [_button setTag:buttonTag];
        buttonTag++;
        
        //добавляем кнопке картинку
        [_button setImage:[UIImage imageNamed:@"board_and_swords@2x.png"] forState:UIControlStateNormal];
        
        //добавляем кнопке обработчик
        [_button addTarget:gm 
                    action:@selector(ballWasPressed:) 
          forControlEvents:UIControlEventTouchDown
         ];
        
        //add the button to the view
        [_mainViewController.view  addSubview:_button];
        
        
    }
    return self;
}

-(id) initWithViewController: (UIViewController*)vc  
                 gameManager:(CGameManager*) gm
                      center:(CGPoint)point 
                      radius:(CGFloat)radius
               availableArea:(CGRect*)rectArea

{
    self = [super initWithCenter: point radius:radius availableArea:rectArea];
    if (self != nil) 
    {
        _mainViewController = vc;
        //create the button
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //set the position of the button
        _button.frame = CGRectMake(super._center.x, super._center.y, 
                                   super._r*2 , super._r*2 );
        
        //set the button's title
        //[_button setTitle:@"Kill" forState:UIControlStateNormal];

        //устанавливаем тэг для кнопки, чтобы проще было ее искать
        static int buttonTag = 0;
        [_button setTag:buttonTag];
        buttonTag++;
        
        //добавляем кнопке картинку
        [_button setImage:[UIImage imageNamed:@"board_and_swords@2x.png"] forState:UIControlStateNormal];
        
        //добавляем кнопке обработчик
        [_button addTarget:gm 
                    action:@selector(ballWasPressed:) 
          forControlEvents:UIControlEventTouchDown
         ];
        
        //add the button to the view
        [_mainViewController.view  addSubview:_button];
        
        
    }
    return self;
}


-(IBAction) ballWasPressed:(id)selector
{
#if TEST_MODE
    NSLog(@"==CGUIBall: ballWasPressed==");
#endif
    
}


-(NSInteger) getTag
{
    return [_button tag];

}





@end
