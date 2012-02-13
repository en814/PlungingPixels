//
//  Grid.h
//  PlungingPixels
//
//  Created by Ken Li on 2/12/12.
//  Copyright (c) 2012 Cal Poly San Luis Obispo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Grid : NSObject
@property (readonly, nonatomic) int difficulty;

- (id) init: withHeight: (int) h withWidth: (int) w;
@end

