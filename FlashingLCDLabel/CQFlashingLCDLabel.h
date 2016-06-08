//
//  CQFlashingLCDLabel.h
//  Cryptoquips
//
//  Created by Andrew King on 2014-08-21.
//
//

#import <UIKit/UIKit.h>

@interface CQFlashingLCDLabel : UILabel

- (void)setText:(NSString *)text withDuration:(NSTimeInterval)duration;

@end
