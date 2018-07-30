//
//  ViewController.m
//  YWDialog
//
//  Created by zhuhoulin on 2018/7/27.
//  Copyright © 2018年 zhuhoulin. All rights reserved.
//

#import "YWViewController.h"
#import <objc/runtime.h>
#import "AlertDialog+Extension.h"
#import "YWDialog+Extension.h"

@interface YWViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;

@end

@implementation YWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.table];
    
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList(UIAlertController.class, &count);
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for(int i = 0; i < count; i ++){
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        //const char *type = ivar_getTypeEncoding(ivar);
        NSString *propertyName = [[NSString alloc] initWithUTF8String:name];
        [tempArray addObject:propertyName];
    }
}

- (void)viewDidLayoutSubviews {
    self.table.frame = self.view.bounds;
}

//*****************************************************************
// MARK: - delegates
//*****************************************************************

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"正常";
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"富文本title";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"富文本message";
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"自定义button样式";
    }
    else if (indexPath.row == 4) {
        
    }
    else if (indexPath.row == 5) {
        
    }
    else if (indexPath.row == 6) {
        
    }
    else if (indexPath.row == 7) {
        
    }
    else if (indexPath.row == 8) {
        
    }
    else if (indexPath.row == 9) {
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
        YWDialog_Alert
        .appendTitle(@"崔贺")
        .appendMessage(@"丫头")
        .appendNorlmalAction(@"哈哈哈", ^{
            
        })
        .appendNorlmalAction(@"哈哈哈", ^{
            
        })
        .appendNorlmalAction(@"哈哈哈", ^{
            
        })
        .appendTextFiled(^(UITextField *tf) {
            
        })
        .appendTarget(self)
        .present();
        //
        //        AlertDialog *zhuhoulin = [[[AlertDialog style:0 title:@"哈哈哈" message:@"哈哈哈"] addAction:@"哈哈哈" style:AlertActionStyleCancel handler:^{
        //
        //        }] addNormalAction:@"dddddd" handler:^{
        //
        //        }];
        
        //        [zhuhoulin show];
        
        [[[[[[AlertDialog style:0 title:@"急急急" message:@"哈哈哈"]
             addAction:@"哈哈哈" style:AlertActionStyleCancel handler:^{
                 
             }] addNormalAction:@"丫头 爱你" handler:^{
                 
             }] addAction:[[AlertAction title:@"fdfdfd" style:0 handler:^{
                 
             }] configTitleColor:[UIColor blackColor]]] setClickOutSideDismiss:YES] show];
        
        [[[[[AlertDialog style:0 title:@"yyyyyy" message:@"哈哈哈"] addAction:@"哈哈哈" style:AlertActionStyleCancel handler:^{
            
        }] addNormalAction:@"丫头 爱你" handler:^{
            
        }] addAction:[[AlertAction title:@"fdfdfd" style:0 handler:^{
            
        }] configTextAlignment:NSTextAlignmentLeft]] show];
        
    }
    else if (indexPath.row == 1) {
        YWDialog_Alert
        .appendTitle(@"崔贺")
        .appendMessage(@"丫头")
        .appendAction(@"ddd", 0, nil)
        .appendTarget(self)
        .appendClickOutSideDimiss(YES)
        .present();
    }
    else if (indexPath.row == 2) {
        
    }
    else if (indexPath.row == 3) {
        
    }
    else if (indexPath.row == 4) {
        
    }
    else if (indexPath.row == 5) {
        
    }
    else if (indexPath.row == 6) {
        
    }
    else if (indexPath.row == 6) {
        
    }
    else if (indexPath.row == 7) {
        
    }
    else if (indexPath.row == 8) {
        
    }
    else if (indexPath.row == 9) {
        
    }
}

- (UITableView *)table {
    if (!_table) {
        _table = [UITableView new];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

@end
