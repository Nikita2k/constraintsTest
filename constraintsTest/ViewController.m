//
//  ViewController.m
//  constraintsTest
//
//  Created by Никита Тук on 30.09.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTextWithCompletionBlock:^{
        [self addTextWithCompletionBlock:^{
            [self addTextWithCompletionBlock:nil];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addTextWithCompletionBlock:(void (^)()) completionBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.label.text = [NSString stringWithFormat:@"Some text: %@", self.label.text];
            if (completionBlock) {
                completionBlock();
            }
        });
    });
}
@end
