//
//  GameData.h
//  Civ
//
//  Created by Pinzhi Chen on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject

@property (nonatomic) NSMutableArray* arrayOfDataToBeStored;
@property (nonatomic) int num_player;
@property (nonatomic) int map;
@property (nonatomic) int p1;
@property (nonatomic) int p2;
@property (nonatomic) bool somethingToBeToggled;
@property (nonatomic) BOOL changed;
@property (nonatomic) int currPlayer;
@property (nonatomic) int randomEvent;
@property (nonatomic) int p1gold;
@property (nonatomic) int p2gold;

+(GameData*) sharedData;

@end
