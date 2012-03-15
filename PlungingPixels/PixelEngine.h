//
//  PixelEngine.h
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"
#import "Grid.h"
#import "TileQueue.h"


@interface PixelEngine : NSObject
@property (readonly, strong, nonatomic) NSMutableArray *objects;
@property (readonly, nonatomic) int timer;
@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) BOOL pause;
@property (readonly, nonatomic) BOOL quit;
@property (readonly, nonatomic) BOOL running;
@property (readonly, nonatomic) int width;
@property (readonly, nonatomic) int height;
@property (nonatomic) float tileWidth;
@property (nonatomic) float tileHeight;
@property (nonatomic) int tileLevel;
//@property (readonly, strong, nonatomic) Grid *board;

- (int) timer;

- (id) init;
- (void) start;
- (void) stop;
- (BOOL) running;
- (void) advance;

- (id) initWithRect: (CGRect) rect  andPicture: (int) picture;
- (void) step: (CFTimeInterval) intv;
- (void) addObject: (NSObject *) obj;
- (void) updateObjects: (int) gridIndex;
- (Tile *) tileAtGridIndex: (int) idx;
- (NSObject *) objectWithID: (int) objId;

@end


