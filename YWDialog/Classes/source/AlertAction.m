//
//  AlertAction.m
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/27.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import "AlertAction.h"

@interface AlertAction()

@property (nonatomic, strong) NSMutableDictionary *attributeDict;

@end

@implementation AlertAction

@synthesize handler = _handler;
@synthesize style = _style;
@synthesize title = _title;

+ (instancetype)title:(NSString *)title
                style:(AlertActionStyle)style
              handler:(dispatch_block_t)handler {
    
    return [[self alloc] initWithTitle:title
                                 style:style
                               handler:handler];
}

- (instancetype)initWithTitle:(NSString *)title
                        style:(AlertActionStyle)style
                      handler:(dispatch_block_t)handler {
    
    if (self = [super init]) {
        _title = title;
        _style = style;
        _handler = handler;
    }
    
    return self;
}

- (UIAlertActionStyle)transferStyle:(AlertActionStyle)style {
    if (style == AlertActionStyleDefault) {
        return UIAlertActionStyleDefault;
    }
    else if (style == AlertActionStyleCancel) {
        return UIAlertActionStyleCancel;
    }
    else if (style == AlertActionStyleDestructive) {
        return UIAlertActionStyleDestructive;
    }
    else if (style == AlertActionStyleCustom){
        return UIAlertActionStyleDefault;
    }
    
    return UIAlertActionStyleDefault;
}

- (void)configAlertAction:(UIAlertAction *)action {
    
    if (!self.attributeDict || self.attributeDict.allValues.count == 0) return;
    
    [self.attributeDict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        /** valueForKey无法判断该字段是否存在 */
//        if ([action valueForKey:key]) {
            [action setValue:obj forKey:key];
//        }
    }];
}

// MARK:=======KVC======
- (instancetype)configTitleColor:(UIColor *)color {
    
    [self.attributeDict setValue:color
                          forKey:@"titleTextColor"];
    return self;
}

- (instancetype)configTextAlignment:(NSTextAlignment)alignment {
    
    [self.attributeDict setValue:[NSNumber numberWithInteger:alignment]
                          forKey:@"titleTextAlignment"];
    
    return self;
}

- (instancetype)configImg:(UIImage *)img {
    if (img) [self.attributeDict setValue:img forKey:@"image"];
    
    return self;
}

//*****************************************************************
// MARK: - getter
//*****************************************************************

- (NSMutableDictionary *)attributeDict {
    if (!_attributeDict) {
        _attributeDict = [NSMutableDictionary new];
    }
    return _attributeDict;
}
@end
