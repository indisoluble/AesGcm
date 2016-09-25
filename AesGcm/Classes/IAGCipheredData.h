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
    IAGAuthenticationTagLength128 = 16,
    IAGAuthenticationTagLength120 = 15,
    IAGAuthenticationTagLength112 = 14,
    IAGAuthenticationTagLength104 = 13,
    IAGAuthenticationTagLength96 = 12
};

/**
 Data type of the ciphered data generated/consumed by the methods in this pod.
 
 @see IAGAesGcm
 */

NS_ASSUME_NONNULL_BEGIN

@interface IAGCipheredData : NSObject

@property (nonatomic, readonly) const void *cipheredBuffer NS_RETURNS_INNER_POINTER;
@property (nonatomic, readonly) NSUInteger cipheredBufferLength;

@property (nonatomic, readonly) const void *authenticationTag NS_RETURNS_INNER_POINTER;
@property (nonatomic, readonly) IAGAuthenticationTagLength authenticationTagLength;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCipheredBuffer:(const void *)cipheredBuffer
                  cipheredBufferLength:(NSUInteger)cipheredBufferLength
                     authenticationTag:(const void *)authenticationTag
               authenticationTagLength:(IAGAuthenticationTagLength)authenticationTagLength;

- (BOOL)isEqualToCipheredData:(IAGCipheredData *)object;

@end

NS_ASSUME_NONNULL_END
