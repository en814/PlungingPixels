//
//  PictureSelectSpaceInvaderViewController.m
//  PlungingPixels
//
//  Created by Ken Li on 3/13/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "PictureSelectSpaceInvaderViewController.h"

@interface PictureSelectSpaceInvaderViewController ()
@property (strong, nonatomic) PixelView *pixelView;
@end

@implementation PictureSelectSpaceInvaderViewController
@synthesize pixelView = _pixelView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.pixelView.row = 11;
    self.pixelView.column = 8;

    self.pixelView.grid = [[Grid alloc] init:1];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
