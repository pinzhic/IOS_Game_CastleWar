//
//  Check.m
//  Civ
//
//  Created by Pinzhi Chen on 7/27/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Check.h"

@implementation Check

- (id) init
{
    
    self = [super initWithImageNamed:@"CivAsset/Trans.png"];
    
    if (self) {
        
    }
    self.visible = false;
    
    return self;
}

- (void) appear
{
    self.visible = false;
}

- (void) disappear
{
    self.visible = false;
}


@end
