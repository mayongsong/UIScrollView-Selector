//
//  ViewController.m
//  UIScrollViewSelectedObject
//
//  Created by mys on 15/11/24.
//  Copyright © 2015年 mys. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
{
    CAGradientLayer *_rightGradientLayer;
    CAGradientLayer *_leftGradientLayer;
    UIView *_layerView;
}

@property (weak, nonatomic) IBOutlet UIScrollView *sc;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (assign, nonatomic) int currentIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    [self createUI];
}

- (void) loadData {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 10; i < 100; i ++) {
            [self.dataArray addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
}

- (void) createUI {
    for (int i = 0; i < self.dataArray.count; i ++) {
        UIButton *but = [UIButton buttonWithType: UIButtonTypeCustom];
        but.frame = CGRectMake((50) * i, 0, 50, 50);
        [but setTitle: self.dataArray[i] forState:UIControlStateNormal];
        but.backgroundColor = [UIColor greenColor];
        [self.sc addSubview: but];
    }
    self.sc.contentSize = CGSizeMake(50 * self.dataArray.count, 50);
    
    _layerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.sc.bounds.size.width + 1, self.sc.bounds.size.height)];
    
    _rightGradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    _rightGradientLayer.bounds = _layerView.bounds;
    _rightGradientLayer.borderWidth = 0;
    _rightGradientLayer.frame = _layerView.bounds;
    _rightGradientLayer.colors = [NSArray arrayWithObjects:
                             (id)[[UIColor clearColor] CGColor],
                             (id)[[UIColor whiteColor] CGColor], nil];
    _rightGradientLayer.startPoint = CGPointMake(0.6, 1);
    _rightGradientLayer.endPoint = CGPointMake(0.9, 1);
    
    _leftGradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    _leftGradientLayer.bounds = _layerView.bounds;
    _leftGradientLayer.borderWidth = 0;
    _leftGradientLayer.frame = _layerView.bounds;
    _leftGradientLayer.colors = [NSArray arrayWithObjects:
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor whiteColor] CGColor], nil];
    _leftGradientLayer.startPoint = CGPointMake(0.4, 1);
    _leftGradientLayer.endPoint = CGPointMake(0.1, 1);
    
    [_layerView.layer insertSublayer:_rightGradientLayer atIndex:0];
    [_layerView.layer insertSublayer: _leftGradientLayer atIndex:1];
    
    [self.sc addSubview: _layerView];
    
}

- (void) setSCContentOffset {
    [UIView animateWithDuration:0.1 animations:^{
        self.sc.contentOffset = CGPointMake(self.currentIndex * 50 + 25, 0);;
    }];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _layerView.center = CGPointMake(scrollView.contentOffset.x + _layerView.frame.size.width * 0.5, _layerView.center.y);
    self.currentIndex = scrollView.contentOffset.x / 50;
    [self performSelector:@selector(setSCContentOffset) withObject:nil afterDelay:0.5];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
