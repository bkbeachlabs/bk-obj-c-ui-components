//
//  CoinsBalanceAnimator.h
//  Cryptoquips
//
//  Created by Andrew King on 11/3/2013.
//
//

#import <UIKit/UIKit.h>

@interface CoinsBalanceAnimator : NSObject

+ (void)animateCoinsBalanceChangeWithInitialBalance:(NSInteger)initialBal
                                       FinalBalance:(NSInteger)finalBalance
                                 InitialCoordinates:(CGPoint)initialCoord
                                           Duration:(CGFloat)duration
                                     NeedsIndicator:(BOOL)needsIndicator
                                        ScreenWidth:(NSInteger)screenWidth
                                           OntoView:(UIView *)receivingView;

@end
