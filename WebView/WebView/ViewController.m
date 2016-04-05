//
//  ViewController.m
//  WebView
//
//  Created by 何溪 on 16/4/5.
//  Copyright © 2016年 何溪. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)loadHtmlString:(id)sender;
- (IBAction)loadData:(id)sender;
- (IBAction)loadRequest:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadHtmlString:(id)sender {
    NSString *htmlPath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]];
    NSError *error = nil;
    NSString *html = [[NSString alloc]initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:&error];
    if (error == nil) {
        [self.webView loadHTMLString:html baseURL:bundleUrl];
    }
}

- (IBAction)loadData:(id)sender {
    NSString *htmlPath = [[NSBundle mainBundle]pathForResource:@"index" ofType:@"html"];
    NSURL *bundleUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]];
    NSData *htmlData = [[NSData alloc]initWithContentsOfFile:htmlPath];
    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:bundleUrl];
}

- (IBAction)loadRequest:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
//    self.webView.delegate = self;没有此行代码会导致webViewDidFinishLoad方法不执行
}

#pragma mark  -- UIWebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"coming....");
    NSLog(@"%@",[webView stringByEvaluatingJavaScriptFromString:@"document.body.innerhtml"]);
}
@end
