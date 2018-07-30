//
//  YWAlertDialog.m
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/29.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import "YWDialog.h"

@implementation YWDialog

+ (instancetype)yw_alert {
    return [self style:AlertDialogStyleAlert];
}

+ (instancetype)yw_sheet {
    return [self style:AlertDialogStyleActionSheet];
}

//*****************************************************************
// MARK: - message and title
//*****************************************************************

- (YWDialog *(^)(DialogStringProtocol *))appendTitle {
    return ^(DialogStringProtocol *title) {
        self.title = title;
        return self;
    };
}

- (YWDialog *(^)(DialogStringProtocol *))appendMessage {
    return ^(DialogStringProtocol *message) {
        self.message = message;
        return self;
    };
}


//*****************************************************************
// MARK: - action
//*****************************************************************

- (YWDialog *(^)(NSString *))appendCancelActionWithTitle {
    return ^(NSString *title) {
        [self addCancelActionWithTitle:title];
        return self;
    };
}

- (YWDialog *(^)(NSString *, dispatch_block_t))appendNorlmalAction {
    return ^(NSString *title, dispatch_block_t block) {
        [self addAction:[AlertAction title:title style:AlertActionStyleDefault handler:block]];
        return self;
    };
}

- (YWDialog *(^)(NSString *, AlertActionStyle, dispatch_block_t))appendAction {
    return ^(NSString *title, AlertActionStyle style, dispatch_block_t handle) {
        [self addAction:[AlertAction title:title style:style handler:handle]];
        return self;
    };
}

- (YWDialog *(^)(void (^)(UITextField *)))appendTextFiled {
    return ^(void (^tf)(UITextField *)) {
        [self addTextField:tf];
        return self;
    };
}

- (YWDialog *(^)(UIView *))appendCustomView {
    return ^(UIView *v) {
        [self addCustomView:v];
        return self;
    };
}

- (YWDialog *(^)(UIViewController *))appendTarget {
    return ^(UIViewController *target) {
        [self addTarget:target];
        return self;
    };
}

- (YWDialog *(^)(BOOL))appendClickOutSideDimiss {
    return ^(BOOL clickOutSideDimiss) {
        [self setClickOutSideDismiss:clickOutSideDimiss];
        return self;
    };
}

- (YWDialog *(^)(void))present {
    return ^(){
        [self show];
        return self;
    };
}

- (YWDialog *(^)(BOOL))presentAnimated {
    return ^(BOOL animated) {
        [self show:animated];
        return self;
    };
}

@end
