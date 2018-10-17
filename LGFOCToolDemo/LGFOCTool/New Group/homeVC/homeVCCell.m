//
//  homeVCCell.m
//  LGFOCTool
//
//  Created by apple on 2018/9/30.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import "homeVCCell.h"

@implementation homeVCCell

- (void)setIndex:(NSIndexPath *)index {
    _index = index;
    if (index.item % 2 == 0) {
        self.cellLeft.constant = 15;
        self.cellRight.constant = 5;
    } else {
        self.cellLeft.constant = 5;
        self.cellRight.constant = 15;
    }
}

@end
