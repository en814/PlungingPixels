//
//  Tile.h
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Tile : UIView
@property (readonly, nonatomic) BOOL filled;
@property (readonly, nonatomic) UIColor color;
@property (readonly, nonatomic) int level;
@end