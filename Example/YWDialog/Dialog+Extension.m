//
//  YWDialog+Extension.m
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/29.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import "Dialog+Extension.h"

@implementation Dialog (Extension)

//*****************************************************************
// MARK: - getter
//*****************************************************************
- (Dialog *(^)(NSString *))presentDefaultAlert {
    return ^(NSString *message) {
        self.appendTitle(@"")
        .appendMessage(message)
        .appendNorlmalAction(@"知道了", nil)
        .present();
        return self;
    };
}

- (Dialog *(^)(void))appendCancelAction {
    return ^() {
        [self addCancelActionWithTitle:@"取消"];
        return self;
    };
}

//*****************************************************************
// MARK: - setter
//         分类中所有的属性的setter方法都是为了消除警告以及调用分类属性声明setter方法时的崩溃
//*****************************************************************
- (void)setPresentDefaultAlert:(Dialog *(^)(NSString *))presentDefaultAlert{}
- (void)setAppendCancelAction:(Dialog *(^)(void))appendCancelAction{}

@end
