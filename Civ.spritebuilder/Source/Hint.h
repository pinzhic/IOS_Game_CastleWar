//
//  Hint.h
//  Civ
//
//  Created by Pinzhi Chen on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Hint : CCSprite

@property (nonatomic) int count;
@property (nonatomic) BOOL hide;

-(void) nextPhase;
-(id) init;

@end
