//
//  YHWebViewProgress.h
//  YohoExplorerDemo
//
//  Created by gaoqiang xu on 3/25/15.
//  Copyright (c) 2015 gaoqiang xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHWebViewProgressViewProtocol.h"

@interface YHWebViewProgress : NSObject

@property (readonly, nonatomic) float progress;
@property (strong, nonatomic) UIView <YHWebViewProgressViewProtocol> *progressView;

- (void)reset;


// 外部使用时，不要调用该方法
- (BOOL)checkIfRPCURL:(NSURLRequest *)request;

@end
