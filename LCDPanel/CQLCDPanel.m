//
//  CQLCDFullPanel.m
//  Cryptoquips
//
//  Created by Andrew King on 2015-03-08.
//
//

#import "CQLCDPanel.h"
#import "CQLCDPortraitPanel.h"
#import "CQLCDGreyPortraitPanel.h"
#import "CQLCDButtonlessLandscapePanel.h"
#import "CQLCDButtonedLandscapePanel.h"
#import "UIView+ContainView.h"


@implementation CQLCDPanel {
    CQLCDPortraitPanel            *_portraitPanel;
    CQLCDGreyPortraitPanel        *_greyPortraitPanel;
    CQLCDButtonlessLandscapePanel *_buttonlessLandscapePanel;
    CQLCDButtonedLandscapePanel   *_buttonedLandscapePanel;
    
    CQLCDPanelType _panelType;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setPanelType:(CQLCDPanelType)panelType {
    _panelType = panelType;
    [self setNeedsDisplay];
}

- (CQLCDPanelType)panelType {
    return _panelType;
}

- (UIImage *)bottomImageForPanelType:(CQLCDPanelType)panelType {
    switch (panelType) {
        case CQLCDPanelTypeNoButtons:
            return [UIImage imageNamed:@"CQLCDFullPanelBottom0Buttons.png"];
        case CQLCDPanelTypeTwoButtons:
            return [UIImage imageNamed:@"CQLCDFullPanelBottom2Buttons.png"];
        case CQLCDPanelTypeThreeButtons:
            return [UIImage imageNamed:@"CQLCDFullPanelBottom3Buttons.png"];
        case CQLCDPanelTypeFiveButtonsPortrait:
            return [UIImage imageNamed:@"CQLCDFullPanelBottom5Buttons.png"];
        default:
            return nil;
    }
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    switch (self.panelType) {
        case CQLCDPanelTypeNoButtons:
        case CQLCDPanelTypeTwoButtons:
        case CQLCDPanelTypeThreeButtons:
        case CQLCDPanelTypeFiveButtonsPortrait:
            [self showPortraitPanel];
            break;
        case CQLCDPanelTypeNoButtonsGrey:
            [self showGreyPortraitPanel];
            break;
        case CQLCDPanelTypeFiveButtonsLandscape:
            [self showButtonedLandscapePanel];
            break;
        case CQLCDPanelTypeNoButtonsLandscape:
            [self showButtonlessLandscapePanel];
            break;
        default:
            break;
    }
}



#pragma mark - Views Layers

- (void)showPortraitPanel {
    [UIView animateWithDuration:0.5 animations:^{
        [self portraitPanel].alpha = 1;
        [[self portraitPanel].bottomPanel setImage:[self bottomImageForPanelType:self.panelType]];
        _greyPortraitPanel.alpha = 0;
        _buttonedLandscapePanel.alpha = 0;
        _buttonlessLandscapePanel.alpha = 0;
    }];
}

- (void)showGreyPortraitPanel {
    [UIView animateWithDuration:0.5 animations:^{
        _portraitPanel.alpha = 0;
        [self greyPortraitPanel].alpha = 1;
        _buttonedLandscapePanel.alpha = 0;
        _buttonlessLandscapePanel.alpha = 0;
    }];
}

- (void)showButtonlessLandscapePanel {
    [UIView animateWithDuration:0.5 animations:^{
        _portraitPanel.alpha = 0;
        _greyPortraitPanel.alpha = 0;
        [self buttonlessLandscapePanel].alpha = 1;
        _buttonedLandscapePanel.alpha = 0;
    }];
}

- (void)showButtonedLandscapePanel {
    [UIView animateWithDuration:0.5 animations:^{
        _portraitPanel.alpha = 0;
        _greyPortraitPanel.alpha = 0;
        _buttonlessLandscapePanel.alpha = 0;
        [self buttonedLandscapePanel].alpha = 1;
    }];
}


#pragma mark - Getters

- (CQLCDPortraitPanel *)portraitPanel {
    if (_portraitPanel == nil) {
        _portraitPanel = [[NSBundle mainBundle] loadNibNamed:@"CQLCDPortraitPanel" owner:self options:nil].firstObject;
        [self setupSubview:_portraitPanel];
    }
    return _portraitPanel;
}

- (CQLCDGreyPortraitPanel *)greyPortraitPanel {
    if (_greyPortraitPanel == nil) {
        _greyPortraitPanel = [[NSBundle mainBundle] loadNibNamed:@"CQLCDGreyPortraitPanel" owner:self options:nil].firstObject;
        [self setupSubview:_greyPortraitPanel];
    }
    return _greyPortraitPanel;
}

- (CQLCDButtonlessLandscapePanel *)buttonlessLandscapePanel {
    if (_buttonlessLandscapePanel == nil) {
        _buttonlessLandscapePanel = [[NSBundle mainBundle] loadNibNamed:@"CQLCDButtonlessLandscapePanel" owner:self options:nil].firstObject;
        [self setupSubview:_buttonlessLandscapePanel];
    }
    return _buttonlessLandscapePanel;
}

- (CQLCDButtonedLandscapePanel *)buttonedLandscapePanel {
    if (_buttonedLandscapePanel == nil) {
        _buttonedLandscapePanel = [[NSBundle mainBundle] loadNibNamed:@"CQLCDButtonedLandscapePanel" owner:self options:nil].firstObject;
        [self setupSubview:_buttonedLandscapePanel];
    }
    return _buttonedLandscapePanel;
}

- (void)setupSubview:(UIView *)subview {
    subview.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:subview];
    [self sendSubviewToBack:subview];
    [self containView:subview toView:self];
}

@end
