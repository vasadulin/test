//
//  CBall.h
//  MyBooblePooper
//
//  Created by iPhone on 24.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define TEST_MODE 1

@interface CBall : NSObject
{
    

}

@property (nonatomic) CGPoint _center;
@property (nonatomic) CGFloat _r;
@property (nonatomic) CGPoint _speed;
@property (nonatomic) CGFloat _mass;
@property (nonatomic) CGRect* _availableArea;

//Методы
-(void) tick;
-(id) initWithAvailableArea:(CGRect*)rectArea;

-(id) initWithCenter:(CGPoint)point 
              radius:(CGFloat)radius
       availableArea:(CGRect*)rectArea;

-(NSInteger) points;

//сообщает шару о том, что нужно переместиться 
//на допустимую область _availableArea
-(void) moveToAvailableArea;


//-(id) initWithParam: 
//             center:(CGPoint)center 
//             radius:(CGFloat)radius
//              speed:(CGPoint)speed
//               mass:(CGFloat)mass;


@end
