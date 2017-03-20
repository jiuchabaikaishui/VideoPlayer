//
//  ViewController.m
//  VideoPlayer
//
//  Created by apple on 17/3/16.
//  Copyright © 2017年 QSP. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()

@property (strong,nonatomic) MPMoviePlayerController *player;
@property (strong,nonatomic) NSMutableArray *thumbnailArr;

@end

@implementation ViewController
- (NSMutableArray *)thumbnailArr
{
    if (_thumbnailArr == nil) {
        _thumbnailArr = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _thumbnailArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"http://zyvideo1.oss-cn-qingdao.aliyuncs.com/zyvd/7c/de/04ec95f4fd42d9d01f63b9683ad0"]];
    [self.player prepareToPlay];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    self.player.view.frame = CGRectMake(0, 62, screenW, screenW*9/16);
    [self.view addSubview:self.player.view];
    [self.player play];
    
    // 1. 添加播放状态的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    // 2. 播放完成监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    // 3. 进入全屏监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterFullScreen:) name:MPMoviePlayerDidEnterFullscreenNotification object:nil];
    // 4. 退出全屏监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitFullScreen:) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    // 5. 截屏完成监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(thumbnail:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    [self.player requestThumbnailImagesAtTimes:@[@(10.0), @(20.0), @(30.0), @(40.0), @(50.0), @(60.0), @(70.0), @(80.0), @(90.0)] timeOption:MPMovieTimeOptionNearestKeyFrame];
}

- (void)playerChange:(NSNotification *)sender
{
    switch (self.player.playbackState) {
        case MPMoviePlaybackStateStopped:
        {
            NSLog(@"停止播放");
        }
            break;
        case MPMoviePlaybackStatePlaying:
        {
            NSLog(@"正在播放");
        }
            break;
        case MPMoviePlaybackStatePaused:
        {
            NSLog(@"暂停播放");
        }
            break;
        case MPMoviePlaybackStateInterrupted:
        {
            NSLog(@"播放被打断");
        }
            break;
        case MPMoviePlaybackStateSeekingForward:
        {
            NSLog(@"下一个");
        }
            break;
        case MPMoviePlaybackStateSeekingBackward:
        {
            NSLog(@"上一个");
        }
            break;
            
        default:
            break;
    }
}
- (void)playerFinish:(NSNotification *)sender
{
    NSLog(@"播放完成");
}
- (void)enterFullScreen:(NSNotification *)sender
{
    NSLog(@"全屏");
}
- (void)exitFullScreen:(NSNotification *)sender
{
    NSLog(@"退出全屏");
}
- (void)thumbnail:(NSNotification *)sender
{
    NSLog(@"%@", sender.userInfo);
    [self.thumbnailArr addObject:sender.userInfo[@"MPMoviePlayerThumbnailImageKey"]];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat spacing = 8;
    CGFloat W = (screenW - 4*spacing)/3;
    CGFloat H = W*9/16;
    for (UIImage *image in self.thumbnailArr) {
        NSInteger index = [self.thumbnailArr indexOfObject:image];
        CGFloat X = spacing + (index%3)*(spacing + W);
        CGFloat Y = 300 + (index/3)*(spacing + H);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(X, Y, W, H)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = image;
        [self.view addSubview:imageView];
    }
}

@end
