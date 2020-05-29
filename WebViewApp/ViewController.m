//
//  ViewController.m
//  WebViewApp
//
//  Created by  eadkenny on 2020/5/25.
//  Copyright © 2020  eadkenny. All rights reserved.
//

#import "ViewController.h"
#import "JgwWebVC.h"

@interface ViewController ()
@property (nonatomic, retain)UIView *launchView;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  JgwWebVC *vc = [[JgwWebVC alloc] init];
  // 正式
  vc.strUrl = @"https://xc.jgwcjm.com/#/main/index?sysId=d4b8d31666774af4b9d28443945093fa&organizationId=dd7e4587b1be444797f91733f67cf069";
  // 测试
//  vc.strUrl = @"http://digitalvillage.kf315.net/#/main/index?organizationId=8137ceb00d5e40f3ac210589fa993eb6&sysId=2dc15c65b93f4f33b3098eb1dddbb084";
  
//  vc.strUrl = @"https://digitalvillage.kf315.net/#/main/index?organizationId=8137ceb00d5e40f3ac210589fa993eb6&sysId=2dc15c65b93f4f33b3098eb1dddbb084";
//  vc.strUrl = @"http://192.168.60.22:3006/#/main/index?organizationId=8137ceb00d5e40f3ac210589fa993eb6&sysId=2dc15c65b93f4f33b3098eb1dddbb084";
  __weak ViewController *weakSelf = self;
  vc.loadFinishedBlock = ^{
    [weakSelf fadeoutAnimate];
  };
  [self addChildViewController:vc];
  [self.view addSubview:vc.view];
  [self showAnimate];
}

- (void)showAnimate {

  UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];

  UIView *launchView = viewController.view;
  launchView.frame = self.view.bounds;
  [self.view addSubview:launchView];
  self.launchView = launchView;
}

- (void)fadeoutAnimate {
  __weak ViewController *weakSelf = self;
  [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
    weakSelf.launchView.alpha = 0.0f;
    weakSelf.launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
  } completion:^(BOOL finished) {
    [weakSelf.launchView removeFromSuperview];
  }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
