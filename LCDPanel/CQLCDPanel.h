//
//  CQLCDFullPanel.h
//  Cryptoquips
//
//  Created by Andrew King on 2015-03-08.
//
//

#import <UIKit/UIKit.h>

/**
 * Determines this images to be used as the background.
 */
typedef NS_ENUM(NSInteger, CQLCDPanelType) {
    CQLCDPanelTypeNoButtons            = 0, /**< Used for tableViews */
    CQLCDPanelTypeTwoButtons           = 1, /**< Used for a panel with Facebook and Twitter buttons */
    CQLCDPanelTypeThreeButtons         = 2, /**< Used for a panel with Facebook, Twitter and Favorite buttons */
    CQLCDPanelTypeNoButtonsGrey        = 3, /**< Used for tableViews */
    CQLCDPanelTypeFiveButtonsPortrait  = 4, /**< Used for Congratulations Panel */
    CQLCDPanelTypeFiveButtonsLandscape = 5, /**< Used for the Congratulations Panel */
    CQLCDPanelTypeNoButtonsLandscape   = 6, /**< Used for the Level Complete Info Panel */
};


@interface CQLCDPanel : UIView

@property (nonatomic, assign) CQLCDPanelType panelType;

@end
