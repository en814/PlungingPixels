//
//  Tile.h
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TopLevel 10
#define PixelNumRows 32
#define PixelNumCols 32
#define PixelArrSize(row, col) ( row * col )
#define PixelArrIdx(row, col) ( (row) * PixelNumCols + (col) * PixelNumRows )

@interface Tile : NSObject
@property (readonly, strong, nonatomic) UIColor *color;
@property (readonly, nonatomic) BOOL filled;
@property (readonly, nonatomic) int level;
@property (readonly, nonatomic) int type;
@property (nonatomic) CGRect location;
@property (nonatomic) CGPoint velocity, acceleration;

- (id) initWithType: (int) ty 
           andColor: (UIColor*) color
           andLevel: (int) level
             filled: (BOOL) filled;
- (id) initWithLocation: (CGRect) loc;
- (void) stepInRect: (CGRect) rect withInterval: (CFTimeInterval) intv;


@end