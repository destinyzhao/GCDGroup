//
//  ViewController.m
//  GCDGroup
//
//  Created by Alex on 16/5/20.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [self test1:^{
        NSLog(@"1");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [self test2:^{
        NSLog(@"2");
        dispatch_group_leave(group);
    }];
    
    dispatch_group_notify(group,dispatch_get_main_queue(),^{
        NSLog(@"更新UI");
    });

}

- (void)test1:(void(^)())complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        [NSThread sleepForTimeInterval:1];
        complete();
    });
}

- (void)test2:(void(^)())complete
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        [NSThread sleepForTimeInterval:6];
        complete();
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
