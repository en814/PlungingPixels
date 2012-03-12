//
//  TileQueue.m
//  PlungingPixels
//
//  Created by Teal Owyang on 3/5/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "TileQueue.h"

static int invaderBlack[] = {4,5,6,11,12,16,18,19,20,21,22,25,26,28,29,31,34,35,36,37,39,42,43,44,45,
                             50,51,52,53,55,57,58,60,61,63,64,66,67,68,69,70,75,76,84,85,86};
static int invaderWhite[] = {0,1,2,3,7,8,9,10,13,14,15,17,23,24,27,30,32,33,38,40,41,46,47,48,49,54,
                             56,59,62,65,71,72,73,74,77,78,79,80,81,82,83,87};

@interface TileQueue()
@property (nonatomic) int picture;
@end

@implementation TileQueue
@synthesize picture = _picture;
@synthesize queue = _queue;

- (id) init: (int) pic
{
    self = [super init];
    
    if (pic == 0) {
        self.picture = pic;
        self.queue = [self spaceInvader];
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

- (Tile *) tileAtIndex: (int) idx
{
    //NSLog(@"idx %d", idx);
    
    return [self.queue objectAtIndex:idx];
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
    NSMutableArray *invader = [[NSMutableArray alloc] initWithCapacity: PixelArrSize(8, 11)];
    int blackSize = (sizeof invaderBlack) / (sizeof invaderBlack[0]);
    int whiteSize = (sizeof invaderWhite) / (sizeof invaderWhite[0]);
    BOOL setTile;
    
    for(int i = 0; i < PixelArrSize(8, 11); i++) {
        setTile = NO;
        if ([self binarySearchOn:invaderBlack ofSize: blackSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor blackColor] 
                                                andLevel:TopLevel
                                                  filled:NO];
            [invader insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        else if ([self binarySearchOn:invaderWhite ofSize:whiteSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor blueColor] 
                                                andLevel:TopLevel
                                                  filled:NO];
            [invader insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        
        if (setTile == NO) {
            NSLog(@"HAVEN'T SET INDEX %d TILE", i);
        }
    }
    
    return invader;
}

@end
