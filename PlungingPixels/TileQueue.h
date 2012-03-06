//
//  TileQueue.h
//  PlungingPixels
//
//  Created by Teal Owyang on 3/5/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TileQueue : NSObject

@property (strong, nonatomic) NSMutableArray *queue;

- (id) init: (int) picture;
- (void) reinsertTile;
- (void) removeTile;

@end
