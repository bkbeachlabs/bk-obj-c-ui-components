//
//  BKGradientView.m
//  Cryptoquips
//
//  Created by Andrew King on 2015-01-31.
//
//

#import "BKGradientView.h"
#import "NSArray+ReversedArray.h"


@implementation BKGradientView

- (instancetype)initWithFrame:(CGRect)frame
                        style:(BKGradientViewStyle)style
                       colors:(NSArray *)colors
                    locations:(NSArray *)locations
                        angle:(CGFloat)angle {

    if ((self = [super initWithFrame:frame])) {
        self.style = style;
        self.colors = colors;
        self.locations = locations;
        self.angle = angle;
        
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Acceptable angles are multiples of pi/4
+ (instancetype)linearGradientViewSidePieceWithFrame:(CGRect)frame
                                              colors:(NSArray *)colors
                                           locations:(NSArray *)locations
                                               angle:(CGFloat)angle {
    
    BKGradientView *gradientView = [[BKGradientView alloc] initWithFrame:frame
                                                                   style:BKGradientViewStyleLinearSide
                                                                  colors:colors
                                                               locations:locations
                                                                   angle:angle];
    return gradientView;
}

+ (instancetype)linearGradientViewCornerPieceWithFrame:(CGRect)frame
                                                colors:(NSArray *)colors
                                             locations:(NSArray *)locations
                                                 angle:(CGFloat)angle {
    
    BKGradientView *gradientView = [[BKGradientView alloc] initWithFrame:frame
                                                                   style:BKGradientViewStyleLinearCorner
                                                                  colors:colors
                                                               locations:locations
                                                                   angle:angle];
    return gradientView;
}

+ (instancetype)radialGradientViewCornerPieceWithFrame:(CGRect)frame
                                                colors:(NSArray *)colors
                                             locations:(NSArray *)locations
                                                 angle:(CGFloat)angle {
    
    BKGradientView *gradientView = [[BKGradientView alloc] initWithFrame:frame
                                                                   style:BKGradientViewStyleRadialCorner
                                                                  colors:colors
                                                               locations:locations
                                                                   angle:angle];
    return gradientView;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, rect);
//    CGContextSetFillColor(context, CGColorGetComponents([UIColor colorWithRed:1 green:1 blue:1 alpha:0].CGColor));

//    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
//    CGContextSetAlpha(context,0.0);
//    CGContextFillRect(context, rect);
    
    switch (self.style) {
        case BKGradientViewStyleLinearSide: {
            [self drawLinearGradientFillInContext:context];
            break;
        }
        case BKGradientViewStyleLinearCorner: {
            [self drawLinearCornerGradientFillInContext:context];
        }
        case BKGradientViewStyleRadialCorner: {
            [self drawRadialGradientFillInContext:context];
            break;
        }
        default:
            break;
    }
}


- (CGPoint)topPointInRect:(CGRect)rect {
    return CGPointMake(rect.size.width/2, 0);
}
- (CGPoint)rightPointInRect:(CGRect)rect {
    return CGPointMake(rect.size.width, rect.size.height/2);
}
- (CGPoint)bottomPointInRect:(CGRect)rect {
    return CGPointMake(rect.size.width/2, rect.size.height);
}
- (CGPoint)leftPointInRect:(CGRect)rect {
    return CGPointMake(0, rect.size.height/2);
}

- (CGPoint)topLeftPointInRect:(CGRect)rect {
    return CGPointMake(0, 0);
}
- (CGPoint)topRightPointInRect:(CGRect)rect {
    return CGPointMake(rect.size.width, 0);
}
- (CGPoint)bottomLeftPointInRect:(CGRect)rect {
    return CGPointMake(0, rect.size.height);
}
- (CGPoint)bottomRightPointInRect:(CGRect)rect {
    return CGPointMake(rect.size.width, rect.size.height);
}
- (CGPoint)centerPointInRect:(CGRect)rect {
    return CGPointMake(rect.size.width/2, rect.size.height/2);
}

- (CGPoint)gradientStartPointInRect:(CGRect)rect withRadiansAngle:(CGFloat)angle {
    angle = standardAngleFromAngle(angle);
    
    if (compareFloatsWithinPercent(deg(angle), 45, 1) == 0) {
        return [self centerPointInRect:rect];
    } else if (compareFloatsWithinPercent(deg(angle), 135, 1) == 0) {
        return [self centerPointInRect:rect];
    } else if (compareFloatsWithinPercent(deg(angle), 225, 1) == 0) {
        return [self centerPointInRect:rect];
    } else if (compareFloatsWithinPercent(deg(angle), 315, 1) == 0) {
        return [self centerPointInRect:rect];
    } else {
        return [self edgePointInRect:rect atRadianAngle:angle extendedByFactor:1.0];
    }
}

- (CGPoint)gradientEndPointInRect:(CGRect)rect withRadiansAngle:(CGFloat)angle stretchFactor:(CGFloat)stretchFactor {
    angle = standardAngleFromAngle(angle);
    return [self edgePointInRect:rect atRadianAngle:(angle+M_PI) extendedByFactor:stretchFactor];
}

// 0 is top middle.
- (CGPoint)edgePointInRect:(CGRect)rect atRadianAngle:(CGFloat)angle extendedByFactor:(CGFloat)stretchFactor {
    angle = standardAngleFromAngle(angle);
    
    
    if (compareFloatsWithinPercent(deg(angle), 0, 1) == 0 || compareFloatsWithinPercent(deg(angle), 360, 1) == 0) {
        return [self topPointInRect:rect];
    } else if (compareFloatsWithinPercent(deg(angle), 90, 1) == 0) {
        return [self rightPointInRect:rect];
    } else if (compareFloatsWithinPercent(deg(angle), 180, 1) == 0) {
        return [self bottomPointInRect:rect];
    } else if (compareFloatsWithinPercent(deg(angle), 270, 1) == 0) {
        return [self leftPointInRect:rect];
    }
    
    else if (compareFloatsWithinPercent(deg(angle), 45, 1) == 0) {
        return [self topRightPointInRect:rect];
    } else if (compareFloatsWithinPercent(deg(angle), 135, 1) == 0) {
        return [self bottomRightPointInRect:rect];
    } else if (compareFloatsWithinPercent(deg(angle), 225, 1) == 0) {
        return [self bottomLeftPointInRect:rect];
    } else if (compareFloatsWithinPercent(deg(angle), 315, 1) == 0) {
        return [self topLeftPointInRect:rect];
    } else {
        NSAssert(NO, @"Angle must be a multiple of pi/4. Angle is %f", angle);
        return CGPointZero;
    }
}


#pragma mark - Math Helpers & Converters

/**
 * returns 0 if floats are equal, 1 if b > a, and -1 if a > b margin should be a percentage (ex. for 20%, enter 20 - not .2)
 */
NSInteger compareFloatsWithinPercent(CGFloat a, CGFloat b, CGFloat margin) {
    CGFloat fraction = margin/100.f;
    
    if (b==0 && (a < fraction && a > -fraction)) {
        return 0;
    }
    if (a==0 && (b <fraction && b > -fraction)) {
        return 0;
    }
    
    if (a*(1+fraction) >= b && a*(1-fraction) <= b) {
        return 0;
    }
    if (b*(1+fraction) >= a && b*(1-fraction) <= a) {
        return 0;
    }
    
    if (b>a) {
        return 1;
    } else {
        return -1;
    }
    
    return 0;
}

/**
 * returns an angle between 0 and 2pi
 */
CGFloat standardAngleFromAngle(CGFloat angle) {
    while (angle<0) {
        angle+=M_PI*2;
    }
    while (angle>M_PI*2) {
        angle-=M_PI*2;
    }
    return angle;
}

CGFloat* colorsArrayWithNSArray(NSArray *nsArray) {
    NSUInteger count = [nsArray count];
    CGFloat *returnArray = (double *) malloc(sizeof(double) * count*4);
    
    for (NSInteger i=0; i<count; i++) {
        UIColor *color = [nsArray objectAtIndex:i];
        
        const CGFloat* components = CGColorGetComponents(color.CGColor);
        CGFloat red = components[0];
        CGFloat green = components[1];
        CGFloat blue = components[2];
        CGFloat alpha = CGColorGetAlpha([color CGColor]);
        
        returnArray[i*4]=red;
        returnArray[i*4+1]=green;
        returnArray[i*4+2]=blue;
        returnArray[i*4+3]=alpha;
    }
    return returnArray;
}

CGFloat deg(CGFloat radians) {
    return radians * 180 / M_PI;
}

/**
 * Uses snippet from http://www.idevgames.com/forums/thread-3227.html
 */
CGFloat* floatArrayWithNSArray(NSArray *nsArray) {
    NSUInteger count = [nsArray count];
    CGFloat *returnArray = (double *) malloc(sizeof(double) * count);
    
    for (NSInteger i=0; i<count; i++) {
        returnArray[i] = [nsArray[i] floatValue];
    }
    return returnArray;
}

/*
 //- (void)drawDiagonalGradientFillInContext:(CGContextRef)context {
 //    UIGraphicsPushContext(context);
 //    CGFloat rainbowColors[] = {
 //        1.0, 0.0, 0.0, 1.0,
 //        1.0, 0.5, 0.0, 1.0,
 //        1.0, 1.0, 0.0, 1.0,
 //        0.0, 1.0, 0.0, 1.0,
 //        0.0, 1.0, 0.5, 1.0,
 //        0.0, 0.0, 1.0, 1.0,
 //        1.0, 0.0, 1.0, 1.0
 //    };
 //    CGFloat locations[] = {0, 0.3, 0.4, 0.5, 0.6, 0.7, 0.85};
 //
 //    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
 //    CGGradientRef rainbow = CGGradientCreateWithColorComponents(baseSpace, rainbowColors, locations, 7);
 //    // CGColorSpaceRelease(baseSpace), baseSpace = NULL;
 //    CGRect square = CGRectMake(160, 20, 140, 140);
 //    CGContextSaveGState(context);
 //    CGContextAddRect(context, square);
 //    CGContextClip(context);
 //    CGPoint startPoint = CGPointMake(160, 160);
 //    CGPoint endPoint = CGPointMake(300, 20);
 //    CGContextDrawLinearGradient(context, rainbow, startPoint, endPoint, 0);
 //    CGGradientRelease(rainbow), rainbow = NULL;
 //    CGContextRestoreGState(context);
 //    CGContextAddRect(context, square);
 //    CGContextDrawPath(context, kCGPathStroke);
 //}
 */



#pragma mark - Drawing

- (void)drawLinearGradientFillInContext:(CGContextRef)context {
    UIGraphicsPushContext(context);
    
    CGFloat *colors = colorsArrayWithNSArray(self.colors);
    CGFloat *locations = floatArrayWithNSArray(self.locations);
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, locations, self.colors.count);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGRect rect = self.bounds;
    CGContextSaveGState(context);
    
    CGPoint startPoint = [self gradientStartPointInRect:rect withRadiansAngle:self.angle];
    CGPoint endPoint = [self gradientEndPointInRect:rect withRadiansAngle:self.angle stretchFactor:1.0];
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    CGContextRestoreGState(context);
    CGContextDrawPath(context, kCGPathStroke);
    UIGraphicsPopContext();
}

