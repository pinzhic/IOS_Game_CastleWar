//
//  Tile.h
//  Civ
//
//  Created by Pinzhi Chen on 7/7/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Tile : CCSprite

@property (nonatomic, assign) BOOL isValid;
@property (nonatomic, assign) float defModify;
@property (nonatomic, assign) int tileCate;

-(id) initTile;
-(id) initTileWithCate: (int) cate;
-(void) disappear;

@end
