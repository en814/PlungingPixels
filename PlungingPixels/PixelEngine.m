//
//  PixelEngine.m
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "PixelEngine.h"

@interface PixelEngine()
@property (strong, nonatomic) NSMutableArray *objects;
@property (nonatomic) CGRect world;
@property (nonatomic) int timer, score, width, height;
@property (readwrite, strong, nonatomic) NSTimer *stepTimer;
@property (readwrite, nonatomic) BOOL running;
@property (nonatomic) BOOL gameOver;
@end

@implementation PixelEngine
@synthesize objects = _objects;
@synthesize world = _world;
@synthesize timer = _timer;
@synthesize score = _score;
@synthesize pause = _pause;
@synthesize quit =_quit;
@synthesize stepTimer = _stepTimer;
@synthesize gameOver = _gameOver;
@synthesize width = _width;
@synthesize height = _height;
@synthesize tileWidth = _tileWidth;
@synthesize tileHeight = _tileHeight;
@synthesize tileLevel = _tileLevel;
@dynamic running;

- (id) init
{
    self = [super init];
	if (self) {
		srandom(time(0));
        //self.board.grid = [[NSMutableArray alloc] initWithCapacity: PixelArrSize()];
        //for(int i = 0; i < PixelArrSize(); i++)
        //    [self.board.grid addObject:[[Tile alloc] init:[UIColor whiteColor] filled:NO withLevel:0]];
	}
    
	return self;
}

- (void) start
{
    if (!self.stepTimer) {
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

- (void) advance
{
	if (self.gameOver)
		return;
	
	self.timer = self.timer + 1;
}

- (id) initWithRect: (CGRect) rect andPicture: (int) picture
{
    self = [super init];
    self.world = rect;
    self.objects = [[NSMutableArray alloc] init];
    
    Grid *grid = [[Grid alloc] init:picture];
    self.width = grid.columns;
    self.height = grid.rows;
    
    //self.tileWidth =
    TileQueue *tileQueue = [[TileQueue alloc] init:picture];
    
    [self.objects addObject:grid];
    [self.objects addObject:tileQueue];
    
    return self;
}

- (void) step: (CFTimeInterval) intv 
{
    //for (NSObject *obj in self.objects)
    //    [obj stepInRect:self.world withInterval:intv];
    //[self.currTile stepInRect: self.world];
}

- (void) updateObjects: (int) gridIndex
{
    // if falling tile is the same color as the grid its over
    if ([[[[self.objects objectAtIndex:1] tileAtIndex:0] color] isEqual:[[self.objects objectAtIndex:0] tileAtIndex:gridIndex]]) {
        if ([[self.objects objectAtIndex:0] picture] == 0) {
            // if its blue
            if ([[[self.objects objectAtIndex:0] tileAtIndex:gridIndex].color isEqual:[UIColor colorWithRed:.196078 green:.6 blue:.8 alpha:1]]) {
                [[self.objects objectAtIndex:0] setTileAtIndex:gridIndex toColor:[UIColor blueColor]];
            }
            // if its grey
            else if ([[[self.objects objectAtIndex:0] tileAtIndex:gridIndex].color isEqual:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1]]) {
                [[self.objects objectAtIndex:0] setTileAtIndex:gridIndex toColor:[UIColor blackColor]];
            }
        }
        
        [[self.objects objectAtIndex:1] removeTile];
    }
    // falling tile is NOT the same color as the grid its over
    else {
        [[self.objects objectAtIndex:1] reinsertTile];
       
    }
}

- (void) addObject: (NSObject *) tile {
    // update curTile with new color and toplevel
}

- (Tile *) tileAtGridIndex: (int) idx
{
    return [[self.objects objectAtIndex:0] tileAtIndex:idx];
}

- (NSObject *) objectWithID: (int) objId
{
    return [[NSObject alloc] init];
}

-(void)dealloc {
    _objects = nil;
    _timer = 0;
    _score = 0;
    _quit = 0;
    _pause = 0;
    [_stepTimer invalidate];
    _stepTimer = nil;
    _gameOver = 0;
    _width = 0;
    _height = 0;
    _tileWidth = 0;
    _tileHeight = 0;
    _tileLevel = 0;
}

@end
