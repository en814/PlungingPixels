//
//  TileQueue.m
//  PlungingPixels
//
//  Created by Teal Owyang on 3/5/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "TileQueue.h"

@implementation TileQueue
@synthesize queue = _queue;

- (id) init: (int) picture
{
    self = [super init];
    
    if (picture == 0) {
        
    }
    
	if (self) {
        
	}
    
    return self;
}

- (void) reinsertTile
{
    int insertInto = arc4random() % [self.queue count];
    [self.queue exchangeObjectAtIndex:0 withObjectAtIndex:insertInto];
}

- (void) removeTile;
{
    [self.queue removeObjectAtIndex:0];
}

@end
