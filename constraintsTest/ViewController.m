//
//  ViewController.m
//  constraintsTest
//
//  Created by Никита Тук on 30.09.14.
//  Copyright (c) 2014 test. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    topView.backgroundColor = [UIColor redColor];
    topView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 40, 160)];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:imageView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(80, 80, 200, 32)];
    self.label.backgroundColor = [UIColor yellowColor];
    self.label.text = @"some text";
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    [topView addSubview:self.label];

    
    self.tableView.tableHeaderView = topView;
    

    NSDictionary *views = @{@"imageView":imageView, @"label":self.label};

    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-margin-[imageView(40)]-(>=margin)-[label]-margin-|" options:0 metrics:@{@"margin": @30} views:views];
    NSArray *imageConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[imageView(160)]-20-|" options:0 metrics:nil views:views];
    NSArray *textConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[label]" options:0 metrics:nil views:views];
    NSArray *topConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[topView(320)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topView)];

    [topView addConstraints:constraints];
    [topView addConstraints:imageConstraints];
    [topView addConstraints:textConstraints];
    [topView addConstraints:topConstraints];

    [self addTextWithCompletionBlock:^{
        [self addTextWithCompletionBlock:^{
            [self addTextWithCompletionBlock:^{
                [self addTextWithCompletionBlock:^{
                    [self addTextWithCompletionBlock:nil];
                }];
            }];
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
