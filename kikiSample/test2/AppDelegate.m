//
//  AppDelegate.m
//  test2
//
//  Created by ksfc on 2020/09/24.
//  Copyright © 2020 ksfc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

// 특정 ViewController만 Landscape 방향을 사용하도록 처리
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    //UIViewController * currentViewController = [self topViewController];
//    //
//    //NSLog(@"@@ supportedInterfaceOrientationsForWindow 1");
//    //// canLandScape 메서드가 정의되었는지 확인
//    //if ([currentViewController respondsToSelector:@selector(canLandScape)]) {
//    //    // 이 경우에만 Landscape orientation
//    //    NSLog(@"@@ supportedInterfaceOrientationsForWindow 12 ");
//    //    return UIInterfaceOrientationMaskLandscapeRight;
//    //}
//    //
//    //NSLog(@"@@ supportedInterfaceOrientationsForWindow 3");
//    //// 인지소프트 모듈 V3->V4 porting by mhkim
//    //if (currentViewController != nil && [currentViewController conformsToProtocol:@protocol(Rotatable)]) {
//    //   if ([((UIViewController <Rotatable> *)currentViewController) canRotateLandscape] == YES && [currentViewController isBeingDismissed] == NO) {
//    //       NSLog(@"@@ supportedInterfaceOrientationsForWindow 1234");
//    //       return UIInterfaceOrientationMaskLandscapeRight;
//    //   }
//    //}
//    //NSLog(@"@@ supportedInterfaceOrientationsForWindow 5");
//    // 나머지 경우에는 Portait orientation
//    return UIInterfaceOrientationMaskPortrait;
        
//}
@end
