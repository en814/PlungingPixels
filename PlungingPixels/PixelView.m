//
//  PixelView.m
//  PlungingPixels
//
//  Created by Teal Owyang on 2/16/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "PixelView.h"

@implementation PixelView

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
/*
- (void)drawRect:(CGRect)rect
{
    // Drawing code
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGRect box;
     box.size.width = 64;
     box.size.height = 64;
     box.origin.x = super.bounds.size.width / 2 - box.size.width / 2;
     box.origin.y = super.bounds.size.height / 2 - box.size.height / 2;
     CGContextBeginPath(context);
     CGContextAddRect(context, box);
     CGContextClosePath(context);
     [[UIColor purpleColor] setFill];
     [[UIColor blackColor] setStroke];
     CGContextDrawPath(context,kCGPathFillStroke);
     NSLog(@"Drawing %@\n", self);
}
*/
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
