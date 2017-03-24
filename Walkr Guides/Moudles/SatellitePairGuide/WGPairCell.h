//
//  WGPairCell.h
//  Walkr Guides
//
//  Created by GrayLand on 17/3/24.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WGPairCell : UITableViewCell

+ (CGFloat)cellHeight;

- (void)reloadWithSatellite:(NSString *)satellite planet:(NSString *)planet index:(NSInteger)index;

@end
