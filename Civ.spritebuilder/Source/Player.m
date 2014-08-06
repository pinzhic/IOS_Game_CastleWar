//
//  Player.m
//  Civ
//
//  Created by Pinzhi Chen on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize name;
@synthesize imagePath;
@synthesize gold;
@synthesize leadCode;
@synthesize income;

- (id) initWithCode: (int) code
{
    
    self = [super init];
    if (self){
    leadCode = code;
        
    
        if (leadCode == 1){
            
            [self setName:@"Caocao"];
            
            gold = 200;
            
        }
        if (leadCode == 2){
            [self setName:@"Khan"];
            gold = 150;
        }
        if (leadCode == 3){
            [self setName:@"Ceasar"];
            gold = 150;
            
        }
        income = 20;
   
    
    }
    
    return self;
}

-(NSString *) getName2{
    return name;
}

@end
