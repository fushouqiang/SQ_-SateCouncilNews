//
//  NSString+Categories.m
//  SQ_ SateCouncilNews
//
//  Created by Eiwodetianna on 3/28/14.
//  Copyright (c) 2014 Eiwodetianna. All rights reserved.
//

#import "NSString+Categories.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Categories)

/**
 *  计算 MD5 值
 *
 *  @param input
 *
 *  @return
 */
- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}

+ (BOOL)isEmpty:(NSString *)str trim:(BOOL)trim{
    if(str == nil || str.length == 0){
        return YES;
    }else{
        if(trim){
            return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0;
        }
    }
    return NO;
}

- (NSString *)urlEncode {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
