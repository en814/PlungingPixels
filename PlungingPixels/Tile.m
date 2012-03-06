//
//  Tile.m
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "Tile.h"

@interface Tile()
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) BOOL filled;
@property (nonatomic) int level;
@property (nonatomic) int type;
@end

@implementation Tile
@synthesize filled = _filled;
@synthesize level = _level;
@synthesize color = _color;
@synthesize type = _type;
@synthesize location = _location;
@synthesize velocity = _velocity;
@synthesize acceleration = _acceleration;

- (id) initWithType: (int) ty 
           andColor: (UIColor*) color
           andLevel: (int) level
             filled: (BOOL) filled
{
    self = [super init];
    
    self.type = ty;
    self.color = color;
    self.level = level;
    self.filled = filled;
    self.level = level;
    
    // initialization values will change
    self.location = CGRectMake(0, 0, 100, 100);
    self.velocity = CGPointMake(-100, 0);
    self.acceleration = CGPointMake(0, 480);
    
    return self;
}

- (id) initWithLocation:(CGRect)loc
{
    self.location = loc;
    return self;
}

- (void) stepInRect: (CGRect) rect withInterval: (CFTimeInterval) intv {
    // calls method each frame
    // TODO 
    // if ()
    //  update location, velocity, and acceleration
}

@end
