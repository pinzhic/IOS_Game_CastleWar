//
//  Move.h
//  Civ
//
//  Created by Pinzhi Chen on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCSprite.h"

@interface Move : CCSprite

@property (nonatomic, assign) BOOL isValid;

- (id) init;
- (void) update;

@end
