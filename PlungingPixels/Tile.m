//
//  Tile.m
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "Tile.h"

static int nextId = 0;

@interface Tile()
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) BOOL filled;
@property (nonatomic) int level;
@property (nonatomic) int type;
@property (nonatomic) int objId;
@end

@implementation Tile
@synthesize filled = _filled;
@synthesize level = _level;
@synthesize color = _color;
@synthesize type = _type;
@synthesize objId = _objId;
@synthesize location = _location;
@synthesize velocity = _velocity;
@synthesize acceleration = _acceleration;

- (id) init: (UIColor*) color filled: (BOOL) filled withLevel: (int) level
{
    self = [super init];
    
    self.color = color;
    self.filled = filled;
    self.level = level;
    
    return self;
}

- (void) stepInRect: (CGRect) rect withInterval: (CFTimeInterval) intv {
    // calls method each frame
    // TODO 
    // if ()
    //  update location, velocity, and acceleration
}

- (id) initWithType: (int) ty andLocation: (CGRect) loc {
    self = [super init];
    self.objId = nextId++;
    self.type = ty;
    self.location = loc;
    
    // initialization values will change
    self.velocity = CGPointMake(-100, 0);
    self.acceleration = CGPointMake(0, 480);
    
    return self;
    
    return self;
}


@end
