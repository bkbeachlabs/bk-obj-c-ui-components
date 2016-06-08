//
//  CoinsBalanceAnimator.m
//  Cryptoquips
//
//  Created by Andrew King on 11/3/2013.
//
//

#import "CoinsBalanceAnimator.h"
#import "CQFontManager.h"
#import "BKGradientPanelView.h"
#import "constants.h"

@implementation CoinsBalanceAnimator

+ (void)animateCoinsBalanceChangeWithInitialBalance:(int)initialBal
                                       FinalBalance:(int)finalBalance
                                 InitialCoordinates:(CGPoint)initialCoord
                                           Duration:(float)duration
                                     NeedsIndicator:(BOOL)needsIndicator
                                        ScreenWidth:(int)screenWidth
                                           OntoView:(UIView *)receivingView {
    
    // Initializing Variables
    float balanceIncrease = (float)finalBalance - (float)initialBal;
    if (balanceIncrease>10) {
        duration = duration*2;
    }
    
    // TOP BAR
    BKGradientPanelView *indicatorTopBar = [[BKGradientPanelView alloc] initWithFrame:CGRectMake(0, -45, screenWidth, 45)
                                                                          borderWidth:2
                                                                            edgeColor:[CQFontManager lockPanelButtonBorderColor]
                                                                           innerColor:[CQFontManager lockPanelButtonBackgroundColor]];
    
//    UIImageView *indicatorTopBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, -45, screenWidth, 45)];
//    [indicatorTopBar setImage:[UIImage imageNamed:@"ccLSClean-topBarForIOS7-40px"]];
    [receivingView addSubview:indicatorTopBar];
    
    // BALANCE INDICATOR
    UIImageView *balanceIndictorImgView = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth - 148 - 5, 5, 148, 35)];
    [balanceIndictorImgView setImage:[UIImage imageNamed:@"ccLSStoreButtonGold"]];
    [indicatorTopBar addSubview:balanceIndictorImgView];
    
    // BALANCE LABEL
    UIColor *screenTextColor = [UIColor colorWithRed:(25/255.0f) green:(66/255.0f) blue:(93/255.0f) alpha:.8];
    UILabel *balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(balanceIndictorImgView.frame.origin.x +80, 13, 56, 21)];
    [balanceLabel setFont:[CQFontManager coinsBalanceLCDFont]];
    [balanceLabel setTextColor:screenTextColor];
    [balanceLabel setTextAlignment:NSTextAlignmentLeft];
    [balanceLabel setAdjustsFontSizeToFitWidth:YES];
    [balanceLabel setMinimumScaleFactor:0];
    [balanceLabel setText:[NSString stringWithFormat:@"%i",initialBal]];
    [indicatorTopBar addSubview:balanceLabel];
    
    UIImageView *coin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ccCoin-20px"]];
    
    float finalX = 217;
    float finalY = 12;
    
    // set properties on label
    // add indicator and label to top bar
    // Set Initial Balance
    
    // Animate Indicator into place from drop-down
    [UIView animateWithDuration:0.6*needsIndicator animations:^() {
        if (needsIndicator) {
            [indicatorTopBar setFrame:CGRectOffset(indicatorTopBar.frame, 0, 45)];
        }
    } completion:^(BOOL finished) {
        
        // Set Coin's initial location
        [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat animations:^() {
            [UIView setAnimationRepeatCount:balanceIncrease];
            [coin setFrame:CGRectMake(initialCoord.x, initialCoord.y, 20, 20)];
            [receivingView addSubview:coin];
        } completion:^(BOOL finished){
            
            // Move Coin to Indicator (repeats as many times as necessary)
            [UIView animateWithDuration:duration/balanceIncrease delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionRepeat animations:^() {
                [UIView setAnimationRepeatCount:balanceIncrease];
                [coin setFrame:CGRectMake(finalX, finalY, 20, 20)];
            } completion:^(BOOL finished) {
                // Update Balance Label
                [UIView animateWithDuration:duration/balanceIncrease animations:^() {
                    [balanceLabel setText:[NSString stringWithFormat:@"%i",finalBalance]];
                } completion:^(BOOL finished) {
                    
                    // Move Indicator Bar Up
                    [UIView animateWithDuration:0.6 delay:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^() {
                        if (needsIndicator) {
                            [indicatorTopBar setFrame:CGRectOffset(indicatorTopBar.frame, 0, -45)];
                        }
                        [coin setFrame:CGRectOffset(coin.frame, 0, -45)];
                    } completion:^(BOOL finished) {
                        
                        // Remove Indicator Bar from View
                        if (needsIndicator) {
                            [indicatorTopBar removeFromSuperview];
                        }
                        [coin removeFromSuperview];
                    }];
                }];
            }];
        }];
    }];
}

@end
