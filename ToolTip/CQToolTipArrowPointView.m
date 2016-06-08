//
//  CQToolTipArrowPointView.m
//  Cryptoquips
//
//  Created by Andrew King on 2016-01-27.
//
//

#import "CQToolTipArrowPointView.h"

@implementation CQToolTipArrowPointView

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    
    CGPoint point1;
    CGPoint point2;
    CGPoint point3;
    
    switch (self.arrowDirection) {
        case CQToolTipArrowDirectionTop:
            point1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect)); // top mid
            point2 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect)); // bottom right
            point3 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect)); // bottom left
            break;
        case CQToolTipArrowDirectionRight:
            point1 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMidY(rect)); // mid right
            point2 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect)); // bottom left
            point3 = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect)); // top left
            break;
        
        case CQToolTipArrowDirectionBottom:
            point1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect)); // bottom mid
            point2 = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect)); // top left
            point3 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect)); // top right
            break;
        
        case CQToolTipArrowDirectionLeft:
            point1 = CGPointMake(CGRectGetMinX(rect), CGRectGetMidY(rect)); // mid left
            point2 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect)); // top right
            point3 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect)); // bottom right
            break;
    }
    
    CGContextMoveToPoint   (ctx, point1.x, point1.y);
    CGContextAddLineToPoint(ctx, point2.x, point2.y);
    CGContextAddLineToPoint(ctx, point3.x, point3.y);
    CGContextClosePath(ctx);
    
    CGFloat fillRed, fillGreen, fillBlue, fillAlpha;
    [self.fillColor getRed:&fillRed green:&fillGreen blue:&fillBlue alpha:&fillAlpha];
    
    CGContextSetRGBFillColor(ctx, fillRed, fillGreen, fillBlue, fillAlpha);
    CGContextFillPath(ctx);
}

@end
