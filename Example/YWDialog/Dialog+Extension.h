//
//  YWDialog+Extension.h
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/29.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import <YWDialog/Dialog.h>

@interface Dialog (Extension)

//*****************************************************************
// MARK: - 链式属性不要调用setter方法，无效
//*****************************************************************

@property (nonatomic, copy) Dialog *(^presentDefaultAlert)(NSString *message);
@property (nonatomic, copy) Dialog *(^appendCancelAction)(void);

@end
