//
//  Unit.m
//  Civ
//
//  Created by Pinzhi Chen on 7/12/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Unit.h"

@implementation Unit

@synthesize category;
@synthesize pow;
@synthesize hp;
@synthesize belong;
@synthesize acted;
@synthesize xInd;
@synthesize yInd;
@synthesize mov;
@synthesize isValid;
@synthesize name;

- (id) initUnitWithCate:(int)cate andBelong:(int) bel andX:(int)x andY:(int)y
{
    if (cate == 1){
        if (bel == 1){
            self = [super initWithImageNamed:@"CivAsset/FTmanRed.png"];
            belong = 1;
        } else if(bel == 2){
            self = [super initWithImageNamed:@"CivAsset/FTmanBlue.png"];
            belong = 2;
        }
        
        acted = false;
        isValid = true;
        category = 1;
        mov = 1;
        hp = 100;
        pow = 10;
        
        name = @"Infantry";
        
    }
    if (cate == 0){
        self = [super initWithImageNamed:@"CivAsset/square1.png"];
        isValid = false;
        xInd = x;
        yInd = y;
    }
    belong = bel;
    
    acted = false;
    xInd = x;
    yInd = y;
    
    self.visible = isValid;
    
    return self;
    
    
}

-(void) become:(Unit *)target{
    category = target.category;
    self.visible = target.visible;
    self.isValid = target.isValid;
    self.belong = target.belong;
    self.pow = target.pow;
    self.mov = target.mov;
    self.name = target.name;
    self.hp = target.hp;
    self.acted = target.acted;
    //self.xInd = target.xInd;
    //self.yInd = target.yInd;
    if (category == 1){
        if (belong == 2){
        [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/FTmanBlue.png"]];
        }
        if (belong == 1){
            [self setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"CivAsset/FTmanRed.png"]];
        }
    }
}

-(void) disappear
{
    category = 0;
    isValid = false;
    self.visible = false;
    belong = 0;
}


@end
