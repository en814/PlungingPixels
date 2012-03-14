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

static int marioBlack[] = {0,1,2,8,9,10,11,12,13,23,24,25,32,33,34,35,36,47,48,60,71,72,73,74,82,83,
    84,85,92,93,94,95,96,107,156,157,161,162,166,167,168,172,173,174,175,179,
    184,185,186,187};
static int marioRed[] = {3,4,5,6,7,14,15,16,17,18,19,20,21,22,88,100,103,112,113,114,115,123,125,126,
    128,135,136,137,138,139,140,146,147,148,149,150,151,152,153,158,159,160,163,
    164,165};
static int marioBrown[] = {26,27,28,31,37,39,43,49,51,52,56,61,62,67,68,69,70,86,87,89,90,91,97,98,99,
    101,102,104,105,106,108,109,110,111,116,117,118,119,122,129,169,170,171,
    176,177,178,180,181,182,183,188,189,190,191};
static int marioYellow[] = {29,30,38,40,41,42,44,45,46,50,53,54,55,57,58,59,63,64,65,66,75,76,77,78,
    79,80,81,120,121,124,127,130,131,132,133,134,141,142,143,144,145,154,155};


@interface TileQueue()
@property (nonatomic) int picture;
@end

@implementation TileQueue
@synthesize picture = _picture;
@synthesize queue = _queue;

- (id) init: (int) pic
{
    self = [super init];
    
    self.picture = pic;
    
    if (pic == 0) {
        self.queue = [self spaceInvader];
    }
    else if (pic == 1) {
        self.queue = [self spaceInvaderComplete];
    }
    else if (pic == 2) {
        self.queue = [self mario];
    }
    else if (pic == 3) {
        self.queue = [self marioComplete];
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
    NSMutableArray *invader = [[NSMutableArray alloc] initWithCapacity: PixelArrSize(11, 8)];
    int blackSize = (sizeof invaderBlack) / (sizeof invaderBlack[0]);
    int whiteSize = (sizeof invaderWhite) / (sizeof invaderWhite[0]);
    BOOL setTile;
    
    for(int i = 0; i < PixelArrSize(8, 11); i++) {
        setTile = NO;
        if ([self binarySearchOn:invaderBlack ofSize: blackSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor colorWithRed:.196078 green:.6 blue:.8 alpha:1]
                                                andLevel:TopLevel
                                                  filled:NO];
            [invader insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        else if ([self binarySearchOn:invaderWhite ofSize:whiteSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1] 
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

- (NSMutableArray *) spaceInvaderComplete
{
    NSMutableArray *invader = [[NSMutableArray alloc] initWithCapacity: PixelArrSize(11, 8)];
    int blackSize = (sizeof invaderBlack) / (sizeof invaderBlack[0]);
    int whiteSize = (sizeof invaderWhite) / (sizeof invaderWhite[0]);
    BOOL setTile;
    
    for(int i = 0; i < PixelArrSize(8, 11); i++) {
        setTile = NO;
        if ([self binarySearchOn:invaderBlack ofSize: blackSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor blueColor]
                                                andLevel:TopLevel
                                                  filled:NO];
            [invader insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        else if ([self binarySearchOn:invaderWhite ofSize:whiteSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor blackColor] 
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
                      
- (NSMutableArray * ) mario
{            
    
    NSMutableArray *marioArray = [[NSMutableArray alloc] initWithCapacity: PixelArrSize(16, 12)];
    int blackSize = (sizeof marioBlack) / (sizeof marioBlack[0]);
    int redSize = (sizeof marioRed) / (sizeof marioRed[0]);
    int brownSize = (sizeof marioBrown) / (sizeof marioBrown[0]);
    int yellowSize = (sizeof marioYellow) / (sizeof marioYellow[0]);
    BOOL setTile;
    
    for(int i = 0; i < PixelArrSize(16, 12); i++) {
        setTile = NO;
        if ([self binarySearchOn:marioBlack ofSize: blackSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor colorWithRed:.6 green:.6 blue:.6 alpha:1] 
                                                andLevel:0 
                                                  filled:NO];
            [marioArray insertObject:addedTile atIndex:i];      
            setTile = YES;
        }
        else if ([self binarySearchOn:marioRed ofSize: redSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor colorWithRed:.5 green:0 blue:0 alpha:1] 
                                                andLevel:0 
                                                  filled:NO];
            [marioArray insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        else if ([self binarySearchOn:marioBrown ofSize: brownSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor colorWithRed:.7 green:.5 blue:.3 alpha:1] 
                                                andLevel:0 
                                                  filled:NO];
            [marioArray insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        else if ([self binarySearchOn:marioYellow ofSize: yellowSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor colorWithRed:.95686 green:.64314 blue:.37647 alpha:1] 
                                                andLevel:0 
                                                  filled:NO];
            [marioArray insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        
        if (setTile == NO) {
            NSLog(@"GRID HAVEN'T SET INDEX %d TILE", i);
        }
        
    }
    
    return marioArray;
}

- (NSMutableArray * ) marioComplete
{            
    
    NSMutableArray *marioArray = [[NSMutableArray alloc] initWithCapacity: PixelArrSize(16, 12)];
    int blackSize = (sizeof marioBlack) / (sizeof marioBlack[0]);
    int redSize = (sizeof marioRed) / (sizeof marioRed[0]);
    int brownSize = (sizeof marioBrown) / (sizeof marioBrown[0]);
    int yellowSize = (sizeof marioYellow) / (sizeof marioYellow[0]);
    BOOL setTile;
    
    for(int i = 0; i < PixelArrSize(16, 12); i++) {
        setTile = NO;
        if ([self binarySearchOn:marioBlack ofSize: blackSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor colorWithRed:.3 green:.3 blue:.3 alpha:1] 
                                                andLevel:0 
                                                  filled:NO];
            [marioArray insertObject:addedTile atIndex:i];      
            setTile = YES;
        }
        else if ([self binarySearchOn:marioRed ofSize: redSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor redColor] 
                                                andLevel:0 
                                                  filled:NO];
            [marioArray insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        else if ([self binarySearchOn:marioBrown ofSize: brownSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor brownColor] 
                                                andLevel:0 
                                                  filled:NO];
            [marioArray insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        else if ([self binarySearchOn:marioYellow ofSize: yellowSize finding:i]) {
            Tile *addedTile = [[Tile alloc] initWithType:0 
                                                andColor:[UIColor colorWithRed:.9 green:.64706 blue:0 alpha:1] 
                                                andLevel:0 
                                                  filled:NO];
            [marioArray insertObject:addedTile atIndex:i];
            setTile = YES;
        }
        
        if (setTile == NO) {
            NSLog(@"GRID HAVEN'T SET INDEX %d TILE", i);
        }
        
    }
    
    return marioArray;
}


@end
