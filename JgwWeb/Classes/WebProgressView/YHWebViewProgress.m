//
//  YHWebViewProgress.m
//  YohoExplorerDemo
//
//  Created by gaoqiang xu on 3/25/15.
//  Copyright (c) 2015 gaoqiang xu. All rights reserved.
//

#import "YHWebViewProgress.h"

NSString *completeRPCURLPath = @"/yhwebviewprogressproxy/complete";

static const float YHWebViewProgressInitialValue = 0.7f;
static const float YHWebViewProgressInteractiveValue = 0.9f;
static const float YHWebViewProgressFinalProgressValue = 0.9f;

@interface YHWebViewProgress ()
@property (nonatomic) NSUInteger loadingCount;
@property (nonatomic) NSUInteger maxLoadCount;
@property (strong, nonatomic) NSURL *currentURL;
@property (nonatomic) BOOL interactive;

@property (nonatomic) float progress;

@end

@implementation YHWebViewProgress

- (instancetype)init
{
    self = [super init];
    if (self) {
        _maxLoadCount = _loadingCount = 0;
        _interactive = NO;
    }
    
    return self;
}

- (void)dealloc
{
    
}

- (void)startProgress
{
    if (self.progress < YHWebViewProgressInitialValue) {
        [self setProgress:YHWebViewProgressInitialValue];
    }
}

- (void)incrementProgress
{
    float progress = self.progress;
    float maxProgress = self.interactive?YHWebViewProgressFinalProgressValue:YHWebViewProgressInteractiveValue;
    float remainPercent = (float)self.loadingCount/self.maxLoadCount;
    float increment = (maxProgress-progress) * remainPercent;
    progress += increment;
    progress = fminf(progress, maxProgress);
    [self setProgress:progress];
}

- (void)completeProgress
{
    [self setProgress:1.f];
}

- (void)setProgress:(float)progress
{
    if (progress > _progress || progress == 0) {
        _progress = progress;
        
        if (self.progressView) {
            [self.progressView setProgress:progress animated:YES];
        }
    }
}

- (void)reset
{
    self.maxLoadCount = self.loadingCount = 0;
    self.interactive = NO;
    [self setProgress:0.f];
}

- (BOOL)checkIfRPCURL:(NSURLRequest *)request
{
    if ([request.URL.path isEqualToString:completeRPCURLPath]) {
        [self completeProgress];
        return YES;
    }
    
    return NO;
}

#pragma mark - Method Forwarding
- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
}

@end
