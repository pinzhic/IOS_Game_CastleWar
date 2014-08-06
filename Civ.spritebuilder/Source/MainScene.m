//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "GameData.h"

static const int NUM_LEADER = 3;

@implementation MainScene{
    CCSprite *_player1Pic;
    CCSprite *_player2Pic;
    int p1;
    int p2;
    int map;
    GameData* data;
}

- (void) onEnter
{
    [super onEnter];
    NSLog(@"enter1!");
    p1 = 1;
    p2 = 3;
    map = 1;
    data = [GameData sharedData];
    data.p1 = 1;
    data.p2 = 3;
    

}

- (void) change1up
{
    if (p1 == NUM_LEADER){
        p1 = 1;
    } else {
        p1 ++;
    }
    data.p1 = p1;
    NSLog(@"%d",p1);
    if (p1 == 1){
        [_player1Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/caocao.png"]];
    }
    if (p1 == 2){
        [_player1Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/chengjisi.png"]];
    }
    if (p1 == 3){
        [_player1Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/kaisa.png"]];
    }
    
}

- (void) change1down
{
    if (p1 == 1){
        p1 = NUM_LEADER;
    } else {
        p1 --;
    }
    data.p1 = p1;

    if (p1 == 1){
        [_player1Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/caocao.png"]];
    }
    if (p1 == 2){
        [_player1Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/chengjisi.png"]];
    }
    if (p1 == 3){
        [_player1Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/kaisa.png"]];
    }
    
}

- (void) change2up
{
    if (p2 == NUM_LEADER){
        p2 = 1;
    } else {
        p2 ++;
    }
    data.p2 = p2;
    //NSLog(@"%d",p1);
    if (p2 == 1){
        [_player2Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/caocao.png"]];
    }
    if (p2 == 2){
        [_player2Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/chengjisi.png"]];
    }
    if (p2 == 3){
        [_player2Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/kaisa.png"]];
    }
    
}

- (void) change2down
{
    if (p2 == 1){
        p2 = NUM_LEADER;
    } else {
        p2 --;
    }
    
    data.p2 = p2;
    
    if (p2 == 1){
        [_player2Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/caocao.png"]];
    }
    if (p2 == 2){
        [_player2Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/chengjisi.png"]];
    }
    if (p2 == 3){
        [_player2Pic setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/kaisa.png"]];
    }
    
}


- (void)play {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"PlayBoard"];
    
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
