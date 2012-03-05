//
//  PixelEngine.h
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Grid.h"
#import "Tile.h"

@interface PixelEngine : NSObject
@property (readonly, nonatomic) int timer;
@property (readonly, strong, nonatomic) Grid *board;
@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) BOOL pause;
@property (readonly, nonatomic) BOOL quit;
@property (readonly, nonatomic) BOOL running;

- (int) timer;

- (id) init;
- (void) start;
- (void) stop;
- (BOOL) running;
- (void) advance;
- (id) initWithRect: (CGRect) rect;
- (void) step;
- (void) addObject: (Tile *) tile;

@end


