//
//  IAGError.h
//  Pods
//
//  Created by Enrique de la Torre (dev) on 20/09/2016.
//
//

#import <Foundation/Foundation.h>

/** "One and only" list of error codes in this pod */
typedef NS_ENUM(NSInteger, IAGErrorCode) {
    /** @see [IAGErrorFactory errorAESFailed] */
    IAGErrorCodeAESFailed = 0,
};

NS_ASSUME_NONNULL_BEGIN

/** "One and only" error domain in this pod */
extern NSString * const IAGErrorDomain;

/**
 Simple factory to easily build each of the errors generated while ciphering/deciphering data.
 */
@interface IAGErrorFactory : NSObject

/**
 Error returned if something goes wrong while ciphering a block with AES.
 
 @see IAGBlockType
 @see [IAGAesComponents getCipheredBlock:byUsingAESOnBlock:withKey:error:]
 */
+ (NSError *)errorAESFailed;

@end

NS_ASSUME_NONNULL_END
