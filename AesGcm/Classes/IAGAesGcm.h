//
//  IAGAesGcm.h
//  Pods
//
//  Created by Enrique de la Torre (dev) on 17/09/2016.
//
//

#import <Foundation/Foundation.h>

@class IAGCipheredData;

NS_ASSUME_NONNULL_BEGIN

@interface IAGAesGcm : NSObject

+ (IAGCipheredData *)cipheredDataByAuthenticatedEncryptingPlainData:(NSData *)plainData
                                           withInitializationVector:(NSData *)iv
                                        additionalAuthenticatedData:(NSData *)aad;
+ (NSData *)plainDataByAuthenticatedDecryptingCipheredData:(IAGCipheredData *)cipheredData
                                  withInitializationVector:(NSData *)iv
                               additionalAuthenticatedData:(NSData *)aad;

@end

NS_ASSUME_NONNULL_END
