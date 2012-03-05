//
//  Grid.m
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "Grid.h"

@interface Grid()
@property (nonatomic) int picture;
@property (nonatomic) int difficulty;
@property (nonatomic) int rows, columns;
@end

@implementation Grid
@synthesize picture = _picture;
@synthesize grid = _grid;
@synthesize difficulty = _difficulty;
@synthesize rows = _rows;
@synthesize columns = _columns;

- (id) init: (int) picture
{
    self = [super init];

    if (picture == 0) {
        
    }
    
	if (self) {

	}
    
    return self;
}
/*
- (NSMutableArray *) spaceInvader
{
    self.rows = 8;
    self.columns = 11;
    NSMutableArray *invader = [[NSMutableArray alloc] initWithCapacity: self.rows * self.columns];
    
    for(int i = 0; i < PixelArrIdx(self.rows, self.columns); i++)
        [self.colorGrid addObject: [UIColor whiteColor]];
}
*/
@end
