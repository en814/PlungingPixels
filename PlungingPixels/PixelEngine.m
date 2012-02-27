//
//  PixelEngine.m
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "PixelEngine.h"

@interface PixelEngine()
@property (nonatomic) CGRect world;
@property (nonatomic) int timer, score; 
@property (strong, nonatomic) Grid *board;
@property (strong, nonatomic) NSMutableArray *tileQueue;
@property (strong, nonatomic) Tile *currTile;
@property (readwrite, strong, nonatomic) NSTimer *stepTimer;
@property (readwrite, nonatomic) BOOL running;
@property (nonatomic) BOOL gameOver;
@end

@implementation PixelEngine
@synthesize world = _world;
@synthesize timer = _timer;
@synthesize score = _score;
@synthesize pause = _pause;
@synthesize quit =_quit;
@synthesize board = _board;
@synthesize tileQueue = _tileQueue;
@synthesize currTile = _currTile;
@synthesize stepTimer = _stepTimer;
@synthesize gameOver = _gameOver;
@dynamic running;

- (id) init
{
    self = [super init];
	if (self) {
		srandom(time(0));
        self.board.grid = [[NSMutableArray alloc] initWithCapacity: PixelArrSize()];
        for(int i = 0; i < PixelArrSize(); i++)
            [self.board.grid addObject:[[Tile alloc] init:[UIColor whiteColor] filled:NO withLevel:0]];
	}
    
	return self;
}

- (void) start
{
    if (self.stepTimer)
        NSLog(@"and here");
    if (!self.stepTimer) {
        NSLog(@"and here");
        NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:0.0];
        self.stepTimer = [[NSTimer alloc] initWithFireDate:fireDate
                                                  interval:1.0
                                                    target:self
                                                  selector:@selector(advance)
                                                  userInfo:nil
                                                   repeats:YES];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addTimer:self.stepTimer forMode:NSDefaultRunLoopMode];
    }
}

- (void) stop
{
    if(self.stepTimer) 
    {
        [self.stepTimer invalidate];
        self.stepTimer = nil;
    }
}

- (BOOL) running
{
    if(self.stepTimer == nil)
        return NO;
    
    return YES;
}

- (id) initWithRect: (CGRect) rect {
    self = [super init];
    self.world = rect;
    
    self.board.grid = [[NSMutableArray alloc] initWithCapacity: PixelArrSize()];
    for(int i = 0; i < PixelArrSize(); i++)
        [self.board.grid addObject:[[Tile alloc] init:[UIColor whiteColor] filled:NO withLevel:0]];
    
    self.currTile = [[Tile alloc] init:[UIColor purpleColor] filled:FALSE withLevel:TopLevel];
    
    return self;
}

- (void) step {
    [self.currTile stepInRect: self.world];
}

- (void) addObject: (Tile *) tile {
    // update curTile with new color and toplevel
}

- (void) advance
{
	if (self.gameOver)
		return;
	
	self.timer = self.timer + 1;
}

@end
