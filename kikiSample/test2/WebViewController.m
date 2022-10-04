//
//  WebViewController.m
//  test2
//
//  Created by ksfc on 2021/03/19.
//  Copyright © 2021 ksfc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()<WKNavigationDelegate, WKScriptMessageHandler>

@property (weak, nonatomic) IBOutlet WKWebView *webview;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    //self.webview = [[WKWebView alloc] initWithFrame:self.view.frame];
    
    WKWebViewConfiguration* config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController* jsctrl = [[WKUserContentController alloc] init];
    
    
    
    [jsctrl addScriptMessageHandler:self name:@"fileDownLoad"];
    [config setUserContentController:jsctrl];
    
    [self.webview setNavigationDelegate:self];
    
    self.webview = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];
    [self.view addSubview:self.webview];
    
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://naver.com"]];
    [self.webview loadRequest:request];

 
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"@@ 1. didCommitNavigation");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
       NSLog(@"@@ 2. didFinishNavigation");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
      NSLog(@"@@ 3. didFailNavigation error : %@", error);
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"@@ didReceiveScriptMessage message : %@", message);
    NSLog(@"@@ didReceiveScriptMessage message.name : %@", message.name);
    NSLog(@"@@ didReceiveScriptMessage message.body : %@", message.body);
    
    NSString * jsonStr = message.body;
    NSLog(@"@@ jsonStr: %@", jsonStr);


    if([message.name isEqualToString:@"fileDownLoad"]){

        [self fileDownLoad:message.body];
    }
}

-(void)fileDownLoad:(NSString*)fileURLString{
    NSLog(@"@@ fileDownLoad fileURLString : %@", fileURLString);
    NSString* dataUrl = fileURLString;
    NSURL* url = [NSURL URLWithString:dataUrl];
    NSLog(@"@@ fileDownLoad urlString : %@", [url absoluteString]);
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
        NSLog(@"@@ fileDownLoad response : %@", response);
        if(((NSHTTPURLResponse*)response).statusCode == 200) {
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString* documentsDirectory = [paths objectAtIndex:0];
            NSString* filePath = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"test.jpg"];
            NSLog(@"@@ fileDownLoad filepath : %@", filePath);
            [data writeToFile:filePath atomically:YES];
        }
    }];
    
    [downloadTask resume];
}

@end
