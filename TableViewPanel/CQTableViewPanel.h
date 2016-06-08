//
//  CQTableViewPanel.h
//  Cryptoquips
//
//  Created by Andrew King on 2015-03-06.
//
//

#import <UIKit/UIKit.h>

/**
 * The drawRect method of this panel adds an auto-stretching mechanism that allows for an adjustable-height panel.
 * The intention is that this can contain a scrollView, tableview, or collectionView, with space for a pageControl 
 * at the bottom.
 *
 * This is best used in conjunction with autolayout. 
 *
 * This view should have outer constraints of: left = 4px, right = 4px, top = 4px, bottom = 8px.
 * The contained table view should have outer constraints of: left = 7px, right = 6px, top = 9px, bottom = 20px.
 */
@interface CQTableViewPanel : UIView

@end
