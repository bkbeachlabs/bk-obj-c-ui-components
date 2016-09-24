//
//  PromptView.m
//  Cryptoquips
//
//  Created by Andrew King on 2013-01-01.
//  Copyright (c) 2013 BK Beach Labs. All rights reserved.
//

#import "PromptView.h"
#import "constants.h"
#import "CQFontManager.h"

/*
 *
 
 This subclass of UIView is used for the tutorial prompts in Cryptoquips.
 It has a next, prev and skip button, a set highlight frame (which the prompt should be explaining)
 The rest of the view is masked with a shadow. FIX-1.1: Is there a more efficient way to do this masking?
 
 *
 */
@implementation PromptView {
    
    UILabel *titleLabel;
    CGRect highlightRect;
    UIView *shadowLeft;
    UIView *shadowRight;
    UIView *shadowTop;
    UIView *shadowBottom;

    UIView *highlightLeft;
    UIView *highlightRight;
    UIView *highlightTop;
    UIView *highlightBottom;

    UILabel *titleLabelTextView;
    UIImageView *titleLabelImageView;

    float BACKGROUND_ALPHA;
    UIColor *shadowColor;
    UIColor *highlightColor;
    UIColor *textColor;

    NSInteger H_Frame_Width;
    float highlightAlpha;
}



#pragma mark - setup methods

/**
 Default init method
 */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        highlightAlpha = 0.8;
        H_Frame_Width = 8;
        BACKGROUND_ALPHA = 0.7;
    }
    return self;
}

/**
 Initializes the view and 
 - sets the frames on the shadow views
 - determines the best location for the text view based on the highlighted frame
 - sets correct background image according to tiered sizes
 - adds next, prev, and skip buttons
 - add highlight (white border) around the inputted highlighted frame.
 */
