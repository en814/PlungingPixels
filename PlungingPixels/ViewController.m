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
@property (weak, nonatomic) IBOutlet PixelView *pixelView;
@property (weak, nonatomic) IBOutlet TileView *tileView;
@property (nonatomic) CGRect box;
@property (nonatomic) int gridRow;
@property (nonatomic) int gridColumn;

//Accelerometer.h
@property (readwrite, nonatomic) float valueX;
@property (readwrite, nonatomic) float valueY;
@property (nonatomic) CGPoint newCenter;
@property (nonatomic) float distanceX;
@property (nonatomic) float distanceY;

- (void) nextFrame: (CADisplayLink*) df;
@end

@implementation ViewController
@synthesize engine = _engine;
@synthesize timeLabel = _timeLabel;
@synthesize pixelView = _pixelView;
@synthesize tileView = _tileView;
@synthesize box = _box;
@synthesize gridRow = _gridRow;
@synthesize gridColumn = _gridColumn;

@synthesize valueX = _valueX;
@synthesize valueY = _valueY;
@synthesize newCenter = _newCenter;
@synthesize tile = _tile;
@synthesize distanceX = _distanceX;
@synthesize distanceY = _distanceY;

- (void) nilObjects
{
    _timeLabel = nil;
    _pixelView = nil;
    _tileView = nil;
    _tile = nil;
    [_engine stop];
    _engine = nil;
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
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/5.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    NSLog(@"LOVEY DOVEY!");
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
    self.tileView.transform = CGAffineTransformMakeTranslation(self.engine.tileWidth / 2, self.engine.tileHeight / 2);
    
    int frameWidth = self.pixelView.superview.frame.size.width;
    int frameHeight = self.pixelView.superview.frame.size.height;
    int level = ([[self.engine.objects objectAtIndex:1] tileAtIndex:0]).level;
    
    self.engine.tileWidth = (float)frameWidth / picture.columns;
    self.engine.tileHeight = (float)frameHeight / picture.rows;
    
    self.engine.tileLevel = level;
    
    self.newCenter = CGPointMake(frameWidth / self.engine.tileWidth, frameHeight / self.engine.tileHeight);
    
    float initWidth = self.engine.tileWidth * level;
    float initHeight = self.engine.tileHeight * level;
    
    int middleX = frameWidth / 2 - initWidth / 2;
    int middleY = frameHeight / 2 - initHeight / 2;

    self.box = CGRectMake( middleX, middleY, initWidth, initHeight );
}

- (void) updateGrid
{
    for(int row = 0; row < [self.engine height]; row++) {
        for(int column = 0; column < [self.engine width]; column++) {
            Tile *piece = [self.engine tileAtGridIndex:PixelArrIdx(row, column, [self.engine width])];
            
            if ([piece.color isEqual: [UIColor colorWithRed:.196078 green:.6 blue:.8 alpha:1] ])
                [self.pixelView setColor:[UIColor colorWithRed:.196078 green:.6 blue:.8 alpha:1] forIndex:PixelArrIdx(row, column, [self.engine width])];
            else if ([piece.color isEqual: [UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1]])
                [self.pixelView setColor:[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1] forIndex:PixelArrIdx(row, column, [self.engine width])];
        }
    }
}

- (void) addKVO
{
    [self.engine addObserver:self forKeyPath:@"timer" 
                     options: (NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) 
                     context: nil];
}

- (void) destroyKVO
{
    [self.engine removeObserver:self forKeyPath:@"timer"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(!self.engine)
        return;
    
    if ([keyPath isEqualToString:@"timer"]) {
        self.timeLabel.text = [NSString stringWithFormat:@"%d", self.engine.timer];
        
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
            
            rect.origin.x = self.newCenter.x - rect.size.width / 2;      
            rect.origin.y = self.newCenter.y - rect.size.height / 2;
        }
        // tile has hit the grid
        else {
            //NSLog(@"gridRow %d, gridColumn %d", self.gridRow, self.gridColumn);
            [self.engine updateObjects:PixelArrIdx(self.gridRow, self.gridColumn, [[self.engine.objects objectAtIndex:0] columns])];
            
            self.pixelView.grid = [self.engine.objects objectAtIndex:0];
            
            rect.size.width = initWidth;
            rect.size.height = initHeight;
            
            rect.origin.x = frameWidth / 2 - rect.size.width / 2;
            rect.origin.y = frameHeight / 2 - rect.size.height / 2;
            
            self.tileView.changeTile = YES;
            [self.pixelView setNeedsDisplay];
        }
        
        self.box = rect;
        
        [self.tileView setNeedsDisplay];
        [self.tileView setFrame:rect];
        
        [self refreshView];
    }
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration 
{
    self.valueX = acceleration.x * self.engine.tileWidth;
    self.valueY = acceleration.y * self.engine.tileHeight;

    self.gridColumn = (int)((self.tileView.center.x / self.engine.tileWidth) + .5);
    
    if (acceleration.x > 0) {
        self.gridColumn += 1;   
    }
    else {
        self.gridColumn -= 1;
        if (self.gridColumn < 1) 
            self.gridColumn = 1;
    }
    
    if (self.gridColumn > self.pixelView.column - 1) {
        self.gridColumn = self.pixelView.column - 1;
    }

    self.gridRow = (int)((self.tileView.center.y/ self.engine.tileHeight) + .5);
    
    if (acceleration.y > 0) {
        self.gridRow -= 1; 
        if (self.gridRow < 1) 
            self.gridRow = 1;
    }
    else {
        self.gridRow += 1;
    }
    
    if (self.gridRow > self.pixelView.row - 1) {
        self.gridRow = self.pixelView.row - 1;  
    }
    
    self.newCenter = [[self.pixelView.gridOrigins objectAtIndex:PixelArrIdx(self.gridRow, self.gridColumn, self.pixelView.column)] CGPointValue];
    
    self.tileView.center = self.newCenter;
    
}

- (void) dealloc
{
    [self viewDidUnload];
}

@end
