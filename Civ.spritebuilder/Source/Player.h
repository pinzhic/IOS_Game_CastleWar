//
//  Player.h
//  Civ
//
//  Created by Pinzhi Chen on 7/13/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic, assign) NSString* name;
@property (nonatomic, assign) NSString* imagePath;
@property (nonatomic, assign) int gold;
@property (nonatomic, assign) int leadCode;
@property (nonatomic, assign) int income;

-(id) initWithCode:(int) code;
-(NSString *) getName2;


@end
