//
//  PlayBoard.h
//  Civ
//
//  Created by Pinzhi Chen on 6/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"

@interface PlayBoard : CCNode

@property (nonatomic, strong) NSString * playerOneName;
@property (nonatomic, strong) NSString * playerTwoName;

-(void) updateDisplay;

@end
