//
//  CQToolTipViewController.m
//  Cryptoquips
//
//  Created by Andrew King on 2016-01-19.
//
//

#import "CQToolTipViewController.h"
#import "CQToolTipArrowPointView.h"
#import "BKGradientPanelView.h"

static CGFloat const CQArrowWidth = 8;

@interface CQToolTipViewController ()
@property (weak, nonatomic) IBOutlet CQToolTipArrowPointView *topArrowImageView;
@property (weak, nonatomic) IBOutlet CQToolTipArrowPointView *leftArrowImageView;
@property (weak, nonatomic) IBOutlet CQToolTipArrowPointView *rightArrowImageView;
@property (weak, nonatomic) IBOutlet CQToolTipArrowPointView *bottomArrowImageView;
@property (weak, nonatomic) IBOutlet BKGradientPanelView *gradientPanelView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topArrowLeadingDistanceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomArrowLeadingDistanceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightArrowTopDistanceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftArrowTopDistanceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tooltipHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tooltipWidthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation CQToolTipViewController


+ (instancetype)toolTipViewControllerWithSize:(CGSize)size
                               arrowDirection:(CQToolTipArrowDirection)arrowDirection
                                   arrowPoint:(CGPoint)arrowPoint
                             inViewController:(UIViewController *)owningViewController
                                     withText:(NSString *)text
                andAdditionalTriggeringButton:(UIButton *)additionalTriggeringButton {
    
    return [[[self class] alloc] initWithSize:size
                               arrowDirection:arrowDirection
                                   arrowPoint:arrowPoint
                             inViewController:owningViewController
                                     withText:text
                andAdditionalTriggeringButton:additionalTriggeringButton];
}

- (instancetype)initWithSize:(CGSize)size
              arrowDirection:(CQToolTipArrowDirection)arrowDirection
                  arrowPoint:(CGPoint)arrowPoint
            inViewController:(UIViewController *)owningViewController
                    withText:(NSString *)text
andAdditionalTriggeringButton:(UIButton *)additionalTriggeringButton {
    
    if ((self = [super init])) {
        _size = size;
        _arrowDirection = arrowDirection;
        _arrowPoint = arrowPoint;
        _owningViewController = owningViewController;
        _text = text;
        _additionalTriggeringButton = additionalTriggeringButton;
        _allowTapToDismiss = YES;
        
        if (additionalTriggeringButton) {
            [additionalTriggeringButton addTarget:self action:@selector(didPressToolTip:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

- (void)viewDidLayoutSubviews {
    [self updateLayout];
}

- (void)dealloc {
    [_additionalTriggeringButton removeTarget:self action:@selector(didPressToolTip:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLayout {
    
    _gradientPanelView.frame = CGRectMake(CQArrowWidth, CQArrowWidth, self.size.width, self.size.height);
    [_gradientPanelView configureWithBorderWidth:4
                                       edgeColor:self.edgeColor
                                      innerColor:self.panelColor];
    
    self.view.frame = CGRectMake([self calculateX], [self calculateY], self.size.width + 2*CQArrowWidth, self.size.height + 2*CQArrowWidth);
    
    [self showOnlyCurrentArrow];
    [self configureArrowViewAppearance];
    [self layoutArrows];
    
    self.textLabel.text = self.text;
}

- (void)showOnlyCurrentArrow {
    self.topArrowImageView.hidden    = self.arrowDirection != CQToolTipArrowDirectionTop;
    self.rightArrowImageView.hidden  = self.arrowDirection != CQToolTipArrowDirectionRight;
    self.bottomArrowImageView.hidden = self.arrowDirection != CQToolTipArrowDirectionBottom;
    self.leftArrowImageView.hidden   = self.arrowDirection != CQToolTipArrowDirectionLeft;
}

- (void)configureArrowViewAppearance {
    self.topArrowImageView.arrowDirection = CQToolTipArrowDirectionTop;
    self.rightArrowImageView.arrowDirection = CQToolTipArrowDirectionRight;
    self.bottomArrowImageView.arrowDirection = CQToolTipArrowDirectionBottom;
    self.leftArrowImageView.arrowDirection = CQToolTipArrowDirectionLeft;
    
    self.topArrowImageView.fillColor = self.edgeColor;
    self.rightArrowImageView.fillColor = self.edgeColor;
    self.bottomArrowImageView.fillColor = self.edgeColor;
    self.leftArrowImageView.fillColor = self.edgeColor;
}

- (void)layoutArrows {
    self.topArrowLeadingDistanceConstraint.constant = self.arrowPoint.x - self.view.frame.origin.x - CQArrowWidth;
    self.bottomArrowLeadingDistanceConstraint.constant = self.arrowPoint.x - self.view.frame.origin.x - CQArrowWidth;
    self.leftArrowTopDistanceConstraint.constant = self.arrowPoint.y - self.view.frame.origin.y - CQArrowWidth;
    self.rightArrowTopDistanceConstraint.constant = self.arrowPoint.y - self.view.frame.origin.y - CQArrowWidth;
    
    self.tooltipWidthConstraint.constant = self.size.width;
    self.tooltipHeightConstraint.constant = self.size.height;
}

- (CGFloat)calculateX {
    // Attempt to center the tooltip over/under the target
    
    CGFloat autoX = 0;
    switch (self.arrowDirection) {
        case CQToolTipArrowDirectionTop:
        case CQToolTipArrowDirectionBottom:
            autoX = self.arrowPoint.x - self.size.width/2 - CQArrowWidth;
            break;
        case CQToolTipArrowDirectionRight:
            autoX = self.arrowPoint.x - self.size.width - 2*CQArrowWidth;
            break;
        case CQToolTipArrowDirectionLeft:
            autoX = self.arrowPoint.x;
            break;
    }
    
    if (autoX + self.size.width + 2*CQArrowWidth > self.owningViewController.view.frame.size.width) {
        // This will extend off the side of the owningViewController.
        autoX = self.owningViewController.view.frame.size.width - self.size.width - 2*CQArrowWidth;
    }
    if (autoX < 0) {
        autoX = 0;
    }
    
    return autoX;
}

- (CGFloat)calculateY {
    // Attempt to center the tooltip over/under the target
    
    CGFloat autoY = 0;
    switch (self.arrowDirection) {
        case CQToolTipArrowDirectionTop:
            autoY = self.arrowPoint.y;
            break;
        
        case CQToolTipArrowDirectionBottom:
            autoY = self.arrowPoint.y - self.size.height - 2*CQArrowWidth;
            break;
        
        case CQToolTipArrowDirectionRight:
        case CQToolTipArrowDirectionLeft:
            autoY = self.arrowPoint.y - self.size.height/2 - CQArrowWidth;
            break;
    }
    
    if (autoY + self.size.height + 2*CQArrowWidth > self.owningViewController.view.frame.size.height) {
        autoY = self.owningViewController.view.frame.size.height - self.size.width - 2*CQArrowWidth;
    }
    if (autoY < 0) {
        autoY = 0;
    }
    
    return autoY;
}

- (UIColor *)edgeColor {
    if (_edgeColor == nil) {
        return [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.95];
    }
    return _edgeColor;
}

- (UIColor *)panelColor {
    if (_panelColor == nil) {
        return [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.95];
    }
    return _panelColor;
}


- (IBAction)didPressToolTip:(id)sender {
    if (self.allowTapToDismiss) {
        if (_additionalTriggeringButton) {
            [_additionalTriggeringButton removeTarget:self action:@selector(didPressToolTip:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.delegate toolTipDoesRequireDismissal:self];
    }
}

@end
