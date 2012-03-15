//
//  MainMenuViewController.m
//  PlungingPixels
//
//  Created by Teal Owyang on 3/14/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import "MainMenuViewController.h"

@interface MainMenuViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@end

@implementation MainMenuViewController
@synthesize backgroundImage = _backgroundImage;

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
    UIImage *image = [UIImage imageNamed: @"plungepixmenu.png"];
    [self.backgroundImage setImage:image];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    [_backgroundImage stopAnimating];
    _backgroundImage = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc {
    [_backgroundImage stopAnimating];
    _backgroundImage = nil;
}
@end
