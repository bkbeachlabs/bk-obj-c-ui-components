//
//  CQToolTipViewController.h
//  Cryptoquips
//
//  Created by Andrew King on 2016-01-19.
//
//

#import <UIKit/UIKit.h>
#import "CQToolTipArrowPointView.h"

@protocol CQToolTipViewControllerDelegate;

/**
 * This ViewController Displays a ToolTip.
 */
@interface CQToolTipViewController : UIViewController

+ (instancetype)toolTipViewControllerWithSize:(CGSize)size
                               arrowDirection:(CQToolTipArrowDirection)arrowDirection
                                   arrowPoint:(CGPoint)arrowPoint
                             inViewController:(UIViewController *)owningViewController
                                     withText:(NSString *)text
                andAdditionalTriggeringButton:(UIButton *)additionalTriggeringButton;

- (instancetype)initWithSize:(CGSize)size
              arrowDirection:(CQToolTipArrowDirection)arrowDirection
                  arrowPoint:(CGPoint)arrowPoint
            inViewController:(UIViewController *)owningViewController
                    withText:(NSString *)text
andAdditionalTriggeringButton:(UIButton *)additionalTriggeringButton;

- (void)updateLayout;

@property (nonatomic, readonly) CGSize size;

@property (nonatomic, readonly) CQToolTipArrowDirection arrowDirection;

@property (nonatomic, readonly) CGPoint arrowPoint;

@property (nonatomic, readonly, weak) UIViewController *owningViewController;

@property (nonatomic, readonly) NSString *text;

@property (nonatomic, readonly, weak) UIButton *additionalTriggeringButton;

@property (nonatomic, weak) id<CQToolTipViewControllerDelegate> delegate;

@property (nonatomic, assign) BOOL allowTapToDismiss;

@property (nonatomic, strong) UIColor *edgeColor;

@property (nonatomic, strong) UIColor *panelColor;

@end



@protocol CQToolTipViewControllerDelegate <NSObject>

- (void)toolTipDoesRequireDismissal:(CQToolTipViewController *)toolTip;

@end

