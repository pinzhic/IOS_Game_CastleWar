//
//  Unit.h
//  Civ
//
//  Created by Pinzhi Chen on 7/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Unit : CCSprite

@property (nonatomic, assign) int hp;
@property (nonatomic, assign) int pow;
@property (nonatomic, assign) int belong;
@property (nonatomic, assign) BOOL acted;
@property (nonatomic, assign) int xInd;
@property (nonatomic, assign) int yInd;
@property (nonatomic, assign) BOOL isValid;
@property (nonatomic, assign) int mov;
@property (nonatomic, assign) int category;
@property (nonatomic, assign) NSString * name;

-(id) initUnitWithCate: (int) cate andBelong:(int) bel andX: (int)x andY: (int)y;

-(void) become:(Unit*) target;
-(void) disappear;

@end
