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

- (void) nextFrame: (CADisplayLink*) df;
@end

@implementation ViewController
@synthesize engine = _engine;
@synthesize timeLabel = _timeLabel;
@synthesize scoreLabel = _scoreLabel;
@synthesize pixelView = _pixelView;
@synthesize tileView = _tileView;

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
        //self.engine = [[PixelEngine alloc] init];
        self.engine = [[PixelEngine alloc] initWithRect:self.view.bounds andPicture:0];
    [self.engine start];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) nextFrame: (CADisplayLink*) df
{
    
}

- (void) updateGrid
{
    for(int column = 0; column < [self.engine width]; column++) {
        for(int row = 0; row < [self.engine height]; row++) {
            Tile *piece = [self.engine tileAtGridIndex:PixelArrIdx(row, column)];
            
            if (piece.color == [UIColor blackColor]) {
                
            }
        }
    }
    /*
    for(int column = 0; column < [self.engine width]; column++) {
        for(int row = 0; row < [self.engine height]; row++) {
            int piece = [self.engine pieceAtRow:row column:column];
            if(piece == NoTetromino) {
                [self.tetrisView setColor:[UIColor whiteColor] forRow:11-row column:column];
                //[[self.gridLabels objectAtIndex: TetrisArrIdx(row, column)] setText: @"."];
            }
            else if (piece  == ITetromino) {
                [self.tetrisView setColor:[UIColor cyanColor] forRow:11-row column:column];
                //[[self.gridLabels objectAtIndex: TetrisArrIdx(row, column)] setText: @"X"];
            }
            else if (piece == JTetromino) {
                [self.tetrisView setColor:[UIColor blueColor] forRow:11-row column:column];
            }
            else if (piece == LTetromino) {
                [self.tetrisView setColor:[UIColor orangeColor] forRow:11-row column:column];
            }
            else if (piece == OTetromino) {
                [self.tetrisView setColor:[UIColor yellowColor] forRow:11-row column:column];
            }
            else if (piece == STetromino) {
                [self.tetrisView setColor:[UIColor greenColor] forRow:11-row column:column];
            }
            else if (piece == TTetromino) {
                [self.tetrisView setColor:[UIColor purpleColor] forRow:11-row column:column];
            }
            else if (piece == ZTetromino) {
                [self.tetrisView setColor:[UIColor redColor] forRow:11-row column:column];
            }
        }
    }
     */
}

- (void) refreshView
{
    [self updateGrid];
}


- (void) dealloc
{
    [self viewDidUnload];
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

- (void) setupLabels
{    
    CGRect tileFrame;
    tileFrame.size.width = 16;
    tileFrame.size.height = 26;
    NSLog(@"Column: %f\n", tileFrame.size.width);
    NSLog(@"Row: %f\n", tileFrame.size.height);
    
    //self.pixelView.row = self.engine.board.rows;
    //self.pixelView.column = self.engine.board.columns;
    //self.tileView.row = self.engine.board.rows;
    //self.tileView.column = self.engine.board.columns;
    
    [self addKVO];
}

- (void) setEngine:(PixelEngine *)eng
{
    NSLog(@"setting engine");
    [self view];
    _engine = eng;
    //[self destroyKVO];
    [self addKVO];
    //[self setupLabels];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(!self.engine)
        return;
    
    if([keyPath isEqualToString:@"score"])
    {
        self.scoreLabel.text = [NSString stringWithFormat:@"%d", self.engine.score];
    }
    if ([keyPath isEqualToString:@"timer"]) 
    {
        self.timeLabel.text = [NSString stringWithFormat:@"%d", self.engine.timer];
    }
    /*
    if([keyPath isEqualToString:@"gridVersion"])
    {
        [self refreshView];
    }
     */
}

@end
