//
//  PixelView.h
//  PlungingPixels
//
//  Created by Teal Owyang on 2/16/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tile.h"
#import "Grid.h"

@interface PixelView : UIView

@property (strong, nonatomic) Grid *grid;
@property (nonatomic) int column;
@property (nonatomic) int row;

- (void) setColor: (UIColor *) color forIndex: (int) idx;
- (void) setOpacity: (float) alpha forRow: (int) row column: (int)col;

@end
