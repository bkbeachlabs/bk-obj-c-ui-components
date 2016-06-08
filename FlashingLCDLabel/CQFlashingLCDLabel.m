//
//  CQFlashingLCDLabel.m
//  Cryptoquips
//
//  Created by Andrew King on 2014-08-21.
//
//

#import "CQFlashingLCDLabel.h"

@implementation CQFlashingLCDLabel

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)setText:(NSString *)text withDuration:(NSTimeInterval)duration {
    
    [UIView animateWithDuration:duration*0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^() {
        //1. Collapse
        self.transform = CGAffineTransformMakeScaleTranslate(0.6f, 0.4f, 0.3f, 0.2f);
        self.alpha = 0.4f;
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:duration*0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^() {
            //2. Fade
            self.alpha = 0.2f;
            self.transform = CGAffineTransformMakeScaleTranslate(0, 0, 0.5f, 0.5f);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^() {
                //3. Update Value
                self.text = text;
                
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:duration*0.15 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^() {
                    //4. Grow
                    self.transform = CGAffineTransformMakeScaleTranslate(1.4f, 0.2f, 0.4f, 0.1f);
                    self.alpha = 0.5;

                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:duration*0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^() {
                        //5. Fade In
                        self.alpha = 0.7f;
                        self.transform = CGAffineTransformMakeScaleTranslate(1, 1, 0, 0);
                        
                    }completion:nil];
                }];
            }];
        }];
    }];
}

static inline CGAffineTransform CGAffineTransformMakeScaleTranslate(CGFloat sx, CGFloat sy, CGFloat dx, CGFloat dy) {
    return CGAffineTransformMake(sx, 0.f, 0.f, sy, dx, dy);
}

@end
