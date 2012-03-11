//
//  Accelerometer.m
//  PlungingPixels
//
//  Created by Ken Li on 2/18/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "Accelerometer.h"

@interface Accelerometer ()

@property (readwrite, nonatomic) float valueX;
@property (readwrite, nonatomic) float valueY;
@property (readwrite, strong, nonatomic) IBOutlet PixelView *tile;

@end

@implementation Accelerometer

@synthesize valueX = _valueX;
@synthesize valueY = _valueY;
@synthesize tile = _tile;

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    self.valueX = acceleration.x*BALL_RADIUS;
    self.valueY = acceleration.y*BALL_RADIUS;
    //Adding comment here so we can test github commit and push :3
    int newX = (int)(self.tile.center.x + self.valueX);
    if(newX > 320 - BALL_RADIUS)
        newX = 320 - BALL_RADIUS;
    if (newX < 0 + BALL_RADIUS)
        newX= 0 + BALL_RADIUS;
    int newY = (int)(self.tile.center.y - self.valueY);
    if(newY > 460 - BALL_RADIUS)
        newY = 460 - BALL_RADIUS;
    if(newY < 0 + BALL_RADIUS)
        newY = 0 + BALL_RADIUS;
    
    CGPoint newCenter = CGPointMake(newX, newY);
    
    self.tile.center = newCenter;
    
    
}

- (void) initDraw 
{
    CGRect box = self.view.bounds;
    //resize rectangle
    box.size.width -= 400;
    box.size.height -= 400;
    box.origin.x += 100;
    box.origin.y += 100;
    self.tile = [[PixelView alloc] initWithFrame: box/*self.view.bounds*/];
    [self.view addSubview:self.tile];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //NSLog(@"I has been initialized\n");
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDraw];
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/30.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
