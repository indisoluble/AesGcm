# AesGcm

[![CI Status](https://travis-ci.org/indisoluble/AesGcm.svg)](https://travis-ci.org/indisoluble/AesGcm)
[![codecov.io](https://codecov.io/github/indisoluble/AesGcm/coverage.svg)](https://codecov.io/github/indisoluble/AesGcm)
[![Version](https://img.shields.io/cocoapods/v/AesGcm.svg?style=flat)](http://cocoapods.org/pods/AesGcm)

ObjC implementation of [Galois/Counter Mode (GCM)](http://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf) with Advanced Encryption System (AES).

## Installation

AesGcm is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "AesGcm"
```

## Usage

```objc
#import <AesGcm/IAGAesGcm.h>
#import <CommonCrypto/CommonCrypto.h>

// Define an Encryption Key
u_char keyBytes[kCCKeySizeAES128] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F, 0x10};
NSData *key = [NSData dataWithBytes:keyBytes length:sizeof(keyBytes)];

// Define an Initialization Vector
// GCM recommends a IV size of 96 bits (12 bytes), but you are free to use other sizes
u_char ivBytes[12] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C};
NSData *iv = [NSData dataWithBytes:ivBytes length:sizeof(ivBytes)];

// Define an Additional Authenticated Data
NSData *aad = [@"AdditionalAuthenticatedData" dataUsingEncoding:NSUTF8StringEncoding];

// Now, we are ready to encrypt some plain data
NSData *expectedPlainData = [@"PlainData" dataUsingEncoding:NSUTF8StringEncoding];

// The returned ciphered data is a simple class with 2 properties: the actual encrypted data and the authentication tag.
// The authentication tag can have multiple sizes and it is up to you to set one, in this case the size is 128 bits
// (16 bytes)
IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:expectedPlainData
                                                          withAdditionalAuthenticatedData:aad
                                                                  authenticationTagLength:IAGAuthenticationTagLength128
                                                                     initializationVector:iv
                                                                                      key:key
                                                                                    error:nil];

// And now, de-cypher the encrypted data to see if the returned plain data is as expected
NSData *plainData = [IAGAesGcm plainDataByAuthenticatedDecryptingCipheredData:cipheredData
                                              withAdditionalAuthenticatedData:aad
                                                         initializationVector:iv
                                                                          key:key
                                                                        error:nil];

XCTAssertEqualObjects(expectedPlainData, plainData);
```

## Acknowledgements

This implementation is based on the following documents:
* [Recommendation for Block Cipher Modes of Operation: Galois/Counter Mode (GCM) and GMAC](http://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf)
* [The Galois/Counter Mode of Operation (GCM)](http://csrc.nist.gov/groups/ST/toolkit/BCM/documents/proposedmodes/gcm/gcm-spec.pdf)

## License

AesGcm is available under the MIT license. See the LICENSE file for more info.
