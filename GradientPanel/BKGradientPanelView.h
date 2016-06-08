//
//  BKGradientPanelView.h
//  Cryptoquips
//
//  Created by Andrew King on 2015-02-11.
//
//

#import <UIKit/UIKit.h>

/**
 * This view uses 8 BKGradientViews (around the edges) and a center view.
 */
@interface BKGradientPanelView : UIView

- (instancetype)initWithFrame:(CGRect)frame borderWidth:(CGFloat)borderWidth edgeColor:(UIColor*)edgeColor innerColor:(UIColor*)innerColor;

- (void)configureWithBorderWidth:(CGFloat)borderWidth edgeColor:(UIColor *)edgeColor innerColor:(UIColor *)innerColor ;

@end
