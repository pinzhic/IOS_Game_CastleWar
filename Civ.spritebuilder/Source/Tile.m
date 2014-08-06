//
//  Tile.m
//  Civ
//
//  Created by Pinzhi Chen on 7/7/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Tile.h"

@implementation Tile

@synthesize isValid;

- (id) initTile
{
  
    self = [super initWithImageNamed:@"CivAsset/grasslandTexture1.png"];
    
    if (self) {
        self.isValid = TRUE;
    }
    self.visible = TRUE;
    
    return self;

    
}

- (id) initTileWithCate:(int)cate
{
    if (cate == 1){
        self = [super initWithImageNamed:@"CivAsset/grasslandTexture1.png"];
        if (self){
            self.isValid = TRUE;
            self.tileCate = 1;
            [self setDefModify:1];
        }
        self.visible = TRUE;
        return self;
    }
    
    if (cate == 2){
        self = [super initWithImageNamed:@"CivAsset/mountainTexture.png"];
        if (self){
            self.isValid = true;
            self.tileCate = 2;
            [self setDefModify:1.2];
        }
        self.visible = true;
        return self;
    }
    return self;
}


- (void) disappear
{
    self.visible = false;
}

@end
