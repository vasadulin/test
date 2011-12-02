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




#define MIN_X 0
#define MAX_X 320
#define MIN_Y 0
#define MAX_Y 480

#define MAX_R 50

@implementation CBall

@synthesize _center;
@synthesize _r;
@synthesize _speed;
@synthesize _mass;



//Методы
-(void) tick
{
    
#if TEST_MODE
    //NSLog(@"CBall: Time tick");
#endif
    
    _center.x += _speed.x;
    _center.y += _speed.y;
    
//    if (_center.x  > MAX_X || _center.x  < MIN_X) 
//    {//меняем направление движения по х
//        _speed.x = - _speed.x;
//    }
//    
//    if (_center.y  > MAX_Y || _center.y  < MIN_Y) 
//    {//меняем направление движения по y
//        _speed.y = - _speed.y;
//    }

    
    if (_center.x + _r > MAX_X || _center.x - _r < MIN_X) 
    {//меняем направление движения по х
        _speed.x = - _speed.x;
    }
    
    if (_center.y + _r > MAX_Y || _center.y - _r < MIN_Y) 
    {//меняем направление движения по y
        _speed.y = - _speed.y;
    }
}



-(id) init
{
    //srandom(time(NULL));
    

    
    self = [super init];
    if (self != nil) 
    {
        //радиус шара
        int lR = 15;
        int rR = MAX_R;
        _r = random() % (rR-lR+1) + lR  ;
        
        //центр шара
        int lcx = MIN_X + _r, rcx = MAX_X - _r; //диапазон по Х
        int lcy = MIN_Y + _r, rcy = MAX_Y - _r; //диапазон по У
        
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
             radius:(CGFloat)radius;
{
    self = [super init];
    
    if (self != nil) 
    {
        _center = point; 
        _r = radius;
        _speed = CGPointMake(1.0f, 1.0f);
        _mass = 1.0f;
        
    }
    return self;
}

-(NSInteger) points
{
    return (1 + MAX_R - _r)*10; 
    
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
