//
//  ViewController.m
//  WebView
//
//  Created by ylm on 2018/9/29.
//  Copyright © 2018年 lm. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
@interface ViewController ()
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBarButtonItem];
}

- (void)setBarButtonItem
{
    //隐藏导航栏上的返回按钮
    [self.navigationItem setHidesBackButton:YES];
    //用来放searchBar的View
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
    //创建searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 30)];
    //默认提示文字
    searchBar.placeholder = @"http://baidu.com";
    searchBar.text = @"http://";
    //背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    //代理
    searchBar.delegate = self;
    //显示右侧取消按钮
    searchBar.showsCancelButton = YES;
    //光标颜色
    searchBar.tintColor = [UIColor blueColor];
    
    //拿到取消按钮
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    //设置按钮上的文字
    [cancleBtn setTitle:@"go" forState:UIControlStateNormal];
    //设置按钮上文字的颜色
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
       return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
       searchBar.showsCancelButton = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *urlStr = searchBar.text;
    [self presentWebViewWithUrl:urlStr];

}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSString *urlStr = searchBar.text;
    [self presentWebViewWithUrl:urlStr];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

- (void)presentWebViewWithUrl:(NSString*)urlStr{
    if(!urlStr || ![urlStr length]){
        urlStr = @"http://baidu.com";
    }
    if(![urlStr containsString:@"://"]){
        urlStr = [NSString stringWithFormat:@"http://%@",urlStr];
    }
    [[NSUserDefaults standardUserDefaults]setObject:urlStr forKey:@"lastUrl"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.searchBar resignFirstResponder];
    WebViewController *webVC = [[WebViewController alloc]init];
    webVC.urlStr = urlStr;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:webVC];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"lastUrl"]){
        self.searchBar.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastUrl"];
    }
    if (!_searchBar.isFirstResponder) {
        [self.searchBar becomeFirstResponder];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
