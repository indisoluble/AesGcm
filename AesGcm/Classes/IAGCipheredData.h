//
//  IAGCipheredData.h
//  Pods
//
//  Created by Enrique de la Torre (dev) on 17/09/2016.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IAGCipheredData : NSObject

@property (nonatomic, readonly) NSData *data;
@property (nonatomic, readonly) NSData *authenticationTag;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithData:(NSData *)data
           authenticationTag:(NSData *)authenticationTag;

@end

NS_ASSUME_NONNULL_END
