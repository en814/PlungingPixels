//
//  TileView.m
//  PlungingPixels
//
//  Created by Teal Owyang on 3/5/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "TileView.h"

@implementation TileView
@synthesize queue = _queue;
@synthesize row = _row;
@synthesize column = _column;

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
    
    CGRect box = self.bounds;
    CGContextBeginPath(context);
    CGContextAddRect(context, box);
    CGContextClosePath(context);
    int randTile = arc4random() % 88;
    NSLog(@"random number is %d", randTile);
    Tile *tile = [self.queue tileAtIndex:randTile];
    [tile.color setFill];
    //[[UIColor purpleColor] setFill];
    [[UIColor blackColor] setStroke];
    
    CGContextDrawPath(context,kCGPathFillStroke);
    
    self.backgroundColor = nil;
    //self.alpha = .75;
}

@end
