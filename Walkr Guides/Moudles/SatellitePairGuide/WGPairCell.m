//
//  WGPairCell.m
//  Walkr Guides
//
//  Created by GrayLand on 17/3/24.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import "WGPairCell.h"
#import "Masonry.h"

@interface WGPairCell ()

@property (nonatomic, strong) UILabel *satelliteNumLabel;

@property (nonatomic, strong) UIImageView *satelliteImgView;
@property (nonatomic, strong) UIImageView *planetImgView;

@end

@implementation WGPairCell

+ (CGFloat)cellHeight {
    return 100;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupViews];
    }
    
    return self;
}

- (void)reloadWithSatellite:(NSString *)satellite planet:(NSString *)planet index:(NSInteger)index{
    
    // 星球图片 default-[banana]-placeholder
    // 卫星图片 satellite-[christmas_star]
    UIImage *planetImg;
    if ([planet isEqualToString:@"all"]) {
        planetImg = [UIImage imageNamed:@"satellite-a-empty"];
    }else{
        NSString *imgName = [NSString stringWithFormat:@"default-%@-placeholder", planet];
        planetImg = [UIImage imageNamed:imgName];
    }
    _planetImgView.image = planetImg;
    
    NSString *imgName2 = [NSString stringWithFormat:@"satellite-%@", satellite];
    UIImage *satellieteImg = [UIImage imageNamed:imgName2];
    _satelliteImgView.image = satellieteImg;
    
    _satelliteNumLabel.text = [NSString stringWithFormat:@"%@", @(index)];
}

- (void)setupViews {
    
    self.backgroundColor = [UIColor clearColor];
    

    
    
    _planetImgView = [UIImageView new];
    _planetImgView.backgroundColor = [UIColor clearColor];
    _planetImgView.contentMode = UIViewContentModeCenter;
    [self addSubview:_planetImgView];
    [_planetImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_planetImgView.superview).offset(-40);
        make.centerY.mas_equalTo(_planetImgView.superview);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        
    }];
    
    _satelliteImgView = [UIImageView new];
    _satelliteImgView.backgroundColor = [UIColor clearColor];
    _satelliteImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_satelliteImgView];
    [_satelliteImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_planetImgView);
        make.right.mas_equalTo(_planetImgView.mas_left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    _satelliteNumLabel = [UILabel new];
    _satelliteNumLabel.font = [UIFont systemFontOfSize:12];
    _satelliteNumLabel.textColor = [UIColor whiteColor];
    [self addSubview:_satelliteNumLabel];
    [_satelliteNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_satelliteNumLabel.superview);
        make.right.mas_equalTo(_satelliteImgView.mas_left).offset(-20);
    }];
    
    _satelliteNumLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    _satelliteImgView.transform  = CGAffineTransformMakeRotation(M_PI_2);
    _planetImgView.transform     = CGAffineTransformMakeRotation(M_PI_2);
    
}

@end
