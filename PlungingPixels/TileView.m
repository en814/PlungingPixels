//
//  TileView.m
//  PlungingPixels
//
//  Created by Teal Owyang on 3/5/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "TileView.h"

@interface TileView()
@property (nonatomic) int curIdx;
@end

@implementation TileView
@synthesize tileQueue = _tileQueue;
@synthesize changeTile = _changeTile;
@synthesize curIdx = _curIdx;

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
    
    Tile *tile;
    
    if (self.changeTile) {
        //self.curIdx = arc4random() % 88;
        tile = [self.tileQueue tileAtIndex:0];
        [tile.color setFill];
        self.changeTile = NO;
    }
    else {
        tile = [self.tileQueue tileAtIndex:self.curIdx];
        [tile.color setFill];
    }
    [[UIColor blackColor] setStroke];
    
    CGContextDrawPath(context,kCGPathFillStroke);
    
    self.backgroundColor = nil;
    self.alpha = .75;
}

- (void) setColor: (UIColor *) color forIndex: (int) idx
{
    
}

- (void) setOpacity: (float) alpha
{
    
}

-(void)dealloc {
    _tileQueue = nil;
    _changeTile = 0;
    _curIdx = 0;

}

@end
