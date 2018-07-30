//
//  AlertBackWindow.m
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/28.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import "AlertBackWindow.h"

@interface AlertBackWindow()

@property (nonatomic, strong) NSMutableArray *alerts;

@end

@implementation AlertBackWindow

static AlertBackWindow *alertInstance = nil;
static dispatch_once_t alertOnceToken;

+ (instancetype)shared {
    
    dispatch_once(&alertOnceToken, ^{
        alertInstance = [[self alloc] init];
    });
    return alertInstance;
}

+ (void)attemptDealloc {
    alertInstance = nil;
}

- (void)dealloc {
    NSLog(@"释放了，哈哈哈哈");
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = [[UIViewController alloc] init];
        self.window.rootViewController.view.backgroundColor = [UIColor clearColor];
        id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
        
        if ([delegate respondsToSelector:@selector(window)]) {
            self.window.tintColor = delegate.window.tintColor;
        }
        
        UIWindow *topWindow = [UIApplication sharedApplication].windows.lastObject;
        self.window.windowLevel = topWindow.windowLevel + 1;
        
        [self.window makeKeyAndVisible];
    }
    return self;
}

//*****************************************************************
// MARK: - action
//*****************************************************************

- (void)resign:(void (^)(AlertControllerInfo *))comp {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (self.alerts.count == 0) {
                comp(nil);
                [AlertBackWindow reset];
                return;
            }
            
            [self.alerts removeObjectAtIndex:0];
            if (self.alerts.count > 0) {
                comp(self.alerts.firstObject);
            }
            else {
                [self.window resignKeyWindow];
                [AlertBackWindow shared].window.hidden = YES;
                comp(nil);
                [AlertBackWindow reset];
            }
        });
    });
}

- (void)regist:(AlertControllerInfo *)alertInfo {
    if (!alertInfo || !alertInfo.alert) return;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.alerts addObject:alertInfo];
        });
    });
}

+ (void)reset {
    alertOnceToken = 0;
    alertInstance = nil;
}

//*****************************************************************
// MARK: - getter
//*****************************************************************

- (NSMutableArray *)alerts {
    if (!_alerts) {
        _alerts = [NSMutableArray new];
    }
    return _alerts;
}

@end
