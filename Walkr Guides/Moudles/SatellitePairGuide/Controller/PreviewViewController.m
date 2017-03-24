//
//  PreviewViewController.m
//  Walkr Guides
//
//  Created by GrayLand on 17/3/22.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import "PreviewViewController.h"
#import "Masonry.h"
#import "WGPairCell.h"

//let lightColor = UIColor(red: 0.4, green: 0.8, blue: 1.0, alpha: 1.0)
//let bgColor    = UIColor( red: 0.0706, green: 0.2, blue: 0.2627, alpha: 1.0 )
static NSString * const kSatellite = @"kSatellite";
static NSString * const kPlanet    = @"kPlanet";

@interface PreviewViewController ()
<UITableViewDelegate, UITableViewDataSource>
{
    UIColor *_lightColor;
    UIColor *_bgColor;
}
@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *sortPairs;

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lightColor = [UIColor colorWithRed:0.400 green:0.8 blue:1.000 alpha:1.000];
    _bgColor    = [UIColor colorWithRed:0.0706 green:0.2 blue:0.2627 alpha:1.000];
    
    self.view.backgroundColor = _bgColor;
    
    UIButton *backToGameBtn = [UIButton new];
    backToGameBtn.backgroundColor = _lightColor;
    backToGameBtn.layer.cornerRadius = 20;
    [backToGameBtn setTitle:@"回到游戏" forState:UIControlStateNormal];
    [backToGameBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backToGameBtn addTarget:self action:@selector(onBackToGame:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backToGameBtn];
    [backToGameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(backToGameBtn.superview).offset(-45);
        make.left.mas_equalTo(backToGameBtn.superview).offset(20);
        make.right.mas_equalTo(backToGameBtn.superview).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    _backBtn = [UIButton new];
    _backBtn.backgroundColor = _lightColor;
    _backBtn.layer.cornerRadius = 20;
    [_backBtn setTitle:@"返   回" forState:UIControlStateNormal];
    [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(onBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(backToGameBtn.mas_top).offset(-30);
        make.left.right.height.mas_equalTo(backToGameBtn);
        
//        make.top.mas_equalTo(20);
//        make.left.mas_equalTo(20);
//        make.right.mas_equalTo(_backBtn.superview).offset(-20);
//        make.height.mas_equalTo(40);
    }];
    

    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH) style:UITableViewStylePlain];
    _tableView.backgroundColor = _bgColor;
    _tableView.allowsSelection = NO;
    _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    _tableView.delegate        = self;
    _tableView.dataSource      = self;
    [self.view addSubview:_tableView];
    
    _tableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
//    NSString *planets = [[NSBundle mainBundle] pathForResource:@"default-planets" ofType:@"plist"];
//    NSDictionary *planetDic = [[NSDictionary alloc] initWithContentsOfFile:planets];
//    NSLog(@"%@", planetDic);//直接打印数据。
    
//    NSString *satellitePath = [[NSBundle mainBundle] pathForResource:@"galaxy-colony" ofType:@"plist"];
//    NSDictionary *tDic = [NSDictionary dictionaryWithContentsOfFile:satellitePath];
//    NSDictionary *satelliteDic = tDic[@"satellites"];
//    
//    NSMutableArray *orderPairArr    = [NSMutableArray arrayWithCapacity:satelliteDic.allKeys.count];
//    for (NSInteger i = 0; i < satelliteDic.allKeys.count; i++) {
//        [orderPairArr addObject:@{}];
//    }
//    
//    NSArray *allKeys = satelliteDic.allKeys;
//    for (NSString *key in allKeys) {
//        
//        NSDictionary *dic = satelliteDic[key];
//        
//        NSInteger order = [dic[@"order"] integerValue] - 1;
//        NSString *planet = dic[@"planet"];
//        NSString *satellite = key;
//        [orderPairArr replaceObjectAtIndex:order withObject:@{kSatellite:satellite,
//                                                              kPlanet:planet}];
//        
//    }
//    _sortPairs = orderPairArr;
//    [_sortPairs writeToFile:@"/Users/languilin/Desktop/WorkSpace2/temp/satellitePairs.dic" atomically:YES];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"satellitePairs" ofType:@"dic"];
    _sortPairs = [NSArray arrayWithContentsOfFile:path];
    
    [_tableView reloadData];
}

#pragma mark - OnEvent

- (void)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onBackToGame:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"walkrgame://"];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
#pragma mark - UITableViewDelegate, UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sortPairs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [WGPairCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"WGPairCell";
    WGPairCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WGPairCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.contentView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        cell.backgroundColor = _bgColor;
    }
    
    NSString *satellite = _sortPairs[indexPath.row][kSatellite];
    NSString *planet    = _sortPairs[indexPath.row][kPlanet];
    NSInteger index     = indexPath.row;

    [cell reloadWithSatellite:satellite planet:planet index:index];
    
    return cell;
}


@end
