//
//  LGFAllSpecialMethod.m
//  LGFOCTool
//
//  Created by apple on 2017/5/2.
//  Copyright © 2017年 来国锋. All rights reserved.
//

#import "LGFAllMethod.h"
#import "LGFOCTool.h"

@implementation LGFAllMethod

+ (void)lgf_ScrollHideForTopView:(UIView *)topView hideHeight:(CGFloat)hideHeight scrollView:(UIScrollView *)scrollView animateDuration:(NSTimeInterval)animateDuration {
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    [UIView animateWithDuration:animateDuration animations:^{
        if (translation.y > 0) {
            if (topView.transform.ty == -hideHeight) {
                topView.transform = CGAffineTransformIdentity;
            }
        } else if (translation.y < 0) {
            if (scrollView.contentOffset.y > hideHeight) {
                if (topView.transform.ty == 0) {
                    topView.transform = CGAffineTransformMakeTranslation(0, -hideHeight);
                }
            } else {
                if (topView.transform.ty == -hideHeight) {
                    topView.transform = CGAffineTransformIdentity;
                }
            }
        }
    }];
}

+ (void)lgf_SortCellWithGesture:(UILongPressGestureRecognizer *)sender collectionView:(UICollectionView *)collectionView cellHeight:(CGFloat)cellHeight {
    if (lgf_IOSSystemVersion(9.0)) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        CGPoint point = [sender locationInView:collectionView];
        NSIndexPath *indexPath = [collectionView indexPathForItemAtPoint:point];
        switch (sender.state) {
            case UIGestureRecognizerStateBegan:
                if (!indexPath) { break; }
                BOOL canMove = [collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
                if (!canMove) { break; }
                break;
            case UIGestureRecognizerStateChanged:
                [collectionView updateInteractiveMovementTargetPosition:CGPointMake(MIN(MAX(cellHeight, point.x), collectionView.frame.size.width - cellHeight), MIN(MAX(cellHeight, point.y), collectionView.frame.size.height - cellHeight))];
                break;
            case UIGestureRecognizerStateEnded:
                [collectionView endInteractiveMovement];
                break;
            default:
                [collectionView cancelInteractiveMovement];
                break;
        }
#pragma clang diagnostic pop
    }
}

#pragma mark - 根据PNG图片url获取PNG图片尺寸
+ (CGSize)lgf_GetPNGImageSizeWithUrl:(NSURL *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data.length == 8) {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

#pragma mark - 根据GIF图片url获取GIF图片尺寸
+ (CGSize)lgf_GetGIFImageSizeWithUrl:(NSURL *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

#pragma mark - 根据JPG图片url获取JPG图片尺寸
+ (CGSize)lgf_GetJPGImageSizeWithUrl:(NSURL *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

#pragma mark - 返回可用系统内存容量
+ (CGFloat)lgf_GetDiskFreeSize {
    NSDictionary *systemAttributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    CGFloat diskFreeSize = [[systemAttributes objectForKey:@"NSFileSystemFreeSize"] floatValue];
    return diskFreeSize;
}

@end
