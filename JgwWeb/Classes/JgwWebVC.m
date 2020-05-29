//
//  JgwWebVC.m
//  WebViewApp
//
//  Created by  eadkenny on 2020/5/22.
//  Copyright © 2020  eadkenny. All rights reserved.
//

#import "JgwWebVC.h"
#import <WebKit/WebKit.h>
#import "YHWebViewProgressView.h"

@interface JgwWebVC ()<WKNavigationDelegate>

@property (nonatomic, readonly, retain)WKWebView *webView;

@end

@implementation JgwWebVC

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self initWebview];
  if (_strUrl.length > 0) {
    self.strUrl = _strUrl;
  }
}

- (void)initWebview
{
  WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
  
  WKUserContentController *userContentCtrller = [WKUserContentController new];
  
  configuration.userContentController = userContentCtrller;
  
  WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
  webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  webView.allowsBackForwardNavigationGestures = YES;
  [self.view addSubview:webView];
  webView.navigationDelegate = self;
//  webView.UIDelegate = self;
  _webView = webView;
  
  // 创建进度条
  YHWebViewProgressView *progressView = [[YHWebViewProgressView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 4)];
  progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
  // 指定WKWebView对象来监听进度
  [progressView useWkWebView:webView];
  [self.view addSubview:progressView];
}

- (void)setStrUrl:(NSString *)strUrl
{
    _strUrl = strUrl;
    if (self.webView)
    {
        NSURL *url;
        if ([strUrl isKindOfClass:[NSString class]] && strUrl.length > 0)
        {
            url = [NSURL URLWithString:strUrl];
        }
        else if ([strUrl isKindOfClass:[NSURL class]])
        {
            url = (NSURL *)strUrl;
        }
        if (url == nil)
        {
            NSString *str = [strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            str = [str stringByReplacingOccurrencesOfString:@"%23" withString:@"#"];
            url = [NSURL URLWithString:str];
            
            if (url == nil)
            {
                return;
            }
        }
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
  decisionHandler(WKNavigationActionPolicyAllow); // 必须实现 加载
  if (_loadFinishedBlock) {
    self.loadFinishedBlock();
    self.loadFinishedBlock = nil;
  }
//  if ([webView.URL.absoluteString isEqualToString:self.strUrl]) {
//  } else {
//    decisionHandler(WKNavigationActionPolicyCancel);
//    JgwWebVC *vc = [[JgwWebVC alloc] init];
//    vc.strUrl = webView.URL.absoluteString;
//    [self.navigationController pushViewController:vc animated:YES];
//  }
  NSLog(@"decidePolicyForNavigationAction:decisionHandler:");
}
///*
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction preferences:(WKWebpagePreferences *)preferences decisionHandler:(void (^)(WKNavigationActionPolicy, WKWebpagePreferences *))decisionHandler API_AVAILABLE(macos(10.15), ios(13.0)) {
  NSLog(@"decidePolicyForNavigationAction:preferences:");
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
  NSLog(@"decidePolicyForNavigationResponse:decisionHandler:");
  decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
  NSLog(@"didStartProvisionalNavigation:");
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
  NSLog(@"didReceiveServerRedirectForProvisionalNavigation:");
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
  NSLog(@"didFailProvisionalNavigation:withError:%@", error);
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
  NSLog(@"didCommitNavigation:");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
  NSLog(@"didFinishNavigation:");
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
  NSLog(@"didFailNavigation:withError:");
}
// 权限认证
//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
//  NSLog(@"didReceiveAuthenticationChallenge:completionHandler:");
//}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macos(10.11), ios(9.0)) {
  NSLog(@"webViewWebContentProcessDidTerminate:");
}//*/
@end
