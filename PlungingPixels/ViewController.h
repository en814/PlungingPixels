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
#import "TileView.h"

#define BALL_RADIUS 20

@interface ViewController : UIViewController <UIAccelerometerDelegate>
@property (strong, nonatomic) PixelEngine *engine;

//Accelerometer
@property (readonly, nonatomic) float valueX;
@property (readonly, nonatomic) float valueY;
@property (readonly, strong, nonatomic) IBOutlet PixelView *tile;

@end
