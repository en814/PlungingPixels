//
//  Tile.h
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TopLevel 10

@interface Tile : NSObject
@property (readonly, strong, nonatomic) UIColor *color;
@property (readonly, nonatomic) BOOL filled;
@property (readonly, nonatomic) int level;
@property (readonly, nonatomic) int type, objId;
@property (nonatomic) CGRect location;

- (id) init: (UIColor*) color filled: (BOOL) filled withLevel: (int) level;
- (void) stepInRect: (CGRect) rect;
- (id) initWithType: (int) ty andLocation: (CGRect) loc;
@end