//
//  PixelView.m
//  PlungingPixels
//
//  Created by Teal Owyang on 2/16/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "PixelView.h"

@interface PixelView()
@property (strong, nonatomic) NSMutableArray *gridOrigins;
@property (nonatomic) BOOL gridInitalized;
@end

@implementation PixelView
@synthesize grid = _grid;
@synthesize column = _column;
@synthesize row = _row;
@synthesize tileWidth = _tileWidth;
@synthesize tileHeight = _tileHeight;
@synthesize gridOrigins = _gridOrigins;
@synthesize gridInitalized = _gridInitalized;

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
    
    box.size.width = self.bounds.size.width / self.column;
    box.size.height = self.bounds.size.height / self.row;
    
    //int c = 0;
    
    for (int row=0; row<self.row; row++) {
        for (int column=0; column<self.column; column++) {
            box.origin.x = box.size.width * column;
            box.origin.y = box.size.height * row;
            
            if (!self.gridInitalized) {
                if (!self.gridOrigins) 
                    self.gridOrigins = [[NSMutableArray alloc] initWithCapacity:self.row * self.column];
                //NSLog(@"grid origin %f %f", box.origin.x, box.origin.y);
                [self.gridOrigins addObject:[NSValue valueWithCGPoint:CGPointMake(box.origin.x, box.origin.y)]];
                //NSLog(@"adding a grid origin %d", c++);
            }
            
            //NSLog(@"grid: row %d column %d origin: x %f y %f", row, column, box.origin.x, box.origin.y);
            CGContextBeginPath(context);
            CGContextAddRect(context, box);
            CGContextClosePath(context);
            Tile *tile = [self.grid tileAtIndex:PixelArrIdx(row, column, self.column)];
            [tile.color setFill];
            [[UIColor blackColor] setStroke];
            CGContextDrawPath(context,kCGPathFillStroke);
        }
    }
    
    self.gridInitalized = YES;
}

- (void) setColor: (UIColor *) color forIndex: (int) idx
{
    if (!self.grid) {
        self.grid = [[Grid alloc] init: 0];
    }
    
    // TODO logic for setting the grid colors when tile has reached the grid
}

- (void) setOpacity: (float) alpha forRow: (int) row column: (int)col
{
    
}

@end
