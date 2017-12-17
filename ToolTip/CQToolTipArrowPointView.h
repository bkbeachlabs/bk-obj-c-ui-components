//
//  CQToolTipArrowPointView.h
//  Cryptoquips
//
//  Created by Andrew King on 2016-01-27.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CQToolTipArrowDirection) {
    CQToolTipArrowDirectionTop,
    CQToolTipArrowDirectionRight,
    CQToolTipArrowDirectionBottom,
    CQToolTipArrowDirectionLeft
};

@interface CQToolTipArrowPointView : UIView

@property (nonatomic, assign) CQToolTipArrowDirection arrowDirection;

@property (nonatomic, strong) UIColor *fillColor;

@end