- (id)initWithFrame:(CGRect)frame andHighlightedFrame:(CGRect)highlightFrame {
    if ((self = [self initWithFrame:frame])) {
        // Set view's alpha.
//        self.alpha = 0.9;
        
        highlightRect = highlightFrame;
        
        // Set default colors.
        if (!highlightColor) {
            highlightColor = [UIColor whiteColor];
        }
        if (!textColor) {
            textColor = [UIColor colorWithWhite:0.15 alpha:0.9];
        }
        if (!shadowColor) {
            shadowColor = [UIColor blackColor];
        }
        
        // FIX-1.1 If highlight frame isnt set, shadow the entire view.
        // SHADOW FRAMES
        if (highlightRect.size.height == 0 && highlightRect.size.width == 0) {
            shadowLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, super.frame.size.width, super.frame.size.height)];
            shadowLeft.backgroundColor = shadowColor;
            shadowLeft.alpha = BACKGROUND_ALPHA;
            [self addSubview:shadowLeft];
            
            shadowRight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            shadowRight.backgroundColor = shadowColor;
            shadowRight.alpha = BACKGROUND_ALPHA;
            [self addSubview:shadowRight];
            
            shadowTop = [[UIView alloc] initWithFrame:CGRectMake(0,0, 0, 0)];
            shadowTop.backgroundColor = shadowColor;
            shadowTop.alpha = BACKGROUND_ALPHA;
            [self addSubview:shadowTop];
            
            shadowBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            shadowBottom.backgroundColor = shadowColor;
            shadowBottom.alpha = BACKGROUND_ALPHA;
            [self addSubview:shadowBottom];
        } else {
            shadowLeft = [[UIView alloc] initWithFrame:CGRectMake(0, highlightFrame.origin.y, highlightFrame.origin.x, highlightFrame.size.height)];
            shadowLeft.backgroundColor = shadowColor;
            shadowLeft.alpha = BACKGROUND_ALPHA;
            [self addSubview:shadowLeft];
            
            shadowRight = [[UIView alloc] initWithFrame:CGRectMake(highlightFrame.size.width+highlightFrame.origin.x, highlightFrame.origin.y, self.frame.size.width - highlightFrame.origin.x - highlightFrame.size.width, highlightFrame.size.height)];
            shadowRight.backgroundColor = shadowColor;
            shadowRight.alpha = BACKGROUND_ALPHA;
            [self addSubview:shadowRight];
            
            shadowTop = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.frame.size.width, highlightFrame.origin.y)];
            shadowTop.backgroundColor = shadowColor;
            shadowTop.alpha = BACKGROUND_ALPHA;
            [self addSubview:shadowTop];
            
            shadowBottom = [[UIView alloc] initWithFrame:CGRectMake(0, highlightFrame.origin.y+highlightFrame.size.height, self.frame.size.width, self.frame.size.height - highlightFrame.origin.y - highlightFrame.size.height)];
            shadowBottom.backgroundColor = shadowColor;
            shadowBottom.alpha = BACKGROUND_ALPHA;
            [self addSubview:shadowBottom];
        }
        
        // DETERMINE IF THE LABEL SHOULD BE TOP OR BOTTOM AND SET THE FRAME
        CGRect labelFrame;
        
        if (highlightFrame.origin.y + highlightFrame.size.height < self.frame.size.height - 180) { // if there is atleast 180px free on the bottom, label goes on the bottom
            // TEXT ON BOTTOM
            labelFrame = CGRectMake(40, highlightFrame.origin.y + highlightFrame.size.height + 20, self.frame.size.width - 80, self.frame.size.height - 40 - highlightFrame.origin.y - highlightFrame.size.height);
        } else {
            // TEXT ON TOP
            labelFrame = CGRectMake(40, 20, self.frame.size.width - 80, highlightFrame.origin.y - 20);
        }
        
        // LABEL
        titleLabelTextView = [[UILabel alloc] initWithFrame:labelFrame];
        [titleLabelTextView setText:self.text];
        titleLabelTextView.textColor = textColor;
        titleLabelTextView.textAlignment = NSTextAlignmentCenter;
        [titleLabelTextView setFont:[CQFontManager keyboardButtonFont]];
        titleLabelTextView.backgroundColor = [UIColor clearColor];
        titleLabelTextView.numberOfLines = 0;
        [self addSubview:titleLabelTextView];
        self.textFrame = titleLabelTextView.frame;
        
        titleLabelImageView = [[UIImageView alloc] initWithFrame:self.textFrame];
        [self insertSubview:titleLabelImageView belowSubview:titleLabelTextView];
        
        // BACKGROUND IMAGE
        titleLabelImageView.frame = CGRectMake(titleLabelTextView.frame.origin.x - 10, titleLabelTextView.frame.origin.y - 10, titleLabelTextView.frame.size.width + 20, titleLabelTextView.frame.size.height + 20);
        
        if (self.textFrame.size.height < 160) {
            [titleLabelImageView setImage:[UIImage imageNamed:@"ccTutPrompt-150h.png"]];
        } else if (self.textFrame.size.height < 200) {
            [titleLabelImageView setImage:[UIImage imageNamed:@"ccTutPrompt-180h.png"]];
        } else if (self.textFrame.size.height < 260) {
            [titleLabelImageView setImage:[UIImage imageNamed:@"ccTutPrompt-240h.png"]];
        } else {
            [titleLabelImageView setImage:[UIImage imageNamed:@"ccTutPrompt-340h.png"]];
        }
        
        // ADD THE BUTTONS
        self.skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.skipButton setTitle:@"Skip" forState:UIControlStateNormal];
        [self.skipButton setFrame:CGRectMake(10, self.frame.size.height - 50, 70, 40)];
        [self.skipButton setBackgroundColor:[UIColor darkGrayColor]];
        [self.nextButton.titleLabel setShadowColor:[UIColor blackColor]];
        [self.nextButton.titleLabel setShadowOffset:CGSizeMake(1,1)];
        [self.skipButton.titleLabel setFont:[CQFontManager promptViewButtonFont]];
        [self.skipButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self addSubview:self.skipButton];
        
        self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
        [self.nextButton setFrame:CGRectMake(self.frame.size.width - 110, self.frame.size.height - 50, 100, 40)];
        [self.nextButton setBackgroundColor:[CQFontManager colorForAlphaState:CQAlphaStateAutoFilled]];
        [self.nextButton.titleLabel setShadowColor:[UIColor blackColor]];
        [self.nextButton.titleLabel setShadowOffset:CGSizeMake(1,1)];
        [self.nextButton.titleLabel setFont:[CQFontManager promptViewButtonFont]];
        self.nextButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:self.nextButton];
        
        
        // HIGHLIGHT FRAME
        if (highlightFrame.size.width == 0 && highlightFrame.size.height == 0) {
            // nil frame
        } else {
            highlightLeft = [[UIView alloc] initWithFrame:CGRectMake(highlightRect.origin.x - H_Frame_Width, highlightRect.origin.y - H_Frame_Width, H_Frame_Width, highlightRect.size.height + 2*H_Frame_Width)];
            highlightLeft.backgroundColor = highlightColor;
            highlightLeft.alpha = 0;
            [self insertSubview:highlightLeft aboveSubview:shadowBottom];
            
            highlightRight = [[UIView alloc] initWithFrame:CGRectMake(highlightRect.origin.x + highlightRect.size.width, highlightRect.origin.y - H_Frame_Width, H_Frame_Width, highlightRect.size.height + 2*H_Frame_Width)];
            highlightRight.backgroundColor = highlightColor;
            highlightRight.alpha = 0;
            [self insertSubview:highlightRight aboveSubview:shadowBottom];
            
            highlightTop = [[UIView alloc] initWithFrame:CGRectMake(highlightRect.origin.x, highlightRect.origin.y - H_Frame_Width, highlightRect.size.width, H_Frame_Width)];
            highlightTop.backgroundColor = highlightColor;
            highlightTop.alpha = 0;
            [self insertSubview:highlightTop aboveSubview:shadowBottom];
            
            highlightBottom = [[UIView alloc] initWithFrame:CGRectMake(highlightRect.origin.x, highlightRect.origin.y + highlightRect.size.height, highlightRect.size.width, H_Frame_Width)];
            highlightBottom.backgroundColor = highlightColor;
            highlightBottom.alpha = 0;
            [self insertSubview:highlightBottom aboveSubview:shadowBottom];
        }
    }
    return self;
}

