#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "IAGAesGcm.h"
#import "IAGCipheredData.h"
#import "IAGError.h"

FOUNDATION_EXPORT double AesGcmVersionNumber;
FOUNDATION_EXPORT const unsigned char AesGcmVersionString[];

