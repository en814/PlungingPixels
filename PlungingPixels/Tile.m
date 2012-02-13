//
//  Tile.m
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "Tile.h"

@interface Tile()
@property (nonatomic) BOOL filled;
@property (nonatomic) UIColor color;
@property (nonatomic) int level;
@end

@implementation Tile
@synthesize filled = _filled;
@synthesize color = _color;
@synthesize level = _level;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect box;
        box.size.width = 64;
        box.size.height = 64;
        CGContextBeginPath(context);
        CGContextAddRect(context, box);
        CGContextClosePath(context);
        [[UIColor redColor] setFill];
        [[UIColor blackColor] setStroke];
        CGContextDrawPath(context,kCGPathFillStroke);
        NSLog(@"Drawing %@\n", self);
}

- (void) drawTile:(CGRect) rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect box;
    box = self.bounds;
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, box);
    CGContextClosePath(context);
    [[UIColor redColor] setFill];
    [[UIColor blackColor] setStroke];
    CGContextDrawPath(context,kCGPathFillStroke);
    NSLog(@"Drawing %@\n", self);
}


@end
