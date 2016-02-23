//
//  ViewController.m
//  myMonkeyPinch
//
//  Created by Eduardo Alvarado Díaz on 2/17/16.
//  Copyright © 2016 personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize chompPlayer;
@synthesize hehePlayer;

- (AVAudioPlayer*)loadWav:(NSString*)filename {
    NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:@"wav"];
    NSError *error;
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!player) {
        NSLog(@"Error loading %@: %@", url, error.localizedDescription);
    }else {
        [player prepareToPlay];
    }
    return player;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    for (UIView *view in self.view.subviews) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        recognizer.delegate = self;
        [view addGestureRecognizer:recognizer];

        [recognizer requireGestureRecognizerToFail:self.monkeyPan];
        [recognizer requireGestureRecognizerToFail:self.bananaPan];

        TickleGestureRecognizer *recognizer2 = [[TickleGestureRecognizer alloc] initWithTarget:self action:@selector(handleTickle:)];
        recognizer2.delegate = self;
        [view addGestureRecognizer:recognizer2];
    }

    self.chompPlayer = [self loadWav:@"chomp"];
    self.hehePlayer = [self loadWav:@"hehehe1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {

    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity  = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        //NSLog(@"magnitude: %f, slideMult: %f",magnitude,slideMult);

        float slideFactor = 0.1 * slideMult; // increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);

        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
        } completion:nil];
    }
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

- (IBAction)handleRotate:(UIRotationGestureRecognizer *)recognizer {
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)handleTap:(UITapGestureRecognizer*)recognizer {
    [self.chompPlayer play];
}

- (void)handleTickle:(TickleGestureRecognizer *)recognizer {
    [self.hehePlayer play];
}

@end
