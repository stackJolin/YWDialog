//
//  AlertBackWindow.h
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/28.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

/**
  短时间内弹出多个弹框的时候，存储然后顺序展示。UIAlertView是存储展示的，而UIAlterController不是，
  需要按照业务需求来自定义。这里，UIAlertController多个同时show的使用沿用了UIAlertView的策略-存储然后顺序展示
 */


#import <UIKit/UIKit.h>
#import "AlertControllerInfo.h"

@interface AlertBackWindow : NSObject

@property (nonatomic, strong) UIWindow *window;

+ (instancetype)shared;

+ (void)attemptDealloc;

- (void)resign:(void (^)(AlertControllerInfo *))comp;

- (void)regist:(AlertControllerInfo *)alertInfo;

@end
