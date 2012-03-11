//
//  Grid.m
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "Grid.h"

static int invaderBlack[] = {4,5,6,11,12,16,18,19,20,21,22,25,26,28,29,31,34,35,36,37,39,42,43,44,45,
                             50,51,52,53,55,57,58,60,61,63,64,66,67,68,69,70,75,76,84,85,86};
static int invaderWhite[] = {0,1,2,3,7,8,9,10,13,14,15,17,23,24,27,30,32,33,38,40,41,46,47,48,49,54,
                             56,59,62,65,71,72,73,74,77,78,79,80,81,82,83,87};

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

- (id) init: (int) pic
{
    self = [super init];

    if (pic == 0) {
        self.picture = pic;
        self.grid = [self spaceInvader];
    }
    
	if (self) {

	}
    
    return self;
}

- (Tile *) tileAtIndex: (int) idx
{
    return [self.grid objectAtIndex:idx];
}

- (BOOL) binarySearchOn: (int*) vals ofSize: (int) length finding: (int) test {
    int lo, mid, hi;
    lo = mid = 0;
    hi = length;

    while (lo < hi) {
        mid = (lo + hi) / 2;
        if (vals[mid] == test)
            break;
        else if (test > vals[mid])
            lo = mid + 1;
        else
            hi = mid;
    }
    return lo == hi ? NO : YES;
}

- (NSMutableArray *) spaceInvader
{
    self.rows = 11;
    self.columns = 8;
    NSMutableArray *invader = [[NSMutableArray alloc] initWithCapacity: PixelArrSize(self.rows, self.columns)];
    int blackSize = (sizeof invaderBlack) / (sizeof invaderBlack[0]);
    int whiteSize = (sizeof invaderWhite) / (sizeof invaderWhite[0]);
    BOOL setTile;
    
    //NSLog(@"grid tile numbers: %d", PixelArrSize(self.rows, self.columns));
    
    for(int i = 0; i < PixelArrSize(self.rows, self.columns); i++) {
        setTile = NO;
        if ([self binarySearchOn:invaderBlack ofSize: blackSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor blueColor] 
                                                andLevel:0 
                                                  filled:NO];
            [invader insertObject:addedTile atIndex:i];      
            setTile = YES;
        }
        else if ([self binarySearchOn:invaderWhite ofSize: whiteSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor blackColor] 
                                                andLevel:0 
                                                  filled:NO];
            [invader insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        
        if (setTile == NO) {
            NSLog(@"GRID HAVEN'T SET INDEX %d TILE", i);
        }
    }
    
    return invader;
}

@end
