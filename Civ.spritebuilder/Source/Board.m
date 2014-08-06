//
//  Board.m
//  Civ
//
//  Created by Pinzhi Chen on 7/6/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Board.h"
#import "Tile.h"
#import "Unit.h"
#import "Facility.h"
#import "GameData.h"
#import "Move.h"
#import "Check.h"

#import "math.h"

static const int BOARD_SIZE = 11;

@implementation Board{
    NSMutableArray *_gridArray;
    NSMutableArray *_facilityArray;
    NSMutableArray *_unitsArray;
    NSMutableArray *_moveArray;
    NSMutableArray *_checkArray;
    
    float _centerX;
    float _centerY;
    float _tileSize; //27.08 325
    float _contentSize;
    CCNode *_tileNode;
    GameData* gb;
    
    int currPlayer;
    CCLabelTTF *_winText;
    //NSNull *_nu;
    
    // bases
    Facility * castle1;
    Facility * castle2;
    
    // particle
    BOOL hintMark;
    CCSprite* hint;
    

}


@synthesize _currTile;
@synthesize _currUnit;
@synthesize _currFacility;
@synthesize _formerUnit;
@synthesize _currMagic;


- (void)onEnter
{
    [super onEnter];
    
    [self setupBoard];
    
    gb = [GameData sharedData];
    // accept touches on the grid
    self.userInteractionEnabled = TRUE;
    //_nu = [NSNull null];
    _winText.visible = false;
    _currTile = nil;
    _currUnit = nil;
    _currMagic = 0;
    srand48(time(0));
    
    hint = [CCSprite spriteWithImageNamed:@"CivAsset/dot.png"];
    hint.visible = false;
    [self addChild:hint];
    }

- (void) loadMap:(int)number
{
    
}

- (BOOL) isValidTileWithX: (int) x andY:(int) y
{
    int offset = BOARD_SIZE / 2;
    if (x >= BOARD_SIZE || y >= BOARD_SIZE || x < 0 || y < 0){
        return false;
    }
    if ((x + y < offset) || x + y > offset * 3){
        return false;
    } else {
        return true;
    }
}

