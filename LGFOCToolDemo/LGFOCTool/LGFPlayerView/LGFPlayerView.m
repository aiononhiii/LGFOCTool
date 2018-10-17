////
////  LGFPlayerView.m
////  LGFOCTool
////
////  Created by apple on 2018/10/11.
////  Copyright © 2018年 来国锋. All rights reserved.
////
//
//#import "LGFPlayerView.h"
//#import "Masonry.h"
//
//@implementation LGFPlayerView
//
//lgf_XibAllocOnceForM(LGFPlayerView, @"LGFPlayerView");
//lgf_XibViewForM(LGFPlayerView, @"LGFPlayerView");
//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    [self installMovieNotificationObservers];
//}
//
//- (void)playWithUrl:(NSString *)url SV:(UIView *)SV {
//    if (SV) {
//        [self mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.mas_equalTo(SV);
//            make.center.mas_equalTo(SV);
//        }];
//    }
//    self.playUrl = [NSURL URLWithString:url];
//    if (![self.subviews containsObject:self.ijkPlayer.view]) {
//        self.ijkPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.playUrl withOptions:self.ijkOptions];
//        [self.ijkPlayer setScalingMode:IJKMPMovieScalingModeAspectFit];
//        [self insertSubview:self.ijkPlayer.view atIndex:0];
//        [self.ijkPlayer.view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.mas_equalTo(self);
//            make.center.mas_equalTo(self);
//        }];
//    }
//    if (!self.ijkPlayer.isPlaying || self.ijkPlayer.playbackState == IJKMPMoviePlaybackStateStopped) {
//        [self.ijkPlayer prepareToPlay];
//    }
//}
//
//#pragma mark - 隐藏工具栏
//- (void)hideToolView {
//    [UIView animateWithDuration:0.3 animations:^{
//        self.playerToolBackView.alpha = 0.0;
//    }];
//}
//- (BOOL)prefersStatusBarHidden { //设置隐藏显示
//    return YES;
//}
//#pragma mark - 显示工具栏
//- (void)showToolView {
//    [UIView animateWithDuration:0.3 animations:^{
//        self.playerToolBackView.alpha = 1.0;
//    }];
//    self.userInteractionEnabled = YES;
//}
//
//- (IBAction)selectToolView:(UITapGestureRecognizer *)sender {
//    if (self.playerToolBackView.alpha == 0.0) {
//        [self showToolView];
//    } else {
//        [self hideToolView];
//    }
//}
//
//#pragma mark - 暂停播放
//- (void)killLGFPlayerView {
//    self.playProgress.progress = 0.0;
//    self.playStartTime.text = @"00:00";
//    self.playEndTime.text = @"00:00";
//    [self.ijkPlayer shutdown];
//    [self.ijkPlayer.view removeFromSuperview];
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(update) object:nil];
//}
//
//- (IBAction)videoPan:(UIPanGestureRecognizer *)sender {
//    CGPoint translationPoint = [sender translationInView:sender.view];
//    NSLog(@"%f", translationPoint.x);
//    if (ABS(translationPoint.x) < 15) {
//        return;
//    }
//    if (sender.state == UIGestureRecognizerStateBegan) {
//        
//    } else if (sender.state == UIGestureRecognizerStateChanged) {
//        if (self.ijkPlayer.isPlaying) {
//            [self.ijkPlayer pause];
//        }
//        CGFloat current = self.ijkPlayer.currentPlaybackTime + self.ijkPlayer.duration * (translationPoint.x / self.lgf_width);
//        CGFloat total = self.ijkPlayer.duration;
//        self.playStartTime.text = [NSString lgf_GetVideoTimeLength:current delimit:@":" TimeFormatType:lgf_MS];
//        [self.playProgress setProgress:current / total animated:NO];
//    } else if (sender.state == UIGestureRecognizerStateEnded) {
//        self.ijkPlayer.currentPlaybackTime = self.ijkPlayer.currentPlaybackTime + self.ijkPlayer.duration * (translationPoint.x / self.lgf_width);
//        if (!self.ijkPlayer.isPlaying) {
//            [self.ijkPlayer play];
//        }
//        [sender setTranslation:CGPointZero inView:sender.view];
//    } else if (sender.state == UIGestureRecognizerStateCancelled) {
//        
//    } else if (sender.state == UIGestureRecognizerStateFailed) {
//        
//    }
//}
//
//- (IBAction)lock:(UIButton *)sender {
//    self.playerToolView.hidden = !sender.selected;
//    if (!sender.selected) {
//        [sender setImage:[UIImage imageNamed:@"lgf_lock.png"] forState:UIControlStateNormal];
//    } else {
//        [sender setImage:[UIImage imageNamed:@"lgf_unlock.png"] forState:UIControlStateNormal];
//    }
//    sender.selected = !sender.selected;
//}
//
//- (IBAction)play:(UIButton *)sender {
//    if (!sender.selected) {
//        [self.ijkPlayer pause];
//        [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
//    } else {
//        [self.ijkPlayer play];
//        [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
//    }
//    sender.selected = !sender.selected;
//}
//
//- (IBAction)fullScreen:(UIButton *)sender {
//    [self hideToolView];
//    self.userInteractionEnabled = NO;
//    lgf_HaveBlock(self.playerViewUnFullScreenBlock, self.ijkPlayer);
//}
//
//#pragma mark-更新方法
//
//-(void)update {
//    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(update) object:nil];
//    self.playStartTime.text = [NSString lgf_GetVideoTimeLength:self.ijkPlayer.currentPlaybackTime delimit:@":" TimeFormatType:lgf_MS];
//    CGFloat current = self.ijkPlayer.currentPlaybackTime;
//    CGFloat total = self.ijkPlayer.duration;
//    CGFloat able = self.ijkPlayer.playableDuration;
//    [self.playProgress setProgress:current / total animated:YES];
////    [self.playCacheProgress setProgress:able/total animated:YES];
//    [self performSelector:@selector(update) withObject:nil afterDelay:1.0];
//}
//
//#pragma mark-加载状态改变
//
//- (void)loadStateDidChange:(NSNotification*)notification {
//    IJKMPMovieLoadState loadState = self.ijkPlayer.loadState;
//    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
//        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
//        self.playEndTime.text = [NSString lgf_GetVideoTimeLength:self.ijkPlayer.duration delimit:@":" TimeFormatType:lgf_MS];
//    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
//        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
//    } else {
//        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
//    }
//}
//
//#pragma mark-播放状态改变
//- (void)moviePlayBackFinish:(NSNotification*)notification {
//    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
//    switch (reason) {
//        case IJKMPMovieFinishReasonPlaybackEnded:
//            NSLog(@"playbackStateDidChange: 播放完毕: %d\n", reason);
//            break;
//        case IJKMPMovieFinishReasonUserExited:
//            NSLog(@"playbackStateDidChange: 用户退出播放: %d\n", reason);
//            break;
//        case IJKMPMovieFinishReasonPlaybackError:
//            NSLog(@"playbackStateDidChange: 播放出现错误: %d\n", reason);
//            break;
//        default:
//            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
//            break;
//    }
//}
//
//#pragma mark - 准备播放
//- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
//    NSLog(@"mediaIsPrepareToPlayDidChange\n");
////    self.playerToolView.hidden = NO;
//}
//
//#pragma mark - 播放状态改变
//- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
//    
//    if (self.ijkPlayer.playbackState==IJKMPMoviePlaybackStatePlaying) {
//        //视频开始播放的时候开启计时器
//        [self performSelector:@selector(update) withObject:nil afterDelay:1.0];
//    }
//    
//    switch (self.ijkPlayer.playbackState) {
//        case IJKMPMoviePlaybackStateStopped:
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)self.ijkPlayer.playbackState);
//            [self killLGFPlayerView];
//            [self playWithUrl:self.playUrl.absoluteString SV:nil];
//            break;
//        case IJKMPMoviePlaybackStatePlaying:
//            [self performSelector:@selector(update) withObject:nil afterDelay:1.0];
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)self.ijkPlayer.playbackState);
//            break;
//        case IJKMPMoviePlaybackStatePaused:
//            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(update) object:nil];
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)self.ijkPlayer.playbackState);
//            break;
//        case IJKMPMoviePlaybackStateInterrupted:
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)self.ijkPlayer.playbackState);
//            break;
//        case IJKMPMoviePlaybackStateSeekingForward:
//        case IJKMPMoviePlaybackStateSeekingBackward: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)self.ijkPlayer.playbackState);
//            break;
//        }
//        default: {
//            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)self.ijkPlayer.playbackState);
//            break;
//        }
//    }
//}
//
//#pragma mark-观察视频播放状态
//
//- (void)installMovieNotificationObservers {
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(loadStateDidChange:)
//                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
//                                               object:self.ijkPlayer];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayBackFinish:)
//                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
//                                               object:self.ijkPlayer];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
//                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
//                                               object:self.ijkPlayer];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(moviePlayBackStateDidChange:)
//                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
//                                               object:self.ijkPlayer];
//    
//}
//
//- (void)removeMovieNotificationObservers {
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
//                                                  object:self.ijkPlayer];
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
//                                                  object:self.ijkPlayer];
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
//                                                  object:self.ijkPlayer];
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
//                                                  object:self.ijkPlayer];
//    
//}
//
//#pragma mark - 懒加载
//
//- (IJKFFOptions *)ijkOptions {
//    if (!_ijkOptions) {
//        _ijkOptions = [IJKFFOptions optionsByDefault];
//        [_ijkOptions setOptionIntValue:IJK_AVDISCARD_DEFAULT forKey:@"skip_frame" ofCategory:kIJKFFOptionCategoryCodec];
//        [_ijkOptions setOptionIntValue:IJK_AVDISCARD_DEFAULT forKey:@"skip_loop_filter" ofCategory:kIJKFFOptionCategoryCodec];
//        [_ijkOptions setOptionIntValue:0 forKey:@"videotoolbox" ofCategory:kIJKFFOptionCategoryPlayer];
//        [_ijkOptions setOptionIntValue:60 forKey:@"max-fps" ofCategory:kIJKFFOptionCategoryPlayer];
//        [_ijkOptions setPlayerOptionIntValue:256 forKey:@"vol"];
//    }
//    return _ijkOptions;
//}
//
//@end
