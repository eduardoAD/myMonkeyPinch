//
//  ViewController.h
//  myMonkeyPinch
//
//  Created by Eduardo Alvarado Díaz on 2/17/16.
//  Copyright © 2016 personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "TickleGestureRecognizer.h"

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong) AVAudioPlayer* chompPlayer;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *monkeyPan;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *bananaPan;
@property (strong) AVAudioPlayer* hehePlayer;

- (IBAction)handlePan:(UIPanGestureRecognizer*)recognizer;
- (IBAction)handlePinch:(UIPinchGestureRecognizer*)recognizer;
- (IBAction)handleRotate:(UIRotationGestureRecognizer*)recognizer;
- (void)handleTickle:(TickleGestureRecognizer*)recognizer;

@end

