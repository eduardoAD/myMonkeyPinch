//
//  TickleGestureRecognizer.h
//  myMonkeyPinch
//
//  Created by Eduardo Alvarado Díaz on 2/17/16.
//  Copyright © 2016 personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DirectionUnknown = 0,
    DirectionLeft,
    DirectionRight
} Direction;

@interface TickleGestureRecognizer : UIGestureRecognizer

@property (assign) int tickleCount;
@property (assign) CGPoint curTickleStart;
@property (assign) Direction lastDirection;

@end
