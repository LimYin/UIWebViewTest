//
//  WebViewController.h
//  WebView
//
//  Created by ylm on 2018/9/29.
//  Copyright © 2018年 lm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface WebViewController : UIViewController<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NSString *urlStr;
@end