- (void) setupBoard
{
    int offset = BOARD_SIZE / 2;
    
    _centerX = self.contentSize.width / 2;
    _centerY = self.contentSize.height / 2;
    _tileSize = self.contentSize.width / (BOARD_SIZE + 1);
    _contentSize = self.contentSize.width;
    
    
    _gridArray = [NSMutableArray array];
    _facilityArray = [NSMutableArray array];
    _unitsArray = [NSMutableArray array];
    _moveArray = [NSMutableArray array];
    _checkArray = [NSMutableArray array];
    
    
    for (int i = 0; i < BOARD_SIZE; i++){
        _gridArray[i] = [NSMutableArray array];
        _unitsArray[i] = [NSMutableArray array];
        _facilityArray[i] = [NSMutableArray array];
        _moveArray[i] = [NSMutableArray array];
        _checkArray[i] = [NSMutableArray array];
        
        for (int j = 0; j < BOARD_SIZE; j++){
            // tile
            Tile *tt = [[Tile alloc] initTileWithCate:1];
            tt.anchorPoint = ccp(0.5,0.5);
            float x = _centerX + (j - offset) * _tileSize + (i - offset) * _tileSize / 2;
            float y = _centerY + (i - offset) * _tileSize;
            
            tt.position = ccp(x, y);
            if (![self isValidTileWithX:i andY:j]){
                tt.isValid = false;
                tt.visible = false;
            }
            
            [self addChild:tt];
            _gridArray[i][j] = tt;
            
            
            
            // faci
            Facility* fc = [[Facility alloc] initWithCate:0 andBelong:0 xind:j yind:i];
            fc.position = ccp(x,y);
            [self addChild:fc];
            _facilityArray[i][j] = fc;
            
            
            
            // move
            Move* mov =[[Move alloc] init];
            mov.position = ccp(x,y);
            [self addChild:mov];
            _moveArray[i][j] = mov;
            
            
            
        }
    }
    
    
    float x;
    float y;
    
    // add tile
    Tile* mountain =[[Tile alloc] initTileWithCate:2];
    x = [self getPosX:5 withYInt:5];
    y = [self getPosY:5];
    mountain.position = ccp(x,y);
    [self addChild:mountain];
    _gridArray[5][5] = mountain;
    
    Tile* mountain2 =[[Tile alloc] initTileWithCate:2];
    x = [self getPosX:5 withYInt:4];
    y = [self getPosY:4];
    mountain2.position = ccp(x,y);
    [self addChild:mountain2];
    _gridArray[4][5] = mountain2;
    
    Tile* mountain3 =[[Tile alloc] initTileWithCate:2];
    x = [self getPosX:5 withYInt:6];
    y = [self getPosY:6];
    mountain3.position = ccp(x,y);
    [self addChild:mountain3];
    _gridArray[6][5] = mountain3;
    
    
    
    
    
    Facility* base1 = [[Facility alloc] initWithCate:1 andBelong:1 xind:0 yind:BOARD_SIZE - 1];
    x = [self getPosX:0 withYInt:BOARD_SIZE - 1];
    y = [self getPosY:BOARD_SIZE - 1];
    base1.position = ccp(x,y);
    [self addChild:base1];
    _facilityArray[BOARD_SIZE - 1][0] = base1;
    castle1 = base1;
    
    Facility* base2 = [[Facility alloc] initWithCate:1 andBelong:2 xind:BOARD_SIZE - 1 yind:0];
    x = [self getPosX:BOARD_SIZE - 1 withYInt:0];
    y = [self getPosY:0];
    base2.position = ccp(x,y);
    [self addChild:base2];
    _facilityArray[0][BOARD_SIZE - 1] = base2;
    castle2 = base2;
    



    
    for (int i = 0; i < BOARD_SIZE; i++){
        for (int j = 0; j < BOARD_SIZE; j++){
            float x = _centerX + (j - offset) * _tileSize + (i - offset) * _tileSize / 2;
            float y = _centerY + (i - offset) * _tileSize;
            Unit *ftman = [[Unit alloc] initUnitWithCate:0 andBelong:0 andX:j andY:i];
            ftman.position = ccp(x,y);
            //ftman.opacity = 0.5;
            [self addChild:ftman];
            _unitsArray[i][j] = ftman;
            
            Check* check = [[Check alloc] init];
            check.position = ccp(x,y);
            [self addChild:check];
            _checkArray[i][j] = check;
        }
    }
    
}


- (int) getXIndex:(CGPoint) point withY:(int) YIndex
{
    
    float posX = point.x - (YIndex - 6) * _tileSize / 2;
    float midx = _contentSize / 2;
    float fx = (posX - midx) / _tileSize + (float)(BOARD_SIZE/2);
    if (fx < 0){
        return -1;
    }
    int x = (int) (posX - midx) / _tileSize + BOARD_SIZE / 2;
    return x;
}

- (int) getYINdex:(CGPoint) point
{
    float Midy = _contentSize / 2;
    int y = 6 + (int)(point.y - Midy) / _tileSize - 0.5;
    return y;
}

- (float) getPosY:(int) yInt
{
    return (float)_centerY + (yInt - 5) * _tileSize;
}

