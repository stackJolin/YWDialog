//
//  AlertDialog.h
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/27.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

/**
  UIAlertViewController的封装，分为OC语法和链式语法，需要注意的是：OC语法不要和链式语法混用
  下面为了兼容NSString和NSMutableString使用了NSString和NSAttributeString共有的协议
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AlertAction.h"
#import "UIAlertController+Window.h"

/** 适配String和NSMutableString */
#define DialogStringProtocol NSObject<NSCopying, NSMutableCopying, NSSecureCoding>

#define Dialog_Sheet ([AlertDialog sheet])
#define Dialog_Alert ([AlertDialog alert])

typedef NS_ENUM(NSInteger, AlertDialogStyle) {
    AlertDialogStyleAlert = 0,         // alert
    AlertDialogStyleActionSheet        // sheet
};

@interface AlertDialog : NSObject

// MARK:=======Property======
@property (nonatomic, copy)                DialogStringProtocol *title;
@property (nonatomic, copy)                DialogStringProtocol *message;
@property (nonatomic, strong)              UIColor *colorTitle;
@property (nonatomic, assign, readonly)    AlertDialogStyle style;

/** 指定了target的情况下，不会生效 */
@property (nonatomic, assign)              BOOL clickOutSideDimiss;
@property (nonatomic, assign)              BOOL dismissAnimated;

// MARK:=======Init======
+ (instancetype)style:(AlertDialogStyle)style;

+ (instancetype)style:(AlertDialogStyle)style
                title:(DialogStringProtocol *)title
              message:(DialogStringProtocol *)message;

// MARK:=======Alert======
+ (instancetype)alert;

// MARK:=======Sheet======
+ (instancetype)sheet;

// MARK:=======addAction - 加返回值便于OC的链式编程======

- (instancetype)addCancelActionWithTitle:(NSString *)title;
- (instancetype)addNormalAction:(NSString *)title
                           handler:(dispatch_block_t)handler;

- (instancetype)addAction:(NSString *)title
                       style:(AlertActionStyle)style
                     handler:(dispatch_block_t)handler;

- (instancetype)addAction:(AlertAction *)action;

- (instancetype)addTextField:(void (^)(UITextField *textField))tf;

/**
  * 暂时空着，没有需求
 Note : 还没有验证系统的textfiled能否和自定义View兼容
 */
- (instancetype)addCustomView:(UIView *)view;

/**
  * 可以指定target
 */
- (instancetype)addTarget:(UIViewController *)target;

- (instancetype)setClickOutSideDismiss:(BOOL)dismiss;

// MARK:=======Show and Dismiss======

/**
  * 这两个show方法会展示在AlertBackWindow上，用于实现和alertView同样的效果，
    不会同时加载多个，而是顺序展示
 */
- (void)show;
- (void)show:(BOOL)animated;

- (void)dismiss;
- (void)dismiss:(BOOL)animated;

// MARK:=======兼容我们系统历史问题 - 不推荐使用======

@property (nonatomic, strong) NSMutableAttributedString *attrMessage DEPRECATED_MSG_ATTRIBUTE("the property is deprecated，please use property of 'message'");

- (void)showExAlertView:(UIViewController *)parentViewController DEPRECATED_MSG_ATTRIBUTE("the method is deprecated，please use method of 'show' or 'show:animated'");

- (void)showAlertView DEPRECATED_MSG_ATTRIBUTE("the method is deprecated，please use method of 'show' or 'show:animated'");

- (instancetype)initWithStyle:(AlertDialogStyle)style DEPRECATED_MSG_ATTRIBUTE("the method is deprecated，please use class method of 'style:'");

@end


