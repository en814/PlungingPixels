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
@property (nonatomic) CGRect box;

//Accelerometer.h
@property (readwrite, nonatomic) float valueX;
@property (readwrite, nonatomic) float valueY;

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
    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/2.0];
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
    
    float initWidth = self.engine.tileWidth * level;
    float initHeight = self.engine.tileHeight * level;
    
    int middleX = frameWidth / 2 - initWidth / 2;
    int middleY = frameHeight / 2 - initHeight / 2;
    
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
        if (rect.size.width >= self.engine.tileWidth && rect.size.height >= self.engine.tileHeight) {
            rect.size.width -= self.engine.tileWidth / 2;
            rect.size.height -= self.engine.tileHeight / 2;
        }
        // tile has hit the grid
        else {
            rect.size.width = initWidth;
            rect.size.height = initHeight;
            self.tileView.changeTile = YES;
        }
        
        rect.origin.x = frameWidth / 2 - rect.size.width / 2;
        rect.origin.y = frameHeight / 2 - rect.size.height / 2;
        
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
    int xcol = 320 / self.pixelView.column;
    int yrow = 460 / self.pixelView.row;
    
    self.valueX = acceleration.x * xcol;
    self.valueY = acceleration.y * yrow;
 
    //NSLog(@"Before X: %f", self.tileView.center.x);
    //NSLog(@"Before Y: %f", self.tileView.center.y);
    //NSLog(@"Acceleration X: %f", acceleration.x);
    //NSLog(@"Acceleration Y: %f", acceleration.y);
    //NSLog(@"Column X: %d", xcol);
    //NSLog(@"Row Y: %d", yrow);
    //Move in the x direction
 
    //Adding comment here so we can test github commit and push :3
    int newX = (int)(((self.tileView.center.x + self.valueX) / xcol) * xcol);
    
    if (newX > 320 - xcol)
        newX = 320 - xcol;
    if (newX < 0 + xcol)
        newX= 0 + xcol;
    
    int newY = (int)(((self.tileView.center.y - self.valueY) / yrow) * yrow);
    
    if (newY > 460 - yrow)
        newY = 460 - yrow;
    if (newY < 0 + yrow)
        newY = 0 + yrow;
    
    CGPoint newCenter = CGPointMake(newX, newY);
    //NSLog(@"After X : %d", newX);
    //NSLog(@"After Y : %d", newY);
    
    self.tileView.center = newCenter;
}

- (void) dealloc
{
    [self viewDidUnload];
}

@end
