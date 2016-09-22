//
//  IAGAesGcm.m
//  Pods
//
//  Created by Enrique de la Torre (dev) on 17/09/2016.
//
//

#import "IAGAesGcm.h"

@implementation IAGAesGcm

#pragma mark - Public class methods

+ (IAGCipheredData *)cipheredDataByAuthenticatedEncryptingPlainData:(NSData *)plainData
                                           withInitializationVector:(NSData *)iv
                                        additionalAuthenticatedData:(NSData *)aad
{
}

+ (NSData *)plainDataByAuthenticatedDecryptingCipheredData:(IAGCipheredData *)cipheredData
                                  withInitializationVector:(NSData *)iv
                               additionalAuthenticatedData:(NSData *)aad
{
}

@end
