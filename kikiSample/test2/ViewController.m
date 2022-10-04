//
//  ViewController.m
//  test2
//
//  Created by ksfc on 2020/09/24.
//  Copyright © 2020 ksfc. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()


@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    self.edit.keyboardType = UIKeyboardTypeWebSearch ;
    
    self.edit.keyboardType = UIKeyboardTypeDefault;
    
    UIToolbar* toolbar = [UIToolbar new];
    [toolbar sizeToFit];
    toolbar.frame = CGRectMake(0, 410, 320, 50);
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:nil];
    UIBarButtonItem* item3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:item1, item2, item3, nil]];
    
    //    self.edit.inputAccessoryView = toolbar;
    self.edit.inputAccessoryView = nil;
    
    NSInteger code = [self checkBiometry];
    NSString *StrCode = [@(code) stringValue];
    self.edit.text = StrCode;
}

- (void)viewDidAppear:(BOOL)animated
{
    //[self alertMsg];
}

-(IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked !! ");
    //    [self.edit endEditing:YES];
    [self.view endEditing:YES];
    
    NSString* strText = self.edit.text;
    
    NSString* visibleText = self.textview.text;
    NSLog(@"strText : %@" ,strText);
    NSLog(@"visibleText : %@", visibleText);
    //  self.textview.text = visibleText +" "+ strText;
    
    self.textview.text = [NSString stringWithFormat:@"%@ %@", strText, visibleText];
}

- (IBAction)click:(id)sender {
    if(sender == self.button1)
    {
        NSLog(@"self.button1 clicked");
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        [UIViewController attemptRotationToDeviceOrientation];
    }
    else if(sender == self.button2)
    {
        NSLog(@"self.button2 clicked");
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeLeft) forKey:@"orientation"];
        [UINavigationController attemptRotationToDeviceOrientation];
    }
    else if( sender == self.btWebView)
    {
        NSLog(@"@@ click webView");
        //[self alertMsg:@"messga"];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController* view = [storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
        [self presentViewController:view animated:true completion:nil];
    }else if(sender == self.buttonFile)
    {
        [self fileDownLoad:@"https://www.navercorp.com/img/ko/naver/img_spot_summary.jpg"];
        
    }else if(sender == self.btnMsg)
    {
        [self alertMsg:@"hello world"];
    }else if(sender == self.btnCall)
    {
        NSString* strUrl = @"tel:01012345678"; 
        [self callEvent:strUrl];
    }
}


- (void)alertMsg:(NSString*)alertMsg
{
    //     if(@available(iOS 11, *)){
    //    //        NSLog(@"@@ 11이상");
    //    //    }else{
    //                  NSLog(@"@@ 11미만");
    UIAlertController * alert=   [UIAlertController alertControllerWithTitle:@"* 알림 *"
                                                                     message:alertMsg
                                                              preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action)
                         {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    
    
    
    [self presentViewController:alert animated:YES completion:nil];
    //}
}

- (NSInteger) checkBiometry
{
    //  현재 기기의 인증기술 상태 체크
    //  105:        얼굴
    //  -1105:      바이오인증기술을 지원하지 않음.
    //  -2105:      바이오인증기술을 지원하지만, 등록된 얼굴암호가 없음.
    //  -3105:      바이오인증기술을 지원하지만, 얼굴암호 인증을 여러차례 틀려서 바이오인증기술 기능이 잠김
    //  100:        지문
    //  -1100:      바이오인증기술을 지원하지 않음.
    //  -2100:      바이오인증기술을 지원하지만, 등록된 얼굴암호가 없음.
    //  -3100:      바이오인증기술을 지원하지만, 얼굴암호 인증을 여러차례 틀려서 바이오인증기술 기능이 잠김
    //  -1:         바이오인증기술 사용 불가능.
    
    LAContext *laContext = [[LAContext alloc] init];
    NSError *error = nil;
    NSLog(@"[sky]@@ %s:%d checkBiometry", __FILE_NAME__, __LINE__);
    if ( [laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error] ) {
        if ( error == nil ) {
            if ( @available(iOS 11.0, *) ) {
                NSLog(@"[sky]@@ %s:%d checkBiometry", __FILE_NAME__, __LINE__);
                if ( [laContext biometryType] == LABiometryTypeFaceID )
                    return 105;
                else if ( [laContext biometryType] == LABiometryTypeTouchID )
                    return 100;
            }
            else if ( @available(iOS 9.0, *) )
                return 100;
        }
    }
    
    if ( error != nil ) {
        if ( @available(iOS 11.0, *) ) {
            if ( [laContext biometryType] == LABiometryTypeFaceID ) {
                if ( [error code] == LAErrorBiometryLockout )
                    return -3105;
                else if ([error code] == LAErrorBiometryNotEnrolled )
                    return -2105;
                else
                    return -1105;
            }
            else if ( [laContext biometryType] == LABiometryTypeTouchID ) {
                if ( [error code] == LAErrorBiometryLockout )
                    return -3100;
                else if ([error code] == LAErrorBiometryNotEnrolled )
                    return -2100;
                else
                    return -1100;
            }
        }
        else if ( @available(iOS 9.0, *) ) {
            if ( [error code] == kLAErrorBiometryLockout )
                return -3100;
            else if ([error code] == kLAErrorBiometryNotEnrolled )
                return -2100;
            else
                return -1100;
        }
    }
    
    return -1;
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

-(void)callEvent:(NSString*)url{
    NSLog(@"@@ callEvent url : %@", url);
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]){
        if ( @available(iOS 10.0, *) ) {
            NSLog(@"@@ callEvent iOS 10 upper url : %@", url);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:nil completionHandler:nil];
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    }else{
        NSLog(@"@@ callEvent is not canOpen url : %@", url);
    }
    
}

@end
