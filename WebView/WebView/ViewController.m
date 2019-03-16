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
    

    // Do any additional setup after loading the view, typically from a nib.
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
    searchBar.placeholder = @"https://www.qimai.cn/";
    searchBar.text = @"https://www.baidu.com/";
    //背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    //代理
    searchBar.delegate = self;
    //显示右侧取消按钮
    searchBar.showsCancelButton = YES;
    //光标颜色
    searchBar.tintColor = [UIColor blueColor];
    //拿到searchBar的输入框
    UITextField *searchTextField = [searchBar valueForKey:@"_searchField"];
    //字体大小
    searchTextField.font = [UIFont systemFontOfSize:15];
    //输入框背景颜色
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
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
    if(![urlStr containsString:@"http://"] && ![urlStr containsString:@"https://"]){
        urlStr = [NSString stringWithFormat:@"http://%@",urlStr];
    }
    
    [self.searchBar resignFirstResponder];
    WebViewController *webVC = [[WebViewController alloc]init];
    webVC.urlStr = urlStr;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSString *urlStr = searchBar.text;
    if(![urlStr containsString:@"http://"] && ![urlStr containsString:@"https://"]){
        urlStr = [NSString stringWithFormat:@"http://%@",urlStr];
    }
    
    [self.searchBar resignFirstResponder];
    WebViewController *webVC = [[WebViewController alloc]init];
    webVC.urlStr = urlStr;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{

}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
