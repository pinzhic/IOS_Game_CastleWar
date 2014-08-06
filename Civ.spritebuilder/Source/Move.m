//
//  Move.m
//  Civ
//
//  Created by Pinzhi Chen on 7/15/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Move.h"

@implementation Move


@synthesize isValid;

-(id) init
{
    self = [super initWithImageNamed:@"CivAsset/GreenOutline.png"];
    if (self){
        self.isValid = false;
        self.visible = isValid;
    }
    return self;
}

- (void) update
{
    self.visible = isValid;
}

@end
