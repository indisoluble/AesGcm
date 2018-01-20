//
//  IAGCipheredData.h
//  Pods
//
//  Created by Enrique de la Torre (dev) on 17/09/2016.
//
//

#import <Foundation/Foundation.h>

/** List of valid authentication tag lengths */
typedef NS_ENUM(NSUInteger, IAGAuthenticationTagLength) {
    /** 128 bits (16 bytes) */
    IAGAuthenticationTagLength128 = 16,
    /** 120 bits (15 bytes) */
    IAGAuthenticationTagLength120 = 15,
    /** 112 bits (14 bytes) */
    IAGAuthenticationTagLength112 = 14,
    /** 104 bits (13 bytes) */
    IAGAuthenticationTagLength104 = 13,
    /** 96 bits (12 bytes) */
    IAGAuthenticationTagLength96 = 12
};

/**
 Data type of the ciphered data generated/consumed by the methods in this pod.
 
 @see IAGAesGcm
 */

NS_ASSUME_NONNULL_BEGIN

@interface IAGCipheredData : NSObject <NSSecureCoding>

/** Ciphered data generated after encrypting some plain data. */
@property (nonatomic, readonly) const void *cipheredBuffer NS_RETURNS_INNER_POINTER;

/** Length of the ciphered buffer */
@property (nonatomic, readonly) NSUInteger cipheredBufferLength;

/**
 Authentication Tag generated after encrypting some plain data.
 
 @see [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:withAdditionalAuthenticatedData:authenticationTagLength:initializationVector:key:error:]
 */
@property (nonatomic, readonly) const void *authenticationTag NS_RETURNS_INNER_POINTER;

/**
 Length of the authentication tag, also passed by parameter before encrypting the plain data.
 
 @see [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:withAdditionalAuthenticatedData:authenticationTagLength:initializationVector:key:error:]
 */
@property (nonatomic, readonly) IAGAuthenticationTagLength authenticationTagLength;

/** Unavailable. Use designated initializer */
- (instancetype)init NS_UNAVAILABLE;

/**
 Convenience initializer

 @param cipheredData Buffer with the ciphered data
 @param authenticationTag Buffer with the autentication tag generated when the data was ciphered. Its size has to be one of the values specified in IAGAuthenticationTagLength

 @return An instance of this class or nil if the size of authenticationTag is not of IAGAuthenticationTagLength

 @see IAGAuthenticationTagLength
 @see [IAGAesGcm plainDataByAuthenticatedDecryptingCipheredData:withAdditionalAuthenticatedData:initializationVector:key:error:]
 */
- (nullable instancetype)initWithCipheredData:(NSData *)cipheredData
                            authenticationTag:(NSData *)authenticationTag;

/** Designated initializer */
- (instancetype)initWithCipheredBuffer:(const void *)cipheredBuffer
                  cipheredBufferLength:(NSUInteger)cipheredBufferLength
                     authenticationTag:(const void *)authenticationTag
               authenticationTagLength:(IAGAuthenticationTagLength)authenticationTagLength NS_DESIGNATED_INITIALIZER;

/** Class-specific equality method */
- (BOOL)isEqualToCipheredData:(IAGCipheredData *)object;

@end

NS_ASSUME_NONNULL_END
