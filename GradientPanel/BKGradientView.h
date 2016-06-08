//
//  BKGradientView.h
//  Cryptoquips
//
//  Created by Andrew King on 2015-01-31.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BKGradientViewStyle) {
    BKGradientViewStyleLinearSide,
    BKGradientViewStyleLinearCorner,
    BKGradientViewStyleRadialCorner
};

/**
 Uses code from http://www.binpress.com/tutorial/learn-objectivec-building-an-app-part-8-/100.
 */
@interface BKGradientView : UIView

@property (nonatomic, assign) BKGradientViewStyle style;
@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, assign) CGFloat angle;

/**
 * Returns a view whose layer at index 0 is a linear gradient starting at the angle passed in. 0 represents the top.
 */
+ (instancetype)linearGradientViewSidePieceWithFrame:(CGRect)frame colors:(NSArray *)colors locations:(NSArray *)locations angle:(CGFloat)angle;

+ (instancetype)linearGradientViewCornerPieceWithFrame:(CGRect)frame colors:(NSArray *)colors locations:(NSArray *)locations angle:(CGFloat)angle;

+ (instancetype)radialGradientViewCornerPieceWithFrame:(CGRect)frame colors:(NSArray *)colors locations:(NSArray *)locations angle:(CGFloat)angle;

@end
