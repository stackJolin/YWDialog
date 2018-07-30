//
//  AlertDialog.m
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/27.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import "AlertDialog.h"

@interface AlertDialog()

@property (nonatomic, strong) NSMutableArray<AlertAction *> *actionArr;
@property (nonatomic, weak) UIViewController *target;
@property (nonatomic, strong) UIAlertController *dialog;
@property (nonatomic, strong) NSMutableArray *tfHandlerArr;
@property (nonatomic, strong) UIView *customView;

@end

@implementation AlertDialog

// MARK:=======Alert======
+ (instancetype)alert {
    return [self style:AlertDialogStyleAlert];
}

// MARK:=======Sheet======
+ (instancetype)sheet {
    return [self style:AlertDialogStyleActionSheet];
}

// MARK:=======Init======
+ (instancetype)style:(AlertDialogStyle)style {
    
    return [self style:style
                 title:nil
               message:nil];
}

+ (instancetype)style:(AlertDialogStyle)style
                title:(DialogStringProtocol *)title
              message:(DialogStringProtocol *)message {
    
    return [self style:style
                 title:title
               message:message
                action:nil];
}

+ (instancetype)style:(AlertDialogStyle)style
                title:(DialogStringProtocol *)title
              message:(DialogStringProtocol *)message
               action:(AlertAction *)action {
    
    return [self style:style
                 title:title
               message:message
               actions:action? @[action] : nil];
}

+ (instancetype)style:(AlertDialogStyle)style
                title:(DialogStringProtocol *)title
              message:(DialogStringProtocol *)message
              actions:(NSArray<AlertAction *> *)actions {
    
    return [[self alloc] initWithStyle:style
                                 title:title
                               message:message
                               actions:actions];
}

- (instancetype)init {
    if (self = [super init]) {
        self = [[AlertDialog init] initWithStyle:AlertDialogStyleAlert
                                           title:nil
                                         message:nil
                                         actions:nil];
    }
    return self;
}

- (instancetype)initWithStyle:(AlertDialogStyle)style
                        title:(DialogStringProtocol *)title
                      message:(DialogStringProtocol *)message
                      actions:(NSArray<AlertAction *> *)actions {
    if (self = [super init]) {
        if (title) _title = title;
        if (message) _message = message;
        if (actions) _actionArr = [NSMutableArray arrayWithArray:actions];
        _style = style;
        _dismissAnimated = YES;
        
    }
    return self;
}

// MARK:=======addAction - 加返回值便于OC的链式编程======

- (instancetype)addCancelActionWithTitle:(NSString *)title {
    return [self addAction:title style:AlertActionStyleCancel handler:nil];
}

- (instancetype)addNormalAction:(NSString *)title
                        handler:(dispatch_block_t)handler {
    return [self addAction:title style:AlertActionStyleDefault handler:handler];
}

- (instancetype)addAction:(NSString *)title
                    style:(AlertActionStyle)style
                  handler:(dispatch_block_t)handler {
    
    if (title && handler) {
        AlertAction *action = [AlertAction title:title style:style handler:handler];
        [self.actionArr addObject:action];
    }
    return self;
}

- (instancetype)addAction:(AlertAction *)action {
    if (action) [self.actionArr addObject:action];
    return self;
}

- (instancetype)addCustomView:(UIView *)view {
    self.customView = view;
    return self;
}

- (instancetype)addTextField:(void (^)(UITextField *textField))tf {
    [self.tfHandlerArr addObject:tf];
    return self;
}

//- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler;

- (instancetype)addTarget:(UIViewController *)target {
    if (![target isKindOfClass:[UIViewController class]]) return self;
    
    self.target = target;
    return self;
}

- (instancetype)setClickOutSideDismiss:(BOOL)dismiss {
    _clickOutSideDimiss = dismiss;
    return self;
}

// MARK:=======Show and Dismiss======
- (void)show {
    [self show:YES];
}

