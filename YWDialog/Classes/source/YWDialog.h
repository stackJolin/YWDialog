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

#define YWDialog_Alert ([YWDialog yw_alert])
#define YWDialog_Sheet ([YWDialog yw_sheet])

@interface YWDialog : AlertDialog

@property (nonatomic, copy) YWDialog *(^appendTitle)(DialogStringProtocol *title);
@property (nonatomic, copy) YWDialog *(^appendMessage)(DialogStringProtocol *message);

@property (nonatomic, copy) YWDialog *(^appendCancelActionWithTitle)(NSString *title);

@property (nonatomic, copy) YWDialog *(^appendNorlmalAction)
                                            (NSString *title,
                                            dispatch_block_t handler);
@property (nonatomic, copy) YWDialog *(^appendAction)
                                            (NSString *title,
                                            AlertActionStyle style,
                                            dispatch_block_t handler);

@property (nonatomic, copy) YWDialog *(^appendCustomView)(UIView *view);
@property (nonatomic, copy) YWDialog *(^appendTextFiled)(void (^)(UITextField *tf));
@property (nonatomic, copy) YWDialog *(^appendTarget)(UIViewController *target);
@property (nonatomic, copy) YWDialog *(^appendClickOutSideDimiss)(BOOL);
@property (nonatomic, copy) YWDialog *(^present)(void);
@property (nonatomic, copy) YWDialog *(^presentAnimated)(BOOL);

+ (instancetype)yw_alert;
+ (instancetype)yw_sheet;

@end
