//
//  UIAlertController+Window.h
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/28.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Window)

- (void)ex_show;
- (void)ex_show:(BOOL)animated comp:(void (^)(void))comp;

@end
