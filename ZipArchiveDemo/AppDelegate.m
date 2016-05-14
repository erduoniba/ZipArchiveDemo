//
//  AppDelegate.m
//  ZipArchiveDemo
//
//  Created by Harry on 16/5/14.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "AppDelegate.h"
#import "ZipArchive.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    BOOL zipFileCreateState = [self zipPractice];
    if (zipFileCreateState) {
        [self unZipPractice];
    }
    
    return YES;
}

- (BOOL )zipPractice{
    ZipArchive *zip = [[ZipArchive alloc] init];
    NSString *doucment = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *zipFilePath = [doucment stringByAppendingString:@"/image.zip"];
    NSLog(@"zipFilePath: %@", zipFilePath);
    BOOL zipFileCreateState = [zip CreateZipFile2:zipFilePath Password:@"hd"];
    
    NSString *image1 = [[NSBundle mainBundle] pathForResource:@"smile" ofType:@".png"];
    NSString *image2 = [[NSBundle mainBundle] pathForResource:@"angry" ofType:@".png"];
    BOOL zipImageState1 = [zip addFileToZip:image1 newname:@"simle"];
    BOOL zipImageState2 = [zip addFileToZip:image2 newname:@"angry"];
    
    NSLog(@"zipFileCreateState : %d  zipImageState1: %d zipImageState2: %d", zipFileCreateState, zipImageState1, zipImageState2);
    
    if ([zip CloseZipFile2]) {
        NSLog(@"关闭zip压缩");
    }
    
    return zipFileCreateState;
}

- (void)unZipPractice{
    ZipArchive *zip = [[ZipArchive alloc] init];
    NSString *doucment = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *zipFilePath = [doucment stringByAppendingString:@"/image.zip"];
    NSLog(@"zipFilePath: %@", zipFilePath);
    
    NSString *unZipFilePath = [doucment stringByAppendingString:@"/imageHD"];
    if ([zip UnzipOpenFile:zipFilePath Password:@"hd"]) {
        if ([zip UnzipFileTo:unZipFilePath overWrite:YES]) {
            NSLog(@"解压成功");
            
            [zip UnzipCloseFile];
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