- (void)show:(BOOL)animated {
    
    if (!self.title) _title = @"";
    if (!self.message) _message = @"";
    
    self.dialog = [UIAlertController alertControllerWithTitle:@""
                                                      message:@""
                                               preferredStyle:[self transferStyle:self.style]];
    
    if ([self.title isKindOfClass:[NSString class]]) {
        self.dialog.title = (NSString *)_title;
    }
    else if ([self.title isKindOfClass:[NSAttributedString class]]) {
        [self.dialog setValue:_title forKey:@"attributedTitle"];
    }
    
    if ([self.message isKindOfClass:[NSString class]]) {
        self.dialog.message = (NSString *)_message;
    }
    else if ([self.title isKindOfClass:[NSAttributedString class]]) {
        [self.dialog setValue:_message forKey:@"attributedMessage"];
    }
    
    [self addTextFiledsIntoDialog];
    
    //
//    if (self.customView) {
//        [self.dialog.view addSubview:self.customView];
//    }
    
    void (^show)(BOOL) = ^(BOOL animated) {
        if (self.target) {
            [self.target presentViewController:self.dialog animated:animated completion:^{
                if (self.clickOutSideDimiss) [self addClickOutSideGes];
            }];
        }
        else {
            [self.dialog ex_show:animated comp:^{
                if (self.clickOutSideDimiss) [self addClickOutSideGes];
            }];
        }
    };
    
    /** 动作不存在的时候，默认点击提示框之外的区域是消失的 */
    if (!self.actionArr || self.actionArr.count == 0) {
        self.clickOutSideDimiss = YES;
        show(animated);
        return;
    }
    
    [self addActionsIntoDialog];
    
    show(animated);
}

- (void)dismiss {
    [self dismiss:YES];
}

- (void)dismiss:(BOOL)animated {
    [self.dialog dismissViewControllerAnimated:animated completion:nil];
}

// MARK:=======兼容老版本======

- (void)setAttrMessage:(NSMutableAttributedString *)attrMessage {
    _attrMessage = attrMessage;
    [self.dialog setValue:attrMessage forKey:@"attributedMessage"];
}

- (void)showExAlertView:(UIViewController *)parentViewController {
    [parentViewController presentViewController:self.dialog animated:YES completion:nil];
}

- (void)showAlertView {
    [self.dialog ex_show];
}

- (instancetype)initWithStyle:(AlertDialogStyle)style {
    if (self = [super init]) {
        _style = style;
    }
    return self;
}

//*****************************************************************
// MARK: - 私有方法
//*****************************************************************

- (void)addTextFiledsIntoDialog {
    if (self.style != AlertDialogStyleAlert) return;
    
    if (self.tfHandlerArr && self.tfHandlerArr.count > 0) {
        [self.tfHandlerArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.dialog addTextFieldWithConfigurationHandler:obj];
        }];
    }
}

/**
 * UIAlertController 只能有一个按钮的样式为 UIAlertActionStyleCancel
 */
- (void)addActionsIntoDialog {
    __block BOOL cancelStyleExist = NO;
    [self.actionArr enumerateObjectsUsingBlock:^(AlertAction * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        AlertActionStyle style = obj.style;
        if (cancelStyleExist && obj.style == AlertActionStyleCancel) {
            style = AlertActionStyleDefault;
        }
        
        NSString *title = @"";
        if ([obj.title isKindOfClass:[NSString class]]) {
            title = (NSString *)obj.title;
        }
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj.title
                                                         style:[obj transferStyle:style]
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           if (obj.handler) obj.handler();
                                                       }];
        
        [obj configAlertAction:action];
        
        if (obj.style == AlertActionStyleCancel) cancelStyleExist = YES;
        [self.dialog addAction:action];
    }];
}

- (UIAlertControllerStyle)transferStyle:(AlertDialogStyle)style {
    if (style == AlertDialogStyleAlert) return UIAlertControllerStyleAlert;
    if (style == AlertDialogStyleActionSheet) return UIAlertControllerStyleActionSheet;
    return UIAlertControllerStyleAlert;
}

- (void)addClickOutSideGes {
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSelf:)];
    [self.dialog.view.superview addGestureRecognizer:ges];
}

- (void)clickSelf:(UITapGestureRecognizer *)ges {
    [self.dialog dismissViewControllerAnimated:self.dismissAnimated completion:nil];
}

//*****************************************************************
// MARK: - getter
//*****************************************************************

- (NSMutableArray<AlertAction *> *)actionArr {
    if (!_actionArr) {
        _actionArr = [NSMutableArray<AlertAction *> new];
    }
    return _actionArr;
}

- (NSMutableArray *)tfHandlerArr {
    if (!_tfHandlerArr) {
        _tfHandlerArr = [NSMutableArray new];
    }
    return _tfHandlerArr;
}
@end