- (float) getPosX:(int) xInt withYInt:(int) yInt
{
    return (float)_centerX + (xInt - 5) * _tileSize + (yInt - 5) * _tileSize / 2;
    
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [touch locationInNode:self];
    gb.changed = TRUE;
  
    
    int y = [self getYINdex:touchLocation];
    int x = [self getXIndex:touchLocation withY:y];
    NSLog(@"%d",y);
    NSLog(@"%d",x);

 //   CCParticleSystem *fire = (CCParticleSystem *)[CCBReader load:@"fight"];
    
    
    if ([self isValidTileWithX:x andY:y]){
        
        _formerUnit = _currUnit;
        
        _currTile = _gridArray[y][x];
        _currFacility = _facilityArray[y][x];
        _currUnit = _unitsArray[y][x];
        // test
        
        
        
        if (_currMagic != 0 &&_currUnit != nil && [_currUnit isValid]){
            /*
            CCParticleSystem *fire2 = (CCParticleSystem *)[CCBReader load:@"fight"];
            fire2.autoRemoveOnFinish = true;
            fire2.position = _currUnit.position;
            [_currUnit.parent addChild:fire2 ];
             */
            if (_currMagic == 1){
                
                if (gb.currPlayer == 1){
                    if (gb.p1gold < 50){
                        return;
                    } else {
                        gb.p1gold -= 50;
                    }
                }
                if (gb.currPlayer == 2){
                    if (gb.p2gold < 50){
                        return;
                    } else {
                        gb.p2gold -= 50;
                    }
                }
                
                _currUnit.hp = _currUnit.hp * 0.5;
                CCParticleSystem *fire = (CCParticleSystem *)[CCBReader load:@"fire"];
                fire.autoRemoveOnFinish = true;
                fire.position = _currUnit.position;
                [_currUnit.parent addChild:fire];
            }
            if (_currMagic == 2){
                
                if (gb.currPlayer == 1){
                    if (gb.p1gold < 75){
                        return;
                    } else {
                        gb.p1gold -= 75;
                    }
                }
                if (gb.currPlayer == 2){
                    if (gb.p2gold < 75){
                        return;
                    } else {
                        gb.p2gold -= 75;
                    }
                }
                
                _currUnit.hp = 100;
                CCParticleSystem *heal = (CCParticleSystem *)[CCBReader load:@"heal"];
                heal.autoRemoveOnFinish = true;
                heal.position = _currUnit.position;
                [_currUnit.parent addChild:heal];
            }
            _currMagic = 0;
            return;
            
        }
        
        _currMagic = 0;
        
        //magic
        /*
        if (_currUnit == nil || ![_currUnit isValid]){
            _currMagic = 0;
        }
        if ([_currUnit isValid] && _currMagic != 0){
            
            fightParticle.autoRemoveOnFinish = true;
            fightParticle.position = _currUnit.position;
            [_currUnit.parent addChild:fightParticle];
            
        }
         */
        
        int x =[self unitDistance:_formerUnit and:_currUnit];
        NSLog(@"distance: %d",x);
        
        //not your turn
        if ([_formerUnit belong] != gb.currPlayer){
            return;
        }
        
        if ([_formerUnit isValid] && [_currUnit isValid] && [_currUnit acted] && ![_formerUnit acted]){
            if (x <= _formerUnit.mov){
                [self battleAttack:_formerUnit Defend:_currUnit];
            }
        }
        
        
        if (_formerUnit.acted || [self unitDistance:_formerUnit and:_currUnit] > _formerUnit.mov ||
            (_currUnit.isValid && _currUnit.acted)){
            return;
        }
        

        
        if ([self unitDistance:_formerUnit and:_currUnit] > 0 &&
            [self unitDistance:_formerUnit and:_currUnit] <= _formerUnit.mov + 2){
            NSLog(@"dis,%d", [self unitDistance:_formerUnit and:_currUnit]);
            // fight
            if ([_formerUnit belong] != 0 && [_currUnit belong] !=0 && [_formerUnit belong] != [_currUnit belong]){
                [self battleAttack:_formerUnit Defend:_currUnit];
                return;
            }
            [self unitSwap:_currUnit with:_formerUnit];
        }
        
        
    } else {
        _currTile = nil;
        _currFacility = nil;
        _currUnit = nil;
    }
    
    //[self upVisible];
    [self checkWin];
    
}

- (void) checkWin
{
    int x1 = [castle1 XInd];
    int y1 = [castle1 YInd];
    int x2 = [castle2 XInd];
    int y2 = [castle2 YInd];
    
    if ([_unitsArray[y1][x1] isValid] && [_unitsArray[y1][x1] belong] == 2){
        // 2 win
        _winText.visible = true;
        _winText.string = @"Player 2 wins";
        return;
    }
    
    if ([_unitsArray[y2][x2] isValid] && [_unitsArray[y2][x2] belong] == 1){
        // 2 win
        _winText.visible = true;
        _winText.string = @"Player 1 wins";
        return;
    }
}

- (void) upVisible{
    for (int i = 0; i < BOARD_SIZE; i++){
        for (int j = 0; j < BOARD_SIZE; j++){
            Unit* u = _unitsArray[i][j];
            u.visible = [u isValid];
        }
    }
}

// all about unit move

