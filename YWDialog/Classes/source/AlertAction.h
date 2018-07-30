//
//  AlertAction.h
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/27.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlertActionProtocol.h"

@interface AlertAction : NSObject <AlertActionProtocol>

- (void)configAlertAction:(UIAlertAction *)action;

@end
