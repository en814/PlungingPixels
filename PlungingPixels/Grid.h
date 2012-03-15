//
//  Grid.h
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"

@interface Grid : NSObject

@property (readonly, nonatomic) int picture;
@property (strong, nonatomic) NSMutableArray *grid;
@property (readonly, nonatomic) int difficulty;
@property (readonly, nonatomic) int rows, columns;

- (id) init: (int) picture;
- (Tile *) tileAtIndex: (int) idx;
- (void) setTileAtIndex: (int) idx toColor: (UIColor*) color;

@end