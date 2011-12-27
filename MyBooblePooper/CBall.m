//
//  CBall.m
//  MyBooblePooper
//
//  Created by iPhone on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CBall.h"

#import <stdlib.h>
#import <time.h>




//#define MIN_X 0
//#define MAX_X 320
//#define MIN_Y 0
//#define MAX_Y 440

#define MIN_R 15
#define MAX_R 50

#define KOEFICIENT_Y_DIV_X 1.6f

@implementation CBall

@synthesize _center;
@synthesize _rX;
@synthesize _rY;
@synthesize _speed;
@synthesize _mass;
@synthesize _availableArea;



//Методы
-(void) tick
{
    
#if TEST_MODE
    //NSLog(@"CBall: Time tick");
#endif
    
    _center.x += _speed.x;
    _center.y += _speed.y;
    

    //меняем направление движения по х
    if (_center.x + _rX > _availableArea->size.width + _availableArea->origin.x)
    {
        _speed.x = - _speed.x;
    }    
    if ( _center.x - _rX <  _availableArea->origin.x) 
    {        
        _speed.x = - _speed.x;
    }
    
    //меняем направление движения по y
    if (_center.y + _rY > _availableArea->size.height + _availableArea->origin.y
        || _center.y - _rY < _availableArea->origin.y) 
    {
        _speed.y = - _speed.y;
    }
}



-(id) initWithAvailableArea:(CGRect*)rectArea 
{
    //srandom(time(NULL));
    self = [super init];
    if (self != nil) 
    {
        _availableArea = rectArea;
        //радиус шара
        int lR = MIN_R;
        int rR = MAX_R;
        _rX = random() % (rR-lR+1) + lR  ;
        _rY = KOEFICIENT_Y_DIV_X * _rX;
        //центр шара
        int lcx = _availableArea->origin.x + _rX, rcx = _availableArea->size.width + _availableArea->origin.x - _rX; //диапазон по Х
        int lcy = _availableArea->origin.y + _rY, rcy = _availableArea->size.height + _availableArea->origin.y - _rY; //диапазон по У
        
        _center = CGPointMake(
                              random() % (rcx-lcx+1) + lcx, // center X
                              random() % (rcy-lcy+1) + lcy  // center Y
                              ); 
        
        //скорость шара
        int lspeedX = 5, rspeedX = 20; //диапазон по Х
        int lspeedY = 5, rspeedY = 20; //диапазон по Y
        float signX = -1, signY = -1;
        if (random() %1000 < 500) 
        {
            signX = 1;
        }
        if (random() %1000 < 500) 
        {
            signY = 1;
        }
        
        _speed = CGPointMake(
                             signX*(random() % (rspeedX-lspeedX+1) + lspeedX)/10.0f, // скорость по X
                             signY*(random() % (rspeedY-lspeedY+1) + lspeedY)/10.0f  // скорость по Y
                             ); 
        _mass = 1.0f;
    }
    return self;
}

-(id) initWithCenter:(CGPoint)point 
              radius:(CGFloat)radius
       availableArea:(CGRect*)rectArea;
{
    self = [super init];
    
    if (self != nil) 
    {
        _center = point; 
        _rX = radius;
        _rY = KOEFICIENT_Y_DIV_X * _rX;
        _speed = CGPointMake(1.0f, 1.0f);
        _mass = 1.0f;
        _availableArea=rectArea;
        
    }
    return self;
}

-(NSInteger) points
{
    return (1 + MAX_R - _rX); 
    
}

//сообщает шару о том, что нужно переместиться 
//на допустимую область _availableArea
-(void) moveToAvailableArea
{
    //CGRect который занимает шар
    CGRect ballRect = CGRectMake(_center.x - _rX, _center.y + _rY, 2*_rX, 2*_rY);
    
    //если шар находится за допустимой областью _availableArea
    if ( ! CGRectContainsRect(*_availableArea, ballRect))
    {
        //то меняем у него координаты Х-У, 
        CGFloat tmp = _center.x;
        _center.x = _center.y;
        _center.y = tmp;
        //если все равно выходит за _availableArea, то обрезаем Х и У
        if (_center.x + _rX > _availableArea->size.width + _availableArea->origin.x) 
        {
            _center.x = _availableArea->size.width + _availableArea->origin.x - _rX;
        }
        if (_center.y + _rY > _availableArea->size.height + _availableArea->origin.y) 
        {
            _center.y = _availableArea->size.height + _availableArea->origin.y - _rY;
        }
    }
}


//-(id) initWithParam: 
//             center:(CGPoint)center 
//             radius:(CGFloat)radius
//              speed:(CGPoint)speed
//               mass:(CGFloat)mass;
//{
//    self = [super init];
//    if (self != nil) 
//    {
//        _center = center; 
//        _r = radius;
//        _speed = speed;
//        _mass = mass;
//        
//    }
//    return self;
//}



@end
