//
//  PlayBoard.m
//  Civ
//
//  Created by Pinzhi Chen on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "PlayBoard.h"
#import "Board.h"
#import "GameData.h"
#import "Player.h"
#import "Tile.h"

static const int FTMANCOST = 100;

@implementation PlayBoard{
    CCLabelTTF *_p1Gold;
    CCLabelTTF *_p2Gold;
    CCLabelTTF *_p1Name;
    CCLabelTTF *_p2Name;
    Board *_board;
    CCSprite *_player1Pic;
    CCSprite *_player2Pic;
    
    GameData* gb;
    
    Player* player1;
    Player* player2;
    int _currentPlayer;
    int _numOfPlayer;
    CCTimer *_timer;
    
    
    
    CCNode *_tileNode;
    CCNode *_unitNode;
    CCNode *_faciNode;
    //tile info
    CCLabelTTF *_defModify;
    CCLabelTTF *_tileName;
    CCSprite *_tileImage;
    // faci info
    CCSprite *_faciImage;
    CCLabelTTF *_faciName;
    CCLabelTTF *_faciInfo;
    
    CCLabelTTF *_faciB1Text;
    CCNode *_faci_castle_buttons;
    CCButton *_faciButton1;
    
    // unit info
    CCSprite *_unitImage;
    CCLabelTTF *_unitName;
    CCLabelTTF *_unitHP;
    CCLabelTTF *_unitPow;
    
    // other
    CCButton *_endButton;
    CCLabelTTF *_winText;
    
    // magic
    CCButton *_fire1;
    CCButton *_heal1;
    
    
}

- (id)init
{
    self = [super init];
    
    if (self) {
        _timer = [[CCTimer alloc] init];
    }
    
    return self;
}

