//
//  PlayerViewController.m
//  VideoPlayer
//
//  Created by apple on 17/3/16.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "PlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)play:(UIButton *)sender {
    MPMoviePlayerViewController *ctr = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:@"http://zyvideo1.oss-cn-qingdao.aliyuncs.com/zyvd/7c/de/04ec95f4fd42d9d01f63b9683ad0"]];
    [self presentViewController:ctr animated:YES completion:nil];
}

@end
