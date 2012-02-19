//
//  Accelerometer.h
//  PlungingPixels
//
//  Created by Ken Li on 2/18/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BALL_RADIUS 25

@interface Accelerometer : UIViewController <UIAccelerometerDelegate> {
    IBOutlet UIImageView *ball;
    float valueX;
    float valueY;
}

@end
