//
//  JgwWebVC.h
//  WebViewApp
//
//  Created by  eadkenny on 2020/5/22.
//  Copyright © 2020  eadkenny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JgwWebVC : UIViewController

@property (nonatomic, retain)NSString *strUrl;
@property (nonatomic, copy, nullable)void(^loadFinishedBlock)(void);

@end

NS_ASSUME_NONNULL_END