/**
 - sets the frames on the shadow views
 - determines the best location for the text view based on the highlighted frame
 - sets correct background image according to tiered sizes
 - adds next, prev, and skip buttons
 - add highlight (white border) around the inputted highlighted frame.
 */
- (void) refreshLayoutWithFrame:(CGRect)frame andHighlightedFrame:(CGRect)highlightFrame {
    
    self.frame = frame;
    highlightRect = highlightFrame;
    
    // Set default colors.
    if (!highlightColor) {
        highlightColor = [UIColor whiteColor];
    }
    if (!textColor) {
        textColor = [UIColor colorWithWhite:0.15 alpha:0.9];
    }
    if (!shadowColor) {
        shadowColor = [UIColor blackColor];
    }
    
    // FIX-1.1 If highlight frame isnt set, shadow the entire view.
    // SHADOW FRAMES
    if (highlightRect.size.height == 0 && highlightRect.size.width == 0) {
        [shadowLeft setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [shadowRight setFrame:CGRectMake(0, 0, 0, 0)];
        [shadowTop setFrame:CGRectMake(0, 0, 0, 0)];
        [shadowBottom setFrame:CGRectMake(0, 0, 0, 0)];
    } else {
        [shadowLeft setFrame:CGRectMake(0, highlightFrame.origin.y, highlightFrame.origin.x, highlightFrame.size.height)];
        [shadowRight setFrame:CGRectMake(highlightFrame.size.width+highlightFrame.origin.x, highlightFrame.origin.y, self.frame.size.width - highlightFrame.origin.x - highlightFrame.size.width, highlightFrame.size.height)];
        [shadowTop setFrame:CGRectMake(0,0, self.frame.size.width, highlightFrame.origin.y)];
        [shadowBottom setFrame:CGRectMake(0, highlightFrame.origin.y+highlightFrame.size.height, self.frame.size.width, self.frame.size.height - highlightFrame.origin.y - highlightFrame.size.height)];
    }
    
    // LABEL
    [titleLabelTextView setCenter:self.center];
    [titleLabelImageView setCenter:self.center];
    
    self.textFrame = titleLabelTextView.frame;
    
    // ADD THE BUTTONS
    [self.skipButton setFrame:CGRectMake(10, self.frame.size.height - 40, 50, 30)];
//    [self.backButton setFrame:CGRectMake(180, self.frame.size.height - 40, 50, 30)];
    [self.nextButton setFrame:CGRectMake(self.frame.size.width - 80, self.frame.size.height - 45, 70, 40)];
    
    // HIGHLIGHT FRAME
    if (highlightFrame.size.width == 0 && highlightFrame.size.height == 0) {
        // nil frame
    } else {
        [highlightLeft setFrame:CGRectMake(highlightRect.origin.x - H_Frame_Width, highlightRect.origin.y - H_Frame_Width, H_Frame_Width, highlightRect.size.height + 2*H_Frame_Width)];
        
        [highlightRight setFrame:CGRectMake(highlightRect.origin.x + highlightRect.size.width, highlightRect.origin.y - H_Frame_Width, H_Frame_Width, highlightRect.size.height + 2*H_Frame_Width)];
        
        [highlightTop setFrame:CGRectMake(highlightRect.origin.x, highlightRect.origin.y - H_Frame_Width, highlightRect.size.width, H_Frame_Width)];
        
        [highlightBottom setFrame:CGRectMake(highlightRect.origin.x, highlightRect.origin.y + highlightRect.size.height, highlightRect.size.width, H_Frame_Width)];
    }
}

/**
 Sets the text for the text view, updates the size, then updates the chosen background image if necessary.
 */
- (void) setText:(NSString *)textTT {
    
    [titleLabelTextView setText:textTT];
    CGPoint centerPoint = titleLabelTextView.center;
    [titleLabelTextView sizeToFit];
    titleLabelTextView.center = centerPoint;
    titleLabelTextView.frame = CGRectMake(titleLabelTextView.frame.origin.x - 10, titleLabelTextView.frame.origin.y - 10, titleLabelTextView.frame.size.width + 20, titleLabelTextView.frame.size.height + 20);
    self.textFrame = titleLabelTextView.frame;
    
    // BACKGROUND IMAGE
    
    titleLabelImageView.frame = CGRectMake(titleLabelTextView.frame.origin.x - 10, titleLabelTextView.frame.origin.y - 10, titleLabelTextView.frame.size.width + 20, titleLabelTextView.frame.size.height + 20);
    
    if (self.textFrame.size.height < 160) {
        [titleLabelImageView setImage:[UIImage imageNamed:@"ccTutPrompt-150h.png"]];
    } else if (self.textFrame.size.height < 200) {
        [titleLabelImageView setImage:[UIImage imageNamed:@"ccTutPrompt-180h.png"]];
    } else if (self.textFrame.size.height < 260) {
        [titleLabelImageView setImage:[UIImage imageNamed:@"ccTutPrompt-240h.png"]];
    } else {
        [titleLabelImageView setImage:[UIImage imageNamed:@"ccTutPrompt-340h.png"]];
    }
}

- (void)setTextFrame:(CGRect)textFrameTT {
    [titleLabelTextView setFrame:textFrameTT];
    _textFrame = textFrameTT;
}

- (void)setTextCenter:(CGPoint)textCenter {
    [titleLabelTextView setCenter:textCenter];
    self.textFrame = titleLabelTextView.frame;
}

#pragma mark - animations

- (void) highlightFrameAnimate {
    highlightLeft.backgroundColor = highlightColor;
    highlightRight.backgroundColor = highlightColor;
    highlightTop.backgroundColor = highlightColor;
    highlightBottom.backgroundColor = highlightColor;
    
    [UIView animateWithDuration:0.2 animations:^() {
        
        highlightLeft.alpha = highlightAlpha;
        highlightRight.alpha = highlightAlpha;
        highlightTop.alpha = highlightAlpha;
        highlightBottom.alpha = highlightAlpha;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^() {
            highlightLeft.alpha = 0.5;
            highlightRight.alpha = 0.5;
            highlightTop.alpha = 0.5;
            highlightBottom.alpha = 0.5;
        }];
    }];
}


@end
