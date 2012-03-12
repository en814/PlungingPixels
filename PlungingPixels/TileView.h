//
//  TileView.h
//  PlungingPixels
//
//  Created by Teal Owyang on 3/5/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileQueue.h"

@interface TileView : UIView

@property (strong, nonatomic) TileQueue *tileQueue;
@property (nonatomic) BOOL changeTile;

- (void) setColor: (UIColor *) color forIndex: (int) idx;
- (void) setOpacity: (float) alpha;

@end
