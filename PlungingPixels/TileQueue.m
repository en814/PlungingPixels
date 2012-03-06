//
//  TileQueue.m
//  PlungingPixels
//
//  Created by Teal Owyang on 3/5/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "TileQueue.h"

static int invaderBlack[] = {2,8,14,18,24,25,26,27,28,29,30,34,35,37,38,39,41,42,44,45,46,47,48,
    49,50,51,52,53,54,55,57,58,59,60,61,62,63,65,66,68,74,76,80,81,83,84};
static int invaderWhite[] = {0,1,3,4,5,6,7,9,10,11,12,13,15,16,17,19,20,21,22,23,31,32,33,36,40,
    43,56,64,67,69,70,71,72,73,75,77,78,79,82,85,86,87};

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
                                                andLevel:0 
                                                  filled:NO];
            [invader insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        else if ([self binarySearchOn:invaderWhite ofSize:whiteSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor whiteColor] 
                                                andLevel:0 
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
