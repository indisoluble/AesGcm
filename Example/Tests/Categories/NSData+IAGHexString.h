//
//  NSData+IAGHexString.h
//  AesGcm
//
//  Created by Enrique de la Torre (dev) on 25/09/2016.
//  Copyright © 2016 Enrique de la Torre. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (IAGHexString)

+ (NSData *)iag_dataWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
