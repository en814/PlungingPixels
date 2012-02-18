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
@property (readwrite, nonatomic) int type;
@end

@implementation Tile
@synthesize filled = _filled;
@synthesize level = _level;
@synthesize color = _color;
@synthesize type = _type;
@synthesize objId = _objId;
@synthesize location = _location;

- (id) init: (UIColor*) color filled: (BOOL) filled withLevel: (int) level
{
    self = [super init];
    
    self.color = color;
    self.filled = filled;
    self.level = level;
    
    return self;
}

- (void) stepInRect: (CGRect) rect {
    if (self.level > 0)
        self.level = self.level - 1;
    //else
        // update board
    
    //CGRect location = self.location;
    //location.origin.x++;
    //location.origin.y++;
    //self.location = location;
}

- (id) initWithType: (int) ty andLocation: (CGRect) loc {
    self = [super init];
    //self.objId = nextId++;
    self.type = ty;
    self.location = loc;
    
    return self;
}


@end
