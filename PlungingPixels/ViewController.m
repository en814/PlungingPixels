//
//  ViewController.m
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()
@property (readwrite, weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet PixelView *pixelView;
@property (weak, nonatomic) IBOutlet TileView *tileView;
@property (readwrite, nonatomic) CGRect box;

//Accelerometer.h
@property (readwrite, nonatomic) float valueX;
@property (readwrite, nonatomic) float valueY;
@property (nonatomic) CGPoint newCenter;

- (void) nextFrame: (CADisplayLink*) df;
@end

@implementation ViewController
@synthesize engine = _engine;
@synthesize timeLabel = _timeLabel;
@synthesize scoreLabel = _scoreLabel;
@synthesize pixelView = _pixelView;
@synthesize tileView = _tileView;
@synthesize box = _box;

@synthesize valueX = _valueX;
@synthesize valueY = _valueY;
@synthesize newCenter = _newCenter;
@synthesize tile = _tile;

- (void) nilObjects
{
    _timeLabel = nil;
    _scoreLabel = nil;
    _pixelView = nil;
    _tileView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.engine == nil)
        self.engine = [[PixelEngine alloc] initWithRect:self.view.bounds andPicture:0];
    [self.engine start];
    
    [self setupLabels];
    
    [self.tileView setFrame:self.box];
    
    self.newCenter = CGPointMake(160, 230);
    
    
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self nilObjects];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) nextFrame: (CADisplayLink*) df
{
    
}

- (void) setEngine:(PixelEngine *)eng
{
    [self view];
    _engine = eng;
    //[self destroyKVO];
    [self setupLabels];
}

- (void) refreshView
{
    [self updateGrid];
}

- (void) setupLabels
{    
    CGRect tileFrame;
    tileFrame.size.width = 16;
    tileFrame.size.height = 26;
    
    [self addKVO];
    
    Grid *picture = [self.engine.objects objectAtIndex:0];
    
    self.pixelView.row = picture.rows;
    self.pixelView.column = picture.columns;
    self.tileView.tileQueue = [self.engine.objects objectAtIndex:1];
    self.tileView.changeTile = YES;
    
    int frameWidth = self.pixelView.superview.frame.size.width;
    int frameHeight = self.pixelView.superview.frame.size.height;
    int level = ([[self.engine.objects objectAtIndex:1] tileAtIndex:0]).level;
    
    self.engine.tileWidth = (float)frameWidth / picture.columns;
    self.engine.tileHeight = (float)frameWidth / picture.columns;
    self.engine.tileLevel = level;
    
    self.newCenter = CGPointMake(frameWidth / self.engine.tileWidth, frameHeight / self.engine.tileHeight);
    
    float initWidth = self.engine.tileWidth * level;
    float initHeight = self.engine.tileHeight * level;
    
    int middleX = frameWidth / 2 - initWidth / 2;
    int middleY = frameHeight / 2 - initHeight / 2;
    NSLog(@"initializing x %d y %d", middleX, middleY);
    self.box = CGRectMake( middleX, middleY, initWidth, initHeight );
}

- (void) updateGrid
{    
    //NSLog(@"pixel array size %d", PixelArrSize([self.engine width], [self.engine height]));

    for(int row = 0; row < [self.engine height]; row++) {
        for(int column = 0; column < [self.engine width]; column++) {
            //NSLog(@"row %d column %d height %d width %d grid index: %d", row, column, [self.engine height], [self.engine width], PixelArrIdx(row, column, [self.engine width]));
            Tile *piece = [self.engine tileAtGridIndex:PixelArrIdx(row, column, [self.engine width])];
            
            if ([piece.color isEqual: [UIColor blueColor]])
                [self.pixelView setColor:[UIColor blueColor] forIndex:PixelArrIdx(row, column, [self.engine width])];
            else if ([piece.color isEqual: [UIColor blackColor]])
                [self.pixelView setColor:[UIColor blackColor] forIndex:PixelArrIdx(row, column, [self.engine width])];
        }
    }
}