- (void)onEnter
{
    [super onEnter];
    
    
    //self.userInteractionEnabled = TRUE;
    //[self schedule:@selector(checkChanges) interval:0.1f];
    // test
    //_playerLayout1.visible = false;
    _tileNode.visible = false;
    
    // curr player = 1
    _player2Pic.opacity = .5;
    
    gb = [GameData sharedData];
    
    int p1 = [gb p1];
    int p2 = [gb p2];
    
    if (p1 == 1){
        [_player1Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/caocao.png"]];
        
    }
    if (p1 == 2){
        [_player1Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/chengjisi.png"]];
    }
    if (p1 == 3){
        [_player1Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/kaisa.png"]];
    }
    if (p2 == 1){
        [_player2Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/caocao.png"]];
    }
    if (p2 == 2){
        [_player2Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/chengjisi.png"]];
    }
    if (p2 == 3){
        [_player2Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/kaisa.png"]];
    }
    //NSLog(@"%d", p1);
    
    // gold
    if (p1 == 1){
        gb.p1gold = 500;
    } else {
        gb.p1gold = 450;
    }
    
    if (p2 == 1){
        gb.p2gold = 500;
    } else {
        gb.p2gold = 450;
    }
    
    player1 = [[Player alloc] initWithCode:p1];
    player2 = [[Player alloc] initWithCode:p2];
    
    NSString* Leader1Name = [player1 name];
    NSString* Leader2Name = [player2 name];
    
    _p1Name.string = Leader1Name;
    _p2Name.string = Leader2Name;
    
    [self updateDisplay];
    // accept touches on the grid
    self.userInteractionEnabled = TRUE;
    //_nu = [NSNull null];
    
    _currentPlayer = 1;
    _numOfPlayer = 2;
    

    
    
}

-(void) checkChanges
{
    
    if ([gb changed]){
        [self updateDisplay];
        [gb setChanged:false];
    }
}

- (void) updateDisplay{
    _p1Gold.string = [NSString stringWithFormat:@"%d",gb.p1gold];
    _p2Gold.string = [NSString stringWithFormat:@"%d",gb.p2gold];
    
    Tile* currTile = [_board _currTile];
    Facility* currFaci = [_board _currFacility];
    Unit* currUnit = [_board _currUnit];
    //NSLog(@"%d",currTile.tileCate);
    [self updateTileInfo: currTile];
    [self updateFaciInfo: currFaci];
    [self updateUnitInfo: currUnit];
    
    
    
}

-(void) updateTileInfo: (Tile*) currTile
{
    if (currTile == nil){
        _tileNode.visible = false;
        //NSLog(@"sf")   ;
    } else {
        _tileNode.visible = TRUE;
        if ([currTile tileCate] == 1){
            [_tileImage setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/grasslandTexture1.png"]];
            _tileName.string = @"Grassland";
            

        }
        if ([currTile tileCate] == 2){
            [_tileImage setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/mountainTexture.png"]];
            _tileName.string = @"Mountain";
        }
        NSString *def = @"DEF+";
        NSString *num = [NSString stringWithFormat:@"%d",(int)(([currTile defModify] - 1) * 100)];
        def = [def stringByAppendingString:num];
        def = [def stringByAppendingString:@"%"];
        _defModify.string = def;
    }
}

-(void) updateFaciInfo: (Facility*) currFaci
{
    if (currFaci == nil){
        _faciNode.visible = false;
    } else if (currFaci.isValid == false){
        _faciNode.visible = false;
        
    } else {
        _faciNode.visible = true;
        // castle
        if ([currFaci _cate] == 1){
            // set image
            [_faciImage setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/castle2.png"]];
            _faciName.string = @"Castle";
            
            NSString *def = @"DEF+";
            NSString *num = [NSString stringWithFormat:@"%d",(int)(([currFaci defModify] - 1) * 100)];
            def = [def stringByAppendingString:num];
            def = [def stringByAppendingString:@"%\n"];
            
            def = [def stringByAppendingString:@"Gold+"];
            def = [def stringByAppendingString:[NSString stringWithFormat:@"%d%@",[currFaci goldIncome],@"/Turn"]];
            
            _faciInfo.string = def;

        }
    }
}

- (void) updateUnitInfo: (Unit*) currUnit
{
    if (currUnit == nil || currUnit.isValid == false){
        _unitNode.visible = false;
    } else {
        _unitNode.visible = true;
        if (currUnit.category == 1){
            [_unitImage setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/BTNFootman.png"]];
        }
        
        // pow hp
        int hp = currUnit.hp;
        int pow = currUnit.pow;
        
        NSString *hpString = [NSString stringWithFormat:@"%d",hp];
        NSString *powString = [NSString stringWithFormat:@"%d",pow];
        
        _unitHP.string = hpString;
        _unitPow.string = powString;
    }
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    CGPoint touchLocation = _heal1.position;
   
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
     NSLog(@"%f",touchLocation.y);

    NSLog(@"%fs",location.y);
    if (CGRectContainsPoint([_heal1 boundingBox], touchLocation)){
        NSLog(@"touched");
    }
    
    
    
    
    [self updateDisplay];
    [_board outsideClick];
    
    _tileNode.visible = TRUE;
    
}

-(void) endButtonPressed
{
    //gb = [GameData sharedData];
    NSLog(@"out%d",gb.currPlayer);
    //gb.currPlayer = 2;
    //NSLog(@"%d",gb.currPlayer);

    
    if (gb.currPlayer == 1){
        [_board playerEnd:1];
        gb.p1gold += player1.income;
        _player1Pic.opacity = 0.5;
        _player2Pic.opacity = 1;

    } else if (gb.currPlayer == 2){
        [_board playerEnd:2];
        gb.p2gold += player2.income;
        _player1Pic.opacity = 1;
        _player2Pic.opacity = .5;


    }
    [self updateDisplay];
}

- (void) faciButton1Pressed
{
    if (_faciButton1.visible){
        
        Facility *currfaci = [_board _currFacility];
        int x = currfaci.XInd;
        int y = currfaci.YInd;
        int p = currfaci._belong;
        if (p == 1){
            if (gb.p1gold >= FTMANCOST && [_board tileEmptyX:x Y:y]){
                gb.p1gold -= FTMANCOST;
                
                [_board generateUnitAtX:x Y:y cate:1 belong:1];
            }
        }
        if (p == 2){
            if (gb.p2gold >= FTMANCOST && [_board tileEmptyX:x Y:y]){
                
                gb.p2gold -= FTMANCOST;
                [_board generateUnitAtX:x Y:y cate:1 belong:2];
            }
        }
        
    }
    [self updateDisplay];
}

- (void)update:(CCTime)delta
{
    [self checkChanges];
}

- (void) fire1pressed
{
    _board._currMagic = 1;
}

- (void) heal1pressed
{
    _board._currMagic = 2;
}

@end
