//
//  FilePlguin.h
//  WebSquareHybridTemplate
//
//  Created by mhkim on 2021. 03. 25..
//
#import <Cordova/CDVPlugin.h>

@interface FilePlugin : CDVPlugin {
    NSString *callBackId;               // callback id
}
- (void)fileDownLoad:(CDVInvokedUrlCommand *)command;                //클립레포트 PDF 파일 다운로드

@end
