//
//  YWAlertDialog.h
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/29.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

/**
 继承自AlertDialog，主要用于链式语法。分类以及当前类的命名规则：
    - 追加动作用 ‘append’
    - 展示用 'present'
 */

#import "AlertDialog.h"

#define Dialog_Alert ([Dialog yw_alert])
#define Dialog_Sheet ([Dialog yw_sheet])

@interface Dialog : AlertDialog

@property (nonatomic, copy) Dialog *(^appendTitle)(DialogStringProtocol *title);
@property (nonatomic, copy) Dialog *(^appendMessage)(DialogStringProtocol *message);

@property (nonatomic, copy) Dialog *(^appendCancelActionWithTitle)(NSString *title);

@property (nonatomic, copy) Dialog *(^appendNorlmalAction)
                                            (NSString *title,
                                            dispatch_block_t handler);
@property (nonatomic, copy) Dialog *(^appendAction)
                                            (NSString *title,
                                            AlertActionStyle style,
                                            dispatch_block_t handler);

@property (nonatomic, copy) Dialog *(^appendCustomView)(UIView *view);
@property (nonatomic, copy) Dialog *(^appendTextFiled)(void (^)(UITextField *tf));
@property (nonatomic, copy) Dialog *(^appendTarget)(UIViewController *target);
@property (nonatomic, copy) Dialog *(^appendClickOutSideDimiss)(BOOL);
@property (nonatomic, copy) Dialog *(^present)(void);
@property (nonatomic, copy) Dialog *(^presentAnimated)(BOOL);

+ (instancetype)yw_alert;
+ (instancetype)yw_sheet;

@end
