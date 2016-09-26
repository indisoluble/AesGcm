# AesGcm

[![CI Status](http://img.shields.io/travis/indisoluble/AesGcm.svg?style=flat)](https://travis-ci.org/indisoluble/AesGcm)
[![codecov.io](https://codecov.io/github/indisoluble/AesGcm/coverage.svg?branch=master)](https://codecov.io/github/indisoluble/AesGcm?branch=master)
[![Version](https://img.shields.io/cocoapods/v/AesGcm.svg?style=flat)](http://cocoapods.org/pods/AesGcm)
[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/AesGcm.svg)](http://cocoadocs.org/docsets/AesGcm)
[![License](https://img.shields.io/cocoapods/l/AesGcm.svg?style=flat)](http://cocoapods.org/pods/AesGcm)

ObjC implementation of
[Galois/Counter Mode (GCM)](http://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf)
with Advanced Encryption System (AES).

## Notice

As pointed out in [this comment in StackOverflow](http://stackoverflow.com/a/36634956), iOS already
has some GCM crypt functions, however they are not public. In the mean time, you can use the
methods in this repo.

The documents used as guide to code this algorithm were:
* [Recommendation for Block Cipher Modes of Operation: Galois/Counter Mode (GCM) and GMAC](http://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf)
* [The Galois/Counter Mode of Operation (GCM)](http://csrc.nist.gov/groups/ST/toolkit/BCM/documents/proposedmodes/gcm/gcm-spec.pdf)

## Installation

AesGcm is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AesGcm"
```

## Usage

```objc
#import "IAGAesGcm.h"

u_char keyBytes[16] = {...};
NSData *key = [NSData dataWithBytes:keyBytes length:sizeof(keyBytes)];

u_char ivBytes[12] = {...};
NSData *iv = [NSData dataWithBytes:ivBytes length:sizeof(ivBytes)];

NSData *aad = [@"AdditionalAuthenticatedData" dataUsingEncoding:NSUTF8StringEncoding];

// Authenticated Encryption Function
NSData *expectedPlainData = [@"PlainData" dataUsingEncoding:NSUTF8StringEncoding];

IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:expectedPlainData
                                                          withAdditionalAuthenticatedData:aad
                                                                  authenticationTagLength:IAGAuthenticationTagLength128
                                                                     initializationVector:iv
                                                                                      key:key
                                                                                    error:nil];

// Authenticated Decryption Function
NSData *plainData = [IAGAesGcm plainDataByAuthenticatedDecryptingCipheredData:cipheredData
                                              withAdditionalAuthenticatedData:aad
                                                         initializationVector:iv
                                                                          key:key
                                                                        error:nil];

XCTAssertEqualObjects(expectedPlainData, plainData);
```

## License

AesGcm is available under the MIT license. See the LICENSE file for more info.
