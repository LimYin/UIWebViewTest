//
//  WebViewController.h
//  WebView
//
//  Created by ylm on 2018/9/29.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *urlStr;
@end
