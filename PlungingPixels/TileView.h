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

@property (strong, nonatomic) TileQueue *queue;
@property (nonatomic) int row;
@property (nonatomic) int column;

@end