- (void) addKVO
{
    [self.engine addObserver:self forKeyPath:@"score" 
                     options: (NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) 
                     context: nil];
    [self.engine addObserver:self forKeyPath:@"timer" 
                     options: (NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) 
                     context: nil];
    //[self.engine addObserver:self forKeyPath:@"gridVersion" 
      //               options: (NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) 
        //             context: nil];
}

- (void) destroyKVO
{
    [self.engine removeObserver:self forKeyPath:@"score"];
    [self.engine removeObserver:self forKeyPath:@"timer"];
    //[self.engine removeObserver:self forKeyPath:@"gridVersion"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(!self.engine)
        return;
    
    if([keyPath isEqualToString:@"score"]) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.engine.score];
    }
    if ([keyPath isEqualToString:@"timer"]) {
        //NSLog(@"-------------");
        self.timeLabel.text = [NSString stringWithFormat:@"%d", self.engine.timer];
        
        ([[self.engine.objects objectAtIndex:1] tileAtIndex:0]);
        
        CGRect rect = [self.tileView frame];
        
        int frameWidth = self.pixelView.superview.frame.size.width;
        int frameHeight = self.pixelView.superview.frame.size.height;
        
        float level = ([[self.engine.objects objectAtIndex:1] tileAtIndex:0]).level;
        
        float initWidth = self.engine.tileWidth * level;
        float initHeight = self.engine.tileHeight * level;
        
        // tile is still falling
        if (self.box.size.width >= self.engine.tileWidth && self.box.size.height >= self.engine.tileHeight) {
            rect.size.width -= self.engine.tileWidth / 2;
            rect.size.height -= self.engine.tileHeight / 2;
            
            /*
            if (self.newCenter.x - rect.size.width / 2 < 0  && self.newCenter.y - rect.size.height / 2 < 0) {
                rect.origin.x = frameWidth / 2 - rect.size.width / 2;
                rect.origin.y = frameHeight / 2 - rect.size.height / 2;
                NSLog(@"resetting to middle");
            }
            else {*/
                rect.origin.x = self.newCenter.x - rect.size.width / 2;      
                rect.origin.y = self.newCenter.y - rect.size.height / 2;
            //}
            //NSLog(@"newCenter x %f y %f", self.newCenter.x, self.newCenter.y);
            
            //NSLog(@"falling x %f y %f", rect.origin.x, rect.origin.y);
        }
        // tile has hit the grid
        else {
            rect.size.width = initWidth;
            rect.size.height = initHeight;
            
            rect.origin.x = frameWidth / 2 - rect.size.width / 2;
            rect.origin.y = frameHeight / 2 - rect.size.height / 2;
            //NSLog(@"reset x %f y %f", rect.origin.x, rect.origin.y);
            
            self.tileView.changeTile = YES;
        }
        
        self.box = rect;
        [self.tileView setNeedsDisplay];
        [self.tileView setFrame:rect];
        
        [self refreshView];
    }
    /*
    if([keyPath isEqualToString:@"gridVersion"])
    {
        [self refreshView];
    }
     */
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration 
{
    int xcol = self.pixelView.superview.frame.size.width / self.pixelView.column;
    int yrow = self.pixelView.superview.frame.size.height / self.pixelView.row;
    
    self.valueX = acceleration.x * xcol;
    self.valueY = acceleration.y * yrow;
 
    //Adding comment here so we can test github commit and push :3
    int gridColumn = (int)(((self.tileView.center.x + self.valueX) / xcol) + .5);
    
    if (gridColumn > self.pixelView.column - 1) {
        gridColumn = self.pixelView.column - 1;
    }

    int gridRow = (int)(((self.tileView.center.y - self.valueY) / yrow) + .5);
    
    if (gridRow > self.pixelView.row - 1) {
        gridRow = self.pixelView.row - 1;  
    }
    
    CGPoint newPoint = [[self.pixelView.gridOrigins objectAtIndex:PixelArrIdx(gridRow, gridColumn, self.pixelView.column)] CGPointValue];
    
    self.newCenter = newPoint;
    self.tileView.center = self.newCenter;
}

- (void) dealloc
{
    [self viewDidUnload];
}

@end
