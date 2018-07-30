//
//  YWDialog+Extension.h
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/29.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import <YWDialog/YWDialog.h>

@interface YWDialog (Extension)

//*****************************************************************
// MARK: - 链式属性不要调用setter方法，无效
//*****************************************************************

@property (nonatomic, copy) YWDialog *(^presentDefaultAlert)(NSString *message);
@property (nonatomic, copy) YWDialog *(^appendCancelAction)(void);

@end
