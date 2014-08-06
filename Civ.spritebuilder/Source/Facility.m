//
//  Facility.m
//  Civ
//
//  Created by Pinzhi Chen on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Facility.h"

@implementation Facility


@synthesize _belong;
@synthesize _cate;
@synthesize goldIncome;
@synthesize isValid;
@synthesize defModify;
@synthesize XInd;
@synthesize YInd;

-(id) initWithCate:(int) cate andBelong:(int) belong xind: (int) x yind: (int) y
{
    if (cate == 0){
        self = [super initWithImageNamed:@"CivAsset/square1.png"];
        isValid = FALSE;
        
        _cate = 0;
    }
    if (cate == 1 && belong == 1){
        self = [super initWithImageNamed:@"CivAsset/castleRed.png"];
        [self set_belong:1];
        _cate = 1;
        isValid = true;
        defModify = 1.5;
        self.goldIncome = 20;
    }
    if (cate == 1 && belong == 2){
        self = [super initWithImageNamed:@"CivAsset/castleBlue.png"];
        [self set_belong:2];
        _cate = 1;
        isValid = true;
        defModify = 1.5;
        self.goldIncome = 20;
    }
    
    self.visible = isValid;
    XInd = x;
    YInd = y;
    return self;
}

@end
