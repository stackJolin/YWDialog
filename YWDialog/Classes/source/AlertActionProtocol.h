//
//  AlertActionProtocol.h
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/28.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AlertActionStyle) {
    AlertActionStyleDefault = 0,    // 默认
    AlertActionStyleCancel,         // 取消
    AlertActionStyleDestructive,    // 加红警示
    AlertActionStyleCustom          // 自定义
};

@protocol AlertActionProtocol<NSObject>

+ (instancetype)title:(NSString *)title
                style:(AlertActionStyle)style
              handler:(dispatch_block_t)handler;

@property (nonatomic, copy, readonly)       NSString *title;
@property (nonatomic, assign, readonly)     AlertActionStyle style;
@property (nonatomic, copy, readonly)       dispatch_block_t handler;

// MARK:=======AlertActionStyleCustom======

- (UIAlertActionStyle)transferStyle:(AlertActionStyle)style;
- (void)configAlertAction:(UIAlertAction *)action;

@optional

/** 文字颜色 */
- (instancetype)configTitleColor:(UIColor *)color;

/** 文本对齐方式，并没有什么叼应用场景，鸡肋，只能用于Alert，sheet不生效 */
- (instancetype)configTextAlignment:(NSTextAlignment)alignment;

/** 按钮是一个图片，叉号或者对勾.... */
- (instancetype)configImg:(UIImage *)img;

/** runtime下并没有暴露相关属性，并且alertaction不支持富文本 */
//- (instancetype)configBgImg:(UIImage *)img;
//- (instancetype)configBgColor:(UIColor *)color;
//- (instancetype)configTitleFont:(UIFont *)font;

@end
