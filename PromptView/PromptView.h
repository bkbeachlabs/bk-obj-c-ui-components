//
//  PromptView.h
//  Cryptoquips
//
//  Created by Andrew King on 2013-01-01.
//  Copyright (c) 2013 BK Beach Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This subclass of UIView is used for the tutorial prompts in Cryptoquips.
 * It has a next, prev and skip button, a set highlight frame (which the prompt should be explaining)
 * The rest of the view is masked with a shadow. FIX-1.1: Is there a more efficient way to do this masking?
 *
 * @since 1.0
 */
@interface PromptView : UIView

@property (nonatomic, strong) NSString *text;         /** text to be displayed in the prompt */
@property (nonatomic, strong) UIButton *nextButton;   /** moves to the next prompt*/
@property (nonatomic, strong) UIButton *skipButton;   /** closes the prompts */
//@property (nonatomic, strong) UIButton *backButton;   /** moves to the previous prompt */
@property (nonatomic, assign) CGRect textFrame; /** frame rect for what appears as the prompt view */

/**
 * Initializes the view and
 * - sets the frames on the shadow views
 * - determines the best location for the text view based on the highlighted frame
 * - sets correct background image according to tiered sizes
 * - adds next, prev, and skip buttons
 * - add highlight (white border) around the inputted highlighted frame.
 * @param frame the frame for the entire view (ends up being the bounds of the shadow view)
 * @param highlightFrame the frame that is not covered by the shadow view. Still opaque to touches.
 * @return the initialized promptView.
 */
- (id)initWithFrame:(CGRect)frame andHighlightedFrame:(CGRect)highlightFrame;

/**
 Runs the highlight animation with the present highlight views.
 */
- (void)highlightFrameAnimate;

/**
 * Sets center (and therefore frame) for the text view
 * @param textCenter the point to use as the new center for the textFrame.
 */
- (void)setTextCenter:(CGPoint)textCenter;

- (void)refreshLayoutWithFrame:(CGRect)frame andHighlightedFrame:(CGRect)highlightFrame;

@end