- (int) unitDistance:(Unit*) u1 and:(Unit*) u2
{
    if (u1 == nil || u2 == nil){
        return -1;
    }
    int x1 = [u1 xInd];
    int x2 = [u2 xInd];
    int y1 = [u1 yInd];
    int y2 = [u2 yInd];
    if (x1 == x2){
        return abs(y1 - y2);
    }
    if (y1 == y2){
        return abs(x1 - x2);
    }
    if ((x1 - x2) * (y1 - y2) > 0){
        return abs(x1 - x2) + abs(y1 - y2);
    } else {
        return abs(x1 - x2) > abs(y1 - y2) ? abs(x1 - x2) : abs(y1 - y2);
    }
    return -1;
}

- (void) unitSwap: (Unit*) u1 with: (Unit*) u2
{
    Unit* temp = [[Unit alloc] initUnitWithCate:2 andBelong:1 andX:0 andY:0];
    u1.acted = true;
    u2.acted = true;
    BOOL oriU1 = u1.visible;
    BOOL oriU2 = u2.visible;
    // from u2 to u1
    
    struct CGPoint p2;
    struct CGPoint p1;
    p1.x = u1.position.x;
    p1.y = u1.position.y;
    p2.x = u2.position.x;
    p2.y = u2.position.y;
    
    CCActionCallBlock *actionAfterMoving = [CCActionCallBlock actionWithBlock:^{
        u1.visible = oriU1;
        u2.visible = oriU2;
        [temp become:u1];
        [u1 become:u2];
        [u2 become:temp];

        
        if (u1.isValid){
            [_checkArray[u1.yInd][u1.xInd] appear];
            u1.opacity = .5;
        }
        if (u2.isValid){
            [_checkArray[u2.yInd][u2.xInd] appear];
            u2.opacity = .5;
        }
    }];
    
    CCActionCallBlock *actionAfterFirstMove = [CCActionCallBlock actionWithBlock:^{
        
        u1.visible = false;
        u2.visible = false;
    }];
    
    id action11 = [CCActionMoveTo actionWithDuration:0.2f position:p1];
    id action12 = [CCActionMoveTo actionWithDuration:0.01f position:p2];
    id action21 = [CCActionMoveTo actionWithDuration:0.2f position:p2];
    id action22 = [CCActionMoveTo actionWithDuration:0.01f position:p1];
    
    CCActionSequence* actionSeq1 = [CCActionSequence actionWithArray:@[action11,actionAfterFirstMove,action12,actionAfterMoving]];
    
    CCActionSequence* actionSeq2 = [CCActionSequence actions:action21,action22,nil];
    [u2 runAction:actionSeq1];
    [u1 runAction:actionSeq2];
    

}

- (void) playerEnd:(int) pID
{
    
    if (pID == 2){
        for (int i = 0; i < BOARD_SIZE; i++){
            for (int j = 0; j < BOARD_SIZE; j++){
                if ([_unitsArray[i][j] isValid]){
                    if ([_unitsArray[i][j] belong] == 1){
                        [_unitsArray[i][j] setActed:false];
                        [_checkArray[i][j] disappear];
                        Unit* u = _unitsArray[i][j];
                        u.opacity = 1;
                    }
                }
            }
        }
        
        gb.currPlayer = 1;
    } else if (pID == 1){
        for (int i = 0; i < BOARD_SIZE; i++){
            for (int j = 0; j < BOARD_SIZE; j++){
                if ([_unitsArray[i][j] isValid]){
                    if ([_unitsArray[i][j] belong] == 2){
                        [_unitsArray[i][j] setActed:false];
                        [_checkArray[i][j] disappear];
                        Unit* u = _unitsArray[i][j];
                        u.opacity = 1;
                    }
                }
            }
        }
        gb.currPlayer = 2;
    }
    
}

- (void) generateUnitAtX:(int) x Y:(int) y cate:(int) cate belong:(int) belong
{
    if (cate == 1){
        Unit* unit = [[Unit alloc] initUnitWithCate:cate andBelong:belong andX:x andY:y];
        [_unitsArray[y][x] become:unit];
    }
}

- (bool) tileEmptyX:(int) x Y:(int) y
{
    return ![_unitsArray[y][x] isValid];
}

