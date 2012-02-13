//
//  Grid.m
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "Grid.h"

@interface Grid()
@property (strong, nonatomic) NSMutableArray *grid;
@property (nonatomic) int difficulty;
@end

@implementation Grid
@synthesize grid = _grid;
@synthesize difficulty = _difficulty;

- (id) init: withHeight: (int) h withWidth: (int) w
{
    return self;
}

@end
