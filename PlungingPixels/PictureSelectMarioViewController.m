//
//  PictureSelectMarioViewController.m
//  PlungingPixels
//
//  Created by Teal Owyang on 3/14/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "PictureSelectMarioViewController.h"

@interface PictureSelectMarioViewController ()
@property (strong, nonatomic) PixelView *pixelView;
@end

@implementation PictureSelectMarioViewController
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
    
    self.pixelView.row = 16;
    self.pixelView.column = 12;
    
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
