//
//  AlertDialog+Extension.m
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/28.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import "AlertDialog+Extension.h"

@implementation AlertDialog (Extension)

- (instancetype)showDefaultAlert {
    [self addAction:@"知道了" style:AlertActionStyleDefault handler:nil];
    return self;
}

- (instancetype)addCancelAction {
    return [self addAction:@"取消" style:AlertActionStyleCancel handler:nil];
}

@end