- (void) battleAttack: (Unit*) attcker Defend:(Unit*) defender
{
    if (![attcker isValid] || ![defender isValid]){
        return;
    }

    CCParticleSystem *fightParticle = (CCParticleSystem *)[CCBReader load:@"fight"];
    
    CCActionCallBlock *actionAfterFight = [CCActionCallBlock actionWithBlock:^{
        fightParticle.autoRemoveOnFinish = true;
        fightParticle.position = defender.position;
        [defender.parent addChild:fightParticle];
    }];
    
    
    CCActionCallBlock *actionAfterMove = [CCActionCallBlock actionWithBlock:^{
        
        
        
        
        float apow = (float)[attcker pow];
        float dpow = (float)[defender pow];
        int x1 = [attcker xInd];
        int y1 = [attcker yInd];
        int x2 = [defender xInd];
        int y2 = [defender yInd];
        
        Tile* dTile = _gridArray[y2][x2];
        Facility* dFaci = _facilityArray[y2][x2];
        float defModi = 1;
        if ([dFaci isValid]){
            defModi *= [dFaci defModify];
        }
        defModi *= [dTile defModify];
        dpow = dpow * defModi * (1 + ((float) defender.hp) / 100);
        apow = apow * (1 + ((float) attcker.hp)/100);
        
        attcker.hp = attcker.hp - [self damage:dpow];
        defender.hp = defender.hp - [self damage:apow];
        
        attcker.acted = true;
        attcker.opacity = .5;
        if (attcker.hp > 0 && defender.hp > 0){
            [_checkArray[y1][x1] appear];
            
            return;
        }
        
        if (attcker.hp > 0 && defender.hp < 0){
            [defender disappear];
            [self unitSwap:attcker with:defender];
            [_checkArray[y2][x2] appear];
            return;
        }
        
        if (attcker.hp <= 0){
            [attcker disappear];
            [_checkArray[y1][x1] disappear];
        }
        
        if (defender.hp <= 0){
            [defender disappear];
            [_checkArray[y2][x2] disappear];
        }

    }];
    
    struct CGPoint p1;
    struct CGPoint p2;
    p1.x = attcker.position.x;
    p1.y = attcker.position.y;
    p2.x = defender.position.x;
    p2.y = defender.position.y;
    
    id action1 = [CCActionMoveTo actionWithDuration:.12 position:p2];
    id action2 = [CCActionMoveTo actionWithDuration:.2 position:p1];
    
    CCActionSequence* actionSeq = [CCActionSequence actions:action1,actionAfterFight,action2,actionAfterMove, nil];
    
    [attcker runAction:actionSeq];
    
}

- (int) damage: (float) pow
{
    
    double r = drand48();
    r = r + 0.5;
    return (int) pow * 2 * r;
}

- (void) moveUnitAnimationFrom:(Unit*) u1 to:(Unit*) u2
{

    
}

- (void) moveToBack:(Unit*) unit to:(CGPoint) dest
{
    struct CGPoint oriPoint;
    oriPoint.x = unit.position.x;
    oriPoint.y = unit.position.y;
    
    id action1 = [CCActionMoveTo actionWithDuration:0.5f position:dest];
    id action2 = [CCActionMoveTo actionWithDuration:0.5f position:oriPoint];
    [unit runAction:[CCActionSequence actions: action1, action2,nil]];
    

}

-(void) outsideClick
{
    _currFacility = nil;
    _currTile = nil;
    _currUnit = nil;
    _formerUnit = nil;
    gb.changed = true;
    _currMagic = 0;
}


-(void) update:(CCTime)delta
{
    hintMark = !hintMark;
    hint.opacity = .5;
    hint.visible = false;
    if (_currUnit != nil && [_currUnit isValid]){
        //NSLog(@"check");
        
        hint.position = _currUnit.position;
        if (hintMark){
            hint.visible = true;
        }
        
        
    }
    
    castle1.opacity = 1;
    castle2.opacity = 1;
    if (gb.currPlayer == 1){
        if (hintMark){
            castle1.opacity =.5;
        }
        
    }
    if (gb.currPlayer == 2){
        if (hintMark){
            castle2.opacity = .5;
        }
    }
}


-(void) printTest:(int) inx
{
    NSLog(@"reach");
}

@end
