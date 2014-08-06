//
//  Hint.m
//  Civ
//
//  Created by Pinzhi Chen on 8/5/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Hint.h"

@implementation Hint

@synthesize count;
@synthesize  hide;

- (id) init
{
    
    self = [super initWithImageNamed:@"CivAsset/dot.png"];
    
    if (self) {
        
    }
    self.visible = false;
    
    return self;
}


-(void) nextPhase
{
    self.visible = !hide;
    hide = !hide;
}

@end
