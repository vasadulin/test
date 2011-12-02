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


@property (nonatomic) CGPoint _center;
@property (nonatomic) CGFloat _r;
@property (nonatomic) CGPoint _speed;
@property (nonatomic) CGFloat _mass;

//Методы
-(void) tick;
-(id) init;

-(id) initWithCenter:(CGPoint)point 
              radius:(CGFloat)radius;

-(NSInteger) points;

//-(id) initWithParam: 
//             center:(CGPoint)center 
//             radius:(CGFloat)radius
//              speed:(CGPoint)speed
//               mass:(CGFloat)mass;


@end
