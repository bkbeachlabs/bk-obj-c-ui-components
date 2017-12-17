//
//  BKGradientPanelView.m
//  Cryptoquips
//
//  Created by Andrew King on 2015-02-11.
//
//

#import "BKGradientPanelView.h"
#import "BKGradientView.h"

@implementation BKGradientPanelView {
    BOOL _isSetup;
    
    CGRect _frame;
    CGFloat _borderWidth;
    UIColor *_edgeColor;
    UIColor *_innerColor;
    
    BKGradientView *_upperLeft;
    BKGradientView *_upperMiddle;
    BKGradientView *_upperRight;
    BKGradientView *_middleRight;
    BKGradientView *_bottomRight;
    BKGradientView *_bottomMiddle;
    BKGradientView *_bottomLeft;
    BKGradientView *_middleLeft;
    UIView *_middle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame borderWidth:(CGFloat)borderWidth edgeColor:(UIColor*)edgeColor innerColor:(UIColor*)innerColor {
    if (self = [super initWithFrame:frame]) {
        _isSetup = YES;
        
        _frame = frame;
        [self configureWithBorderWidth:borderWidth edgeColor:edgeColor innerColor:innerColor];
    }
    return self;
}

- (void)configureWithBorderWidth:(CGFloat)borderWidth edgeColor:(UIColor *)edgeColor innerColor:(UIColor *)innerColor {
    _borderWidth = borderWidth;
    _edgeColor = edgeColor;
    _innerColor = innerColor;
    
    [self setupGradientWithBorderWidth:borderWidth edgeColor:edgeColor innerColor:innerColor];
}

- (void)setFrame:(CGRect)frame {
    _frame = frame;
    [super setFrame:frame];
    
    if (_isSetup) {
        [self updateGradientViewFramesForFrame:frame];
    }
//    [self setNeedsDisplay];
}


- (void)setupGradientWithBorderWidth:(CGFloat)borderGradientWidth
                           edgeColor:(UIColor *)edgeColor
                          innerColor:(UIColor *)innerColor {
    
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    
    _upperLeft = [BKGradientView radialGradientViewCornerPieceWithFrame:CGRectMake(0, 0, borderGradientWidth, borderGradientWidth) colors:@[edgeColor, innerColor] locations:@[@0, @1] angle:-M_PI_4];
    [self addSubview:_upperLeft];
    
    _upperMiddle = [BKGradientView linearGradientViewSidePieceWithFrame:CGRectMake(borderGradientWidth, 0, self.frame.size.width - 2*borderGradientWidth, borderGradientWidth) colors:@[edgeColor, innerColor] locations:@[@0, @1] angle:0];
    [self addSubview:_upperMiddle];
    
    _upperRight = [BKGradientView radialGradientViewCornerPieceWithFrame:CGRectMake(self.frame.size.width-borderGradientWidth, 0, borderGradientWidth, borderGradientWidth) colors:@[edgeColor, innerColor] locations:@[@0, @1] angle:M_PI_4];
    [self addSubview:_upperRight];
    
    _middleRight = [BKGradientView linearGradientViewSidePieceWithFrame:CGRectMake(self.frame.size.width-borderGradientWidth, borderGradientWidth, borderGradientWidth, self.frame.size.height-2*borderGradientWidth) colors:@[edgeColor, innerColor] locations:@[@0, @1] angle:M_PI_2];
    [self addSubview:_middleRight];
    
    _bottomRight = [BKGradientView radialGradientViewCornerPieceWithFrame:CGRectMake(self.frame.size.width-borderGradientWidth, self.frame.size.height-borderGradientWidth, borderGradientWidth, borderGradientWidth) colors:@[edgeColor, innerColor] locations:@[@0, @1] angle:M_PI_2+M_PI_4];
    [self addSubview:_bottomRight];
    
    _bottomMiddle = [BKGradientView linearGradientViewSidePieceWithFrame:CGRectMake(borderGradientWidth, self.frame.size.height-borderGradientWidth, self.frame.size.width-2*borderGradientWidth, borderGradientWidth) colors:@[edgeColor, innerColor] locations:@[@0, @1] angle:M_PI];
    [self addSubview:_bottomMiddle];
    
    _bottomLeft = [BKGradientView radialGradientViewCornerPieceWithFrame:CGRectMake(0, self.frame.size.height-borderGradientWidth, borderGradientWidth, borderGradientWidth) colors:@[edgeColor, innerColor] locations:@[@0, @1] angle:M_PI+M_PI_4];
    [self addSubview:_bottomLeft];
    
    _middleLeft = [BKGradientView linearGradientViewSidePieceWithFrame:CGRectMake(0, borderGradientWidth, borderGradientWidth, self.frame.size.height-2*borderGradientWidth) colors:@[edgeColor, innerColor] locations:@[@0, @1] angle:-M_PI_2];
    [self addSubview:_middleLeft];
    
    _middle = [[UIView alloc] initWithFrame:CGRectMake(borderGradientWidth, borderGradientWidth, self.frame.size.width-2*borderGradientWidth, self.frame.size.height - 2*borderGradientWidth)];
    [_middle setBackgroundColor:innerColor];
    [self addSubview:_middle];
}

- (void)updateGradientViewFramesForFrame:(CGRect)frame {
    _upperLeft.frame = CGRectMake(0, 0, _borderWidth, _borderWidth);
    _upperMiddle.frame = CGRectMake(_borderWidth, 0, frame.size.width - 2*_borderWidth, _borderWidth);
    _upperRight.frame = CGRectMake(frame.size.width-_borderWidth, 0, _borderWidth, _borderWidth);
    _middleRight.frame = CGRectMake(frame.size.width-_borderWidth, _borderWidth, _borderWidth, frame.size.height-2*_borderWidth);
    _bottomRight.frame = CGRectMake(frame.size.width-_borderWidth, frame.size.height-_borderWidth, _borderWidth, _borderWidth);
    _bottomMiddle.frame = CGRectMake(_borderWidth, frame.size.height-_borderWidth, frame.size.width-2*_borderWidth, _borderWidth);
    _bottomLeft.frame = CGRectMake(0, frame.size.height-_borderWidth, _borderWidth, _borderWidth);
    _middleLeft.frame = CGRectMake(0, _borderWidth, _borderWidth, frame.size.height-2*_borderWidth);
    _middle.frame = CGRectMake(_borderWidth, _borderWidth, frame.size.width-2*_borderWidth, frame.size.height - 2*_borderWidth);
}


// http://stackoverflow.com/questions/11770743/capturing-touches-on-a-subview-outside-the-frame-of-its-superview-using-hittest
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        for (UIView *subview in self.subviews.reverseObjectEnumerator) {
            CGPoint subPoint = [subview convertPoint:point fromView:self];
            UIView *result = [subview hitTest:subPoint withEvent:event];
            if (result != nil) {
                return result;
            }
        }
    }
    
    return nil;
}

@end
