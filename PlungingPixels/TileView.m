//
//  TileView.m
//  PlungingPixels
//
//  Created by Teal Owyang on 3/5/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "TileView.h"

@implementation TileView
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
    NSLog(@"drawing tile?");
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect box = self.bounds;
    CGContextBeginPath(context);
    CGContextAddRect(context, box);
    CGContextClosePath(context);
    [[UIColor purpleColor] setFill];
    [[UIColor blackColor] setStroke];
    
    CGContextDrawPath(context,kCGPathFillStroke);
    
    self.backgroundColor = nil;
    self.alpha = .75;
    
    //float tileWidth = self.bounds.size.width / 8;
    //float tileHeight = self.bounds.size.height / 11;
    
    // draw falling tile
    //box.size.width = tileWidth * 5;
    //box.size.height = tileHeight * 5;
    //float offsetWidth = box.size.width / 2;
    //float offsetHeight = box.size.height/ 2;
    //box.origin.x = self.bounds.size.width / 2 - offsetWidth;
    //box.origin.y = self.bounds.size.height / 2 - offsetHeight;
    
    //CGRect  viewRect = CGRectMake(10, 10, 100, 100);
    //self = [[UIView alloc] initWithFrame:viewRect];
    
    //NSLog(@"width %f height %f", box.size.width, box.size.height);
}

@end
