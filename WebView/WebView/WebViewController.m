//
//  WebViewController.m
//  WebView
//
//  Created by ylm on 2018/9/29.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "WebViewController.h"
static NSString *const  backImg = @"iVBORw0KGgoAAAANSUhEUgAAAEgAAABIBAMAAACnw650AAAAG1BMVEUAAAAzMzM2NjY0NDQzMzM4ODgzMzM0NDQzMzPciteJAAAACXRSTlMA/lHYGQruYighBah6AAAAS0lEQVRIx2MYBaOApoA1gAhFahmE1TAJihNWpChoSoRBwg5EGGQyatDINSgMYRBhRZRbx6A4atSoUSiFGOXFIaJgJVxEj4JRQEsAAOYOEBOOQ7hTAAAAAElFTkSuQmCC";

static NSString *const  closeImg = @"iVBORw0KGgoAAAANSUhEUgAAAEgAAABIBAMAAACnw650AAAAMFBMVEUAAAA0NDQ0NDQ5OTkzMzMzMzMzMzMzMzMzMzMzMzMzMzM1NTU2NjY0NDQ2NjYzMzOtBEhrAAAAD3RSTlMAnc4SX6Rv5t+vh2BHQSGi0fSdAAAArUlEQVRIx+3QsQkCQRBG4TlEYyvQEoTLzK4by7ACsQTtQEuwCQs58EwUxuVnuYvGh8bzogmGb5m1LMv+aHee5u0hWNr34zjbDMHSxZdWa/0dLDXej5B3FrQWJehhFlMIiSJIFEKiCBKFkChBQA2CiCoQNXe/GtV6ORAqp3nP0KsciFDXEKU/KhRB+naERBEkCiFRBIn6ChF1ElSpZ7B0FFSp6L37bZoXK8uy7Pc+RU5X+mkNWt0AAAAASUVORK5CYII=";



@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *leftBgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [leftButton setImage:[self ADTImageWithBase64Data:backImg] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [leftBgview addSubview: leftButton];
    UIBarButtonItem*left =[[UIBarButtonItem alloc] initWithCustomView:leftBgview];
    //    self.navigationItem.leftBarButtonItem = left;
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width =  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)? 0:-10;
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)) {
        leftButton.contentEdgeInsets =UIEdgeInsetsMake(0, -8,0, 8);
        leftButton.imageEdgeInsets =UIEdgeInsetsMake(0, -8,0, 8);
        //leftButton.hitEdgeInsets =UIEdgeInsetsMake(0, -6, 0, 0);
    }
    //self.navigationItem.leftBarButtonItems = @[spaceItem,left];
    
    
    UIView *rightBgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
    [rightButton setImage:[self ADTImageWithBase64Data:closeImg] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [rightBgview addSubview: rightButton];
    UIBarButtonItem*right =[[UIBarButtonItem alloc] initWithCustomView:rightBgview];
    if (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)) {
        rightButton.contentEdgeInsets =UIEdgeInsetsMake(0, 8,0, -8);
        rightButton.imageEdgeInsets =UIEdgeInsetsMake(0, 8,0, -8);
        //leftButton.hitEdgeInsets =UIEdgeInsetsMake(0, -6, 0, 0);
    }
    self.navigationItem.rightBarButtonItems = @[spaceItem,right];
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKPreferences *preference = [[WKPreferences alloc]init];
    preference.javaScriptEnabled = YES;
    [preference setValue:@YES forKey:@"allowFileAccessFromFileURLs"];
    config.preferences = preference;
    config.allowsInlineMediaPlayback = YES;
    config.requiresUserActionForMediaPlayback = NO;

    
    _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:config];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.opaque = NO;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;

    [self.view addSubview:self.webView];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
    
    [self.webView loadRequest:request];
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIImage*)ADTImageWithBase64Data:(NSString*)base64Str{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[UIImage alloc]initWithData:data];
}

- (void)cancel{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
        decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);

}


- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{

}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}



@end
