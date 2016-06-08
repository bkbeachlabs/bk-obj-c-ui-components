//
//  CQTableViewPanel.m
//  Cryptoquips
//
//  Created by Andrew King on 2015-03-06.
//
//

#import "CQTableViewPanel.h"

@implementation CQTableViewPanel {
    UIImageView *topImg;
    UIImageView *middleImg;
    UIImageView *bottomImg;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    topImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CQTableViewPanelTop"]];
    middleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CQTableViewPanelMiddle"]];
    bottomImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CQTableViewPanelBottom"]];
    
    topImg.frame = CGRectMake(0, 0, self.frame.size.width, 50);
    middleImg.frame = CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-150);
    bottomImg.frame = CGRectMake(0, self.frame.size.height-100, self.frame.size.width, 100);
    
    [self addSubview:topImg];
    [self addSubview:middleImg];
    [self addSubview:bottomImg];
    
    [self sendSubviewToBack:topImg];
    [self sendSubviewToBack:middleImg];
    [self sendSubviewToBack:bottomImg];
}

@end