- (void)drawLinearCornerGradientFillInContext:(CGContextRef)context {
    UIGraphicsPushContext(context);
    
    CGFloat *colors = colorsArrayWithNSArray(self.colors);
    CGFloat *locations = floatArrayWithNSArray(self.locations);
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, locations, self.colors.count);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGRect rect = self.bounds;
    CGContextSaveGState(context);
    
    CGPoint startPoint = [self gradientStartPointInRect:rect withRadiansAngle:self.angle];
    CGPoint endPoint = [self gradientEndPointInRect:rect withRadiansAngle:self.angle stretchFactor:2.0];
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient), gradient = NULL;
    CGContextRestoreGState(context);
    CGContextDrawPath(context, kCGPathStroke);
    UIGraphicsPopContext();
}

- (void)drawRadialGradientFillInContext:(CGContextRef)context {
    UIGraphicsPushContext(context);
    
    CGFloat *colors = colorsArrayWithNSArray([self.colors reversedArray]);
    CGFloat *locations = floatArrayWithNSArray(self.locations);
    
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, locations, self.colors.count);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    
    CGRect rect = self.bounds;
    CGContextSaveGState(context);
    
//    CGPoint startPoint = [self gradientStartPointInRect:rect withRadiansAngle:(self.angle)];
    CGPoint endPoint = [self gradientEndPointInRect:rect withRadiansAngle:(self.angle) stretchFactor:2.0];
    
    CGContextDrawRadialGradient(context, gradient, endPoint, 0, endPoint, self.frame.size.width, 0);
    CGGradientRelease(gradient), gradient = NULL;
    CGContextRestoreGState(context);
    CGContextDrawPath(context, kCGPathStroke);
    UIGraphicsPopContext();
}


@end
