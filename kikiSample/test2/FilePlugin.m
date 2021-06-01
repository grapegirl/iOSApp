//
//  FilePlguin.m
//  WebSquareHybridTemplate
//
//  Created by mhkim on 2021. 03. 25..
//

#import "FilePlugin.h"
#import <Cordova/CDV.h>

@interface FilePlugin()
@end

@implementation FilePlugin{
    
}

- (void)pluginInitialize {
}
- (void)fileDownload:(CDVInvokedUrlCommand *)command
{
    callBackId = command.callbackId;
    NSLog(@"@@ FilePlguin fileDownLoad  start");
    @try{
        NSString *jsonStr = [command.arguments objectAtIndex:0];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSMutableDictionary *jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
        NSString *url =[jsonObj objectForKey:@"url"];
        [self downLoad:url];
        NSLog(@"@@ FilePlguin fileDownLoad  url : %@", url);
        
        CDVPluginResult *pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@""];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }@catch(NSException *ee){
        CDVPluginResult *pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"ERROR"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    NSLog(@"@@ FilePlguin fileDownLoad  End");
}


-(void)downLoad:(NSString*)fileURLString{
    NSString* dataUrl = fileURLString;
    NSURL* url = [NSURL URLWithString:dataUrl];
    NSLog(@"@@ fileDownLoad urlString : %@", [url absoluteString]);
    
    NSURLSessionDataTask *downloadTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData* data, NSURLResponse* response, NSError* error){
        
        NSLog(@"@@ response : %@", response);
        if(((NSHTTPURLResponse*)response).statusCode == 200) {
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString* documentsDirectory = [paths objectAtIndex:0];
            NSLog(@"@@ documentsDirectory : %@", documentsDirectory);
            NSString *dataPath = [documentsDirectory stringByAppendingString:@"/DownLoads"];
            if(![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
                [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
            }
            NSString* filePath = [NSString stringWithFormat:@"%@/%@",dataPath,@"filename.pdf"];
            NSLog(@"@@ filePath : %@", filePath);
            [data writeToFile:filePath atomically:YES];
        }
    }];
    
    [downloadTask resume];
}
@end
