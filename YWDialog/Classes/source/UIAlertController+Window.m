//
//  UIAlertController+Window.m
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/28.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import "UIAlertController+Window.h"
#import "AlertBackWindow.h"
#import "AlertControllerInfo.h"

@implementation UIAlertController (Window)

- (void)ex_show {
    [self ex_show:YES comp:nil];
}

- (void)ex_show:(BOOL)animated comp:(void (^)(void))comp {

    AlertControllerInfo *info = [AlertControllerInfo new];
    info.alert = self;
    info.isAnimatedShow = animated;
    info.comp = comp;
    
    [AlertBackWindow shared].window.hidden = NO;
    [[AlertBackWindow shared] regist:info];
    [[AlertBackWindow shared].window.rootViewController presentViewController:self animated:animated completion:^{
        comp();
    }];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [[AlertBackWindow shared] resign:^(AlertControllerInfo *alert) {
        if (!alert || !alert.alert)  return;
        
        [[AlertBackWindow shared].window.rootViewController presentViewController:alert.alert animated:alert.isAnimatedShow completion:alert.comp];
    }];
}

@end
