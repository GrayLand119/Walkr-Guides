//
//  WGTabBarController.m
//  Walkr Guides
//
//  Created by GrayLand on 16/4/19.
//  Copyright © 2016年 GrayLand. All rights reserved.
//

#import "WGTabBarController.h"
#import "WGNavigationViewController.h"
#import "Walkr_Guides-swift.h"
#import "WGConst.h"
#import "Masonry.h"


typedef NS_ENUM(NSUInteger, TabBarItemKey) {
    TabBarItemKeyTitle,
    TabBarItemKeyImageNameHeightLight,
    TabBarItemKeyImageNameNormal,
};


@interface WGTabBarController ()

@property (nonatomic, strong) NSMutableArray *tabBarItems;

@end

@implementation WGTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 1. Initialize default viewcontrollers
        [self initialzeViewControllersAndItems];
    }
    return self;
}

- (void)myPrint:(NSString *)string
{
    NSLog(@"%@",string);
}

- (void)initialzeViewControllersAndItems
{
    NSMutableArray *controllers = [NSMutableArray arrayWithObjects:@0,nil];
    _tabBarItems = [NSMutableArray arrayWithObjects:@0,@0, nil];
    // Satellite Guide View Controller
    {
        [_tabBarItems replaceObjectAtIndex:0 withObject:@{@(TabBarItemKeyTitle):@"卫星匹配",
                                                          @(TabBarItemKeyImageNameNormal):@"globe_normal",
                                                          @(TabBarItemKeyImageNameHeightLight):@"globe_hightlight"}];
        
        SatellitePairGuideViewController *vc = [[SatellitePairGuideViewController alloc] init];
        
        [controllers replaceObjectAtIndex:0 withObject:vc];
        
    }
    
    // Legend Task Guide View Controller
    {
//        [_tabBarItems replaceObjectAtIndex:1 withObject:@{@(TabBarItemKeyTitle):@"传说任务",
//                                                          @(TabBarItemKeyImageNameNormal):@"satellite_normal",
//                                                          @(TabBarItemKeyImageNameHeightLight):@"satellite_hightlight"}];
//        
//        UIViewController *vc = [[UIViewController alloc] init];
//
//        WGNavigationViewController *nvc = [[WGNavigationViewController alloc] initWithRootViewController:vc];
//        
//        [controllers replaceObjectAtIndex:1 withObject:nvc];
    }
    
    for(int i=0; i<controllers.count; i++)
    {
        id item = controllers[i];
        if(![item isKindOfClass:[UIViewController class]])
        {
            [controllers removeObjectAtIndex:i];
        }
    }
    self.viewControllers = controllers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *blurView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    blurView.backgroundColor = [UIColor colorWithRed:0.502 green:1.000 blue:0.000 alpha:1.000];


//    UIButton *titleBtn = [[UIButton alloc] init];
//    titleBtn.titleLabel.font = [UIFont systemFontOfSize:26];
//    [titleBtn setTitle:@"阿弥陀佛" forState:UIControlStateNormal];
//    [titleBtn setTitleColor:[UIColor colorWithRed:0.000 green:0.502 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
//    [blurView addSubview:titleBtn];
//    
//    [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(titleBtn.superview);
//        make.size.mas_equalTo(titleBtn.superview);
//    }];
//    [self.tabBar addSubview:blurView];
    
    
    self.tabBar.backgroundImage = [self pureColoredImageWithColor:[UIColor clearColor] size:self.tabBar.frame.size];
    self.tabBar.shadowImage     = [self pureColoredImageWithColor:[UIColor clearColor] size:self.tabBar.frame.size];
//    UITabBar *tabBar = [[UITabBar alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 100)];
//    self.tabBar = tabBar;
    

}

- (UIImage *)pureColoredImageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (UITabBarItem *)tabBarItemWithIndex:(NSInteger)index
{
    return [[UITabBarItem alloc] initWithTitle:_tabBarItems[index][TabBarItemKeyTitle]
                                         image:[UIImage imageNamed:_tabBarItems[index][TabBarItemKeyImageNameNormal]]
                                 selectedImage:[UIImage imageNamed:_tabBarItems[index][TabBarItemKeyImageNameHeightLight]]];
    
}


#pragma mark -
#pragma mark UITabBarDelegate
//- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
//{
//    NSInteger index = [self.tabBar.items indexOfObject:item];
//    
//}


//- (NSArray *)tabBarItemsAtIndexes:(NSIndexSet *)indexes{
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
