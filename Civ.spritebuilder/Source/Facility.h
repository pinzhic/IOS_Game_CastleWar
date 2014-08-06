//
//  Facility.h
//  Civ
//
//  Created by Pinzhi Chen on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Facility : CCSprite

@property (nonatomic, assign) int _belong;
@property (nonatomic, assign) int _cate;
@property (nonatomic, assign) int goldIncome;
@property (nonatomic, assign) BOOL isValid;
@property (nonatomic, assign) float defModify;
@property (nonatomic, assign) int XInd;
@property (nonatomic, assign) int YInd;

-(id) initWithCate:(int) cate andBelong:(int) belong xind:(int) x yind:(int) y;

@end
