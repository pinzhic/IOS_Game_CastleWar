//
//  GameData.m
//  Civ
//
//  Created by Pinzhi Chen on 7/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameData.h"

@implementation GameData

@synthesize arrayOfDataToBeStored;
@synthesize num_player;
@synthesize map;
@synthesize somethingToBeToggled;
@synthesize p1;
@synthesize p2;
@synthesize changed;
@synthesize currPlayer;
@synthesize randomEvent;
@synthesize p1gold;
@synthesize p2gold;

static GameData *sharedData = nil;

+(GameData*) sharedData
{
    //If our singleton instance has not been created (first time it is being accessed)
    if(sharedData == nil)
    {
        NSLog(@"new gb");
        //create our singleton instance
        sharedData = [[GameData alloc] init];
        
        //collections (Sets, Dictionaries, Arrays) must be initialized
        //Note: our class does not contain properties, only the instance does
        //self.arrayOfDataToBeStored is invalid
        sharedData.arrayOfDataToBeStored = [[NSMutableArray alloc] init];
        sharedData.num_player = 2;
        //
        sharedData.map = 1;
        sharedData.changed = false;
        sharedData.currPlayer = 1;
        sharedData.randomEvent = 0;
    }
    
    //if the singleton instance is already created, return it
    return sharedData;
}

@end
