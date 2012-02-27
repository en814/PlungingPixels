//
//  ViewController.h
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <QuartzCore/CADisplayLink.h>
#import <UIKit/UIKit.h>
#import "Tile.h"
#import "PixelEngine.h"
#import "PixelView.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) PixelEngine *engine;
@end
