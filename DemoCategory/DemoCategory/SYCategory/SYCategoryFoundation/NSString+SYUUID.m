//
//  NSString+SYUUID.m
//  DemoCategory
//
//  Created by zhangshaoyu on 17/1/5.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "NSString+SYUUID.h"
#import <AdSupport/ASIdentifierManager.h>

static NSString *SYUDIDIdentifier = @"SYUDIDIdentifier";

@implementation NSString (SYUUID)

#pragma mark - UUID

+ (NSString *)UUID
{
    // 从手机设备的keyChain中获取（SSKeychain：https://github.com/samsoffes/sskeychain）
//    NSString *result = [SSKeychain passwordForService:UUIDService account:UUIDAccount];
    
    // 从手机设备的系统剪切板 UIPasteboard 中获取（使用generalPasteboard初始化，删除APP后仍有效）
    NSString *result = [[UIPasteboard generalPasteboard] string];
    
    if (result == nil || 0 == result.length)
    {
        // 1 CFUUID-iOS2.0
        result = [self CFUUIDString];
        
//        // 2 NSUUID-iOS6.0
//        result = [self NSUUIDString];
        
//        // 3 IDFA（广告标示符）-iOS6.0
//        result = [self IDFAString];
        
//        // 4 IDFV（Vindor标示符）-iOS6.0
//        result = [self IDFVString];
        
//        // 5 UDID 设备唯一标识（已被禁）
//        result = [self UDIDString];
        
//        // 6 OpenUDID：https://github.com/ylechelle/OpenUDID
//        result = [self OpenUDIDString];
        
        // 保存到keychain，或UIPasteboard
        [[UIPasteboard pasteboardWithUniqueName] setString:result];
    }

    return result;
}

+ (NSString *)CFUUIDString
{
    /* 1
     CFUUID-iOS2.0
     每次调用CFUUIDCreate，系统都会返回一个新的唯一标示符。
     如果你希望存储这个标示符，那么需要自己将其存储到NSUserDefaults, Keychain, Pasteboard或其它地方。
     */
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidString = CFUUIDCreateString(NULL, uuid);
    NSString *result = [NSString stringWithFormat:@"%@", uuidString];
    
    CFRelease(uuidString);
    CFRelease(uuid);
    
    return result;
}

+ (NSString *)NSUUIDString
{
    /* 2
     NSUUID-iOS6.0
     每次调用的时候都会获得一个新的唯一标示符
     */
    NSString *result = [[NSUUID UUID] UUIDString];
    
    return result;
}

+ (NSString *)IDFAString
{
    /* 3
     IDFA（广告标示符）-iOS6.0
     advertisingIdentifier是新框架AdSupport.framework的一部分。
     ASIdentifierManager单例提供了一个方法advertisingIdentifier，通过调用该方法会返回一个上面提到的NSUUID实例。
     注意添加 #import <AdSupport/ASIdentifierManager.h>
     */
    NSString *result = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    return result;
}

+ (NSString *)IDFVString
{
    /* 4
     IDFV（Vindor标示符）-iOS6.0
     获取这个IDFV的新方法被添加在已有的UIDevice类中。
     跟advertisingIdentifier一样，该方法返回的是一个NSUUID对象。
     注意：如果卸载了同一个vendor对应的所有程序，然后在重新安装同一个vendor提供的程序，此时identifierForVendor会被重置。
     */
    NSString *result = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    return result;
}

+ (NSString *)UDIDString
{
    /* 5
     UDID 设备唯一标识（已被禁）
     注意：在iOS5以及之后的版本中，以及被弃用了。
     */
    NSString *result = nil; // [[UIDevice currentDevice] uniqueIdentifier];
    
    return result;
}

+ (NSString *)OpenUDIDString
{
    /* 6
     OpenUDID：https://github.com/ylechelle/OpenUDID
     OpenUDID在工程中实现起来非常简单，并且还支持一系列的广告提供商。
     */
    NSString *result = nil;// [OpenUDID value];
    
    return result;
}


@end



