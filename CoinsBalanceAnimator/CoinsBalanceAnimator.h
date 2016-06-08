//
//  CoinsBalanceAnimator.h
//  Cryptoquips
//
//  Created by Andrew King on 11/3/2013.
//
//

#import <UIKit/UIKit.h>

@interface CoinsBalanceAnimator : NSObject

+ (void)animateCoinsBalanceChangeWithInitialBalance:(int)initialBal
                                       FinalBalance:(int)finalBalance
                                 InitialCoordinates:(CGPoint)initialCoord
                                           Duration:(float)duration
                                     NeedsIndicator:(BOOL)needsIndicator
                                        ScreenWidth:(int)screenWidth
                                           OntoView:(UIView *)receivingView;

@end
