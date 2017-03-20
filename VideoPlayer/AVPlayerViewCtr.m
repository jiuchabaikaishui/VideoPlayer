//
//  AVPlayerViewController.m
//  VideoPlayer
//
//  Created by apple on 17/3/16.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "AVPlayerViewCtr.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerViewCtr ()<AVPlayerViewControllerDelegate>

@property (weak, nonatomic) AVPlayer *player;
@property (strong, nonatomic) AVPlayerViewController *playerController;

@end

@implementation AVPlayerViewCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //视频播放的url
    NSURL *playerURL = [NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
    //AVPlayerItem 视频的一些信息  创建AVPlayer使用的
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:playerURL];
    //通过AVPlayerItem创建AVPlayer
    AVPlayer *player = [[AVPlayer alloc]initWithPlayerItem:item];
    //给AVPlayer一个播放的layer层
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    //设置位置大小
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    layer.frame = CGRectMake(0, 64, screenW, screenW*9/16);
    //添加到图层
    [self.view.layer addSublayer:layer];
    self.player = player;
    
    //设置AVPlayer的填充模式
    layer.videoGravity = AVLayerVideoGravityResize;
    //初始化
    self.playerController = [[AVPlayerViewController alloc]init];
    // 设置是否显示媒体播放组件
    self.playerController.showsPlaybackControls = YES;
    //设置AVPlayerViewController内部的AVPlayer为刚创建的AVPlayer
    self.playerController.player = player;
    //设置代理
    self.playerController.delegate = self;
    //关闭AVPlayerViewController内部的约束
    self.playerController.view.translatesAutoresizingMaskIntoConstraints = YES;
}

- (IBAction)player:(UIButton *)sender {
    [self.player play];
}
- (IBAction)controllerPlayer:(UIBarButtonItem *)sender {
    [self presentViewController:self.playerController animated:YES completion:nil];
}

#pragma mark - <AVPlayerViewControllerDelegate>代理方法
// 1、即将开始画中画
- (void)playerViewControllerWillStartPictureInPicture:(AVPlayerViewCtr *)playerViewController {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
// 2、开始画中画
- (void)playerViewControllerDidStartPictureInPicture:(AVPlayerViewCtr *)playerViewController {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
// 3、即将结束画中画
- (void)playerViewControllerWillStopPictureInPicture:(AVPlayerViewCtr *)playerViewController {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
// 4、结束画中画
- (void)playerViewControllerDidStopPictureInPicture:(AVPlayerViewCtr *)playerViewController {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
// 5、画中画失败
- (void)playerViewController:(AVPlayerViewCtr *)playerViewController failedToStartPictureInPictureWithError:(NSError *)error {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
