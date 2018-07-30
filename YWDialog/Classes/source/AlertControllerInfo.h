//
//  AlertControllerInfo.h
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/28.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AlertControllerInfo : NSObject

@property (nonatomic, assign) BOOL isAnimatedShow;
@property (nonatomic, strong) UIAlertController *alert;
@property (nonatomic, copy)   void (^comp)(void);

@end
