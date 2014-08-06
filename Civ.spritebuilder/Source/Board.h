//
//  Board.h
//  Civ
//
//  Created by Pinzhi Chen on 7/6/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "Tile.h"
#import "Unit.h"
#import "Facility.h"
#import "Move.h"

@interface Board : CCSprite

@property (nonatomic, assign) Tile* _currTile;
@property (nonatomic, assign) Facility* _currFacility;
@property (nonatomic, assign) Unit* _currUnit;
@property (nonatomic, assign) Unit* _formerUnit;
@property (nonatomic, assign) int _currMagic;


-(void) playerEnd:(int) pID;
- (void) generateUnitAtX:(int) x Y:(int) y cate:(int) cate belong:(int) belong;
- (bool) tileEmptyX:(int) x Y:(int) y;
-(void) outsideClick;
@end
