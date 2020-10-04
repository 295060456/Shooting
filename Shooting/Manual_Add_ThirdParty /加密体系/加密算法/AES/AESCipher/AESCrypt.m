//
//  AESCrypt.m
//  GS_Jzfp
//
//  Created by 董向坤 on 2019/6/19.
//  Copyright © 2019 Dongxk. All rights reserved.
//

#import "AESCrypt.h"
#import <CommonCrypto/CommonCryptor.h>


@implementation AESCrypt

+ (NSString *)AES128Encrypt:(NSString *)plainText key:(NSString *)key{
    
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode, //ECB模式
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,     //没有补码
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
        //return [GTMBase64 stringByEncodingData:resultData];
        return [self hexStringFromData:resultData];
        
    }
    free(buffer);
    return nil;
}

+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key{
    
    char keyPtr[kCCKeySizeAES128 + 1]; //选择aes128加密，所以key长度应该是kCCKeySizeAES128，16位
    memset(keyPtr, 0, sizeof(keyPtr)); //清零
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];  //秘钥key转成cString
    
    //NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *data=[self dataForHexString:encryptText];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}

NSString const *kInitVector2 = @"4e92604801cc4d11";
size_t const kKeySize2 = kCCKeySizeAES128;
//size_t const kKeySize = kCCKeySizeAES256;

+ (NSData *)cipherOperationWithcontenDate:(NSData *)contentData key:(NSData *)keyData operation:(CCOperation)operation {
    
    NSUInteger dataLength = contentData.length;
    void const *initVectorBytes = [kInitVector2 dataUsingEncoding:NSUTF8StringEncoding].bytes;
    void const *contentBytes = contentData.bytes;
    void const *keyBytes = keyData.bytes;
    
    
    size_t operationSize = dataLength + kCCBlockSizeAES128;
    void *operationBytes = malloc(operationSize);
    if (operationBytes == NULL) {
        return nil;
    }
    size_t actualOutSize = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,    //加密/解密方式
                                          0,            //加密算法 0:aes
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,  //补码方式，以及是否选择ECB模式，默认是CBC模式
                                          
                                          keyBytes,   //传入的密钥，经过从cstring utf8转成字节类型
                                          kKeySize2,  //真正决定密钥长度
                                          initVectorBytes, //iv 初始化向量值 CBC模式下需要，不传默认16位0，ECB不需要
                                          contentBytes,   // dataIn 要加解密的数据data.bytes
                                          dataLength,     //dataInLength
                                          operationBytes, //dataOut  Result is written here
                                          operationSize,  //dataOutAvailable
                                          &actualOutSize  //dataOutMoved 操作成功之后，被写入dataout的字节长度  所以最后我们根据dataOutMoved从dataout截取我们最后获得的数据
                                          );
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:operationBytes length:actualOutSize];
    }
    free(operationBytes);
    operationBytes = NULL;
    return nil;
}

+ (NSString *)aesEncryptStringWithContent:(NSString *)content key:(NSString *)key {
    
    NSCParameterAssert(content);
    NSCParameterAssert(key);
    
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData     = [key     dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptedData = [self aesEncryptData:contentData keyData:keyData];
    
//    return [self hexStringFromData:encrptedData];
      return  [encrptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

+ (NSString *)aesDecryptStringWithContent:(NSString *)content key:(NSString *)key {
    
    NSCParameterAssert(content);
    NSCParameterAssert(key);
    
//    NSData *contentData = [self dataForHexString:content];
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *decryptedData = [self aesDecryptData:contentData keyData:keyData];
    
    return [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
}

+ (NSData *)aesEncryptData:(NSData *)contentData keyData:(NSData *)keyData {
   
    NSCParameterAssert(contentData);
    NSCParameterAssert(keyData);
    
    NSString *hint = [NSString stringWithFormat:@"The key size of AES-%lu should be %lu bytes!", kKeySize2 * 8, kKeySize2];
    NSCAssert(keyData.length == kKeySize2, hint);
    return [self cipherOperationWithcontenDate:contentData key:keyData operation:kCCEncrypt];
}

+ (NSData *)aesDecryptData:(NSData *)contentData keyData:(NSData *)keyData {
    NSCParameterAssert(contentData);
    NSCParameterAssert(keyData);
    
    NSString *hint = [NSString stringWithFormat:@"The key size of AES-%lu should be %lu bytes!", kKeySize2 * 8, kKeySize2];
    NSCAssert(keyData.length == kKeySize2, hint);
    return [self cipherOperationWithcontenDate:contentData key:keyData operation:kCCDecrypt];
}

// 普通字符串转换为十六进
+ (NSString *)hexStringFromData:(NSData *)data {
    Byte *bytes = (Byte *)[data bytes];
    // 下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for(int i=0; i<[data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i] & 0xff]; //16进制数
        newHexStr = [newHexStr uppercaseString];
        
        if([newHexStr length] == 1) {
            newHexStr = [NSString stringWithFormat:@"0%@",newHexStr];
        }
        hexStr = [hexStr stringByAppendingString:newHexStr];
    }
    return hexStr;
}


//十六进制转Data
+ (NSData*)dataForHexString:(NSString*)hexString{
    
    if (hexString == nil) {
        return nil;
    }
    const char* ch = [[hexString lowercaseString] cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* data = [NSMutableData data];
    while (*ch) {
        if (*ch == ' ') {
            continue;
        }
        char byte = 0;
        if ('0' <= *ch && *ch <= '9') {
            
            byte = *ch - '0';
        }else if ('a' <= *ch && *ch <= 'f') {
            
            byte = *ch - 'a' + 10;
        }else if ('A' <= *ch && *ch <= 'F') {
            
            byte = *ch - 'A' + 10;
            
        }
        ch++;
        byte = byte << 4;
        
        if (*ch) {
            
            if ('0' <= *ch && *ch <= '9') {
                
                byte += *ch - '0';
                
            } else if ('a' <= *ch && *ch <= 'f') {
                
                byte += *ch - 'a' + 10;
                
            }else if('A' <= *ch && *ch <= 'F'){
                
                byte += *ch - 'A' + 10;
                
            }
            ch++;
        }
        [data appendBytes:&byte length:1];
    }
    return data;
}


@end
