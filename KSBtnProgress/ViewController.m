//
//  ViewController.m
//  KSBtnProgress
//
//  Created by Kris on 2018/12/11.
//  Copyright © 2018年 Kris. All rights reserved.
//

#import "ViewController.h"

#import "UIButtonLongPress.h"

@interface ViewController ()

@property (nonatomic, strong)UIButtonLongPress *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.btn];
}

- (UIButtonLongPress *)btn {
    if (!_btn) {
        __weak typeof(self) wSelf = self;
        CGRect rect = CGRectMake(100, 100, 100, 100);
        _btn = [[UIButtonLongPress alloc]init];
        _btn.frame = rect;
        _btn.longPressDuration = 1;
        _btn.backgroundColor = [UIColor grayColor];
        _btn.layer.cornerRadius = 100/2;
        _btn.clipsToBounds = YES;
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_btn setTitle:@"长按" forState:UIControlStateNormal];
        _btn.completeBlock = ^{
            [wSelf btnLongProgressCompleted];
        };
    }
    return _btn;
}

- (void)btnLongProgressCompleted {
    NSLog(@"completeBlock === ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
