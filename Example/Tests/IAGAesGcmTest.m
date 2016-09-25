//
//  IAGAesGcmTest.m
//  AesGcm
//
//  Created by Enrique de la Torre (dev) on 25/09/2016.
//  Copyright © 2016 Enrique de la Torre. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "IAGAesGcm.h"

#import "NSData+IAGHexString.h"

@interface IAGAesGcmTest : XCTestCase

@end

@implementation IAGAesGcmTest

- (void)test128BitZeroKeyEmptyPlaintextEmptyAad96BitZeroIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:@"00000000000000000000000000000000"];
    NSData *plainData = [NSData data];
    NSData *aad = [NSData data];
    NSData *iv = [NSData iag_dataWithHexString:@"000000000000000000000000"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];

    // then
    NSData *expectedCiphertext = [NSData data];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"58e2fccefa7e3061367f1d57a4e7455a"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test128BitZeroKeyNonEmptyPlaintextEmptyAad96BitZeroIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:@"00000000000000000000000000000000"];
    NSData *plainData = [NSData iag_dataWithHexString:@"00000000000000000000000000000000"];
    NSData *aad = [NSData data];
    NSData *iv = [NSData iag_dataWithHexString:@"000000000000000000000000"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];

    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:@"0388dace60b6a392f328c2b971b2fe78"];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"ab6e47d42cec13bdf53a67b21257bddf"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test128BitKeyAlignedPlaintextEmptyAad96BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:@"feffe9928665731c6d6a8f9467308308"];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b391aafd255")];
    NSData *aad = [NSData data];
    NSData *iv = [NSData iag_dataWithHexString:@"cafebabefacedbaddecaf888"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];

    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"42831ec2217774244b7221b784d0d49c" \
                                                                "e3aa212f2c02a4e035c17e2329aca12e" \
                                                                "21d514b25466931c7d8f6a5aac84aa05" \
                                                                "1ba30b396a0aac973d58e091473f5985")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"4d5c2af327cd64a62cf35abd2ba6fab4"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test128BitKeyNonEmptyPlaintextNonEmptyAad96BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:@"feffe9928665731c6d6a8f9467308308"];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b39")];
    NSData *aad = [NSData iag_dataWithHexString:(@"feedfacedeadbeeffeedfacedeadbeef" \
                                                 "abaddad2")];
    NSData *iv = [NSData iag_dataWithHexString:@"cafebabefacedbaddecaf888"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];
    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"42831ec2217774244b7221b784d0d49c" \
                                                                "e3aa212f2c02a4e035c17e2329aca12e" \
                                                                "21d514b25466931c7d8f6a5aac84aa05" \
                                                                "1ba30b396a0aac973d58e091")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"5bc94fbc3221a5db94fae95ae7121a47"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test128BitKeyNonEmptyPlaintextNonEmptyAad64BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:@"feffe9928665731c6d6a8f9467308308"];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b39")];
    NSData *aad = [NSData iag_dataWithHexString:(@"feedfacedeadbeeffeedfacedeadbeef" \
                                                 "abaddad2")];
    NSData *iv = [NSData iag_dataWithHexString:@"cafebabefacedbad"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];
    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"61353b4c2806934a777ff51fa22a4755" \
                                                                "699b2a714fcdc6f83766e5f97b6c7423" \
                                                                "73806900e49f24b22b097544d4896b42" \
                                                                "4989b5e1ebac0f07c23f4598")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"3612d2e79e3b0785561be14aaca2fccb"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test128BitKeyNonEmptyPlaintextNonEmptyAad480BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:@"feffe9928665731c6d6a8f9467308308"];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b39")];
    NSData *aad = [NSData iag_dataWithHexString:(@"feedfacedeadbeeffeedfacedeadbeef" \
                                                 "abaddad2")];
    NSData *iv = [NSData iag_dataWithHexString:(@"9313225df88406e555909c5aff5269aa" \
                                                "6a7a9538534f7da1e4c303d2a318a728" \
                                                "c3c0c95156809539fcf0e2429a6b5254" \
                                                "16aedbf5a0de6a57a637b39b")];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];
    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"8ce24998625615b603a033aca13fb894" \
                                                                "be9112a5c3a211a8ba262a3cca7e2ca7" \
                                                                "01e4a9a4fba43c90ccdcb281d48c7c6f" \
                                                                "d62875d2aca417034c34aee5")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"619cc5aefffe0bfa462af43c1699d050"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test192BitZeroKeyEmptyPlaintextEmptyAad96BitZeroIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"00000000000000000000000000000000" \
                                                 "0000000000000000")];
    NSData *plainData = [NSData data];
    NSData *aad = [NSData data];
    NSData *iv = [NSData iag_dataWithHexString:@"000000000000000000000000"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];

    // then
    NSData *expectedCiphertext = [NSData data];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"cd33b28ac773f74ba00ed1f312572435"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test192BitZeroKeyNonEmptyPlaintextEmptyAad96BitZeroIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"00000000000000000000000000000000" \
                                                 "0000000000000000")];
    NSData *plainData = [NSData iag_dataWithHexString:@"00000000000000000000000000000000"];
    NSData *aad = [NSData data];
    NSData *iv = [NSData iag_dataWithHexString:@"000000000000000000000000"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];

    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:@"98e7247c07f0fe411c267e4384b0f600"];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"2ff58d80033927ab8ef4d4587514f0fb"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test192BitKeyAlignedPlaintextEmptyAad96BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"feffe9928665731c6d6a8f9467308308" \
                                                 "feffe9928665731c")];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b391aafd255")];
    NSData *aad = [NSData data];
    NSData *iv = [NSData iag_dataWithHexString:@"cafebabefacedbaddecaf888"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];

    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"3980ca0b3c00e841eb06fac4872a2757" \
                                                                "859e1ceaa6efd984628593b40ca1e19c" \
                                                                "7d773d00c144c525ac619d18c84a3f47" \
                                                                "18e2448b2fe324d9ccda2710acade256")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"9924a7c8587336bfb118024db8674a14"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test192BitKeyNonEmptyPlaintextNonEmptyAad96BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"feffe9928665731c6d6a8f9467308308" \
                                                 "feffe9928665731c")];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b39")];
    NSData *aad = [NSData iag_dataWithHexString:(@"feedfacedeadbeeffeedfacedeadbeef" \
                                                 "abaddad2")];
    NSData *iv = [NSData iag_dataWithHexString:@"cafebabefacedbaddecaf888"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];
    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"3980ca0b3c00e841eb06fac4872a2757" \
                                                                "859e1ceaa6efd984628593b40ca1e19c" \
                                                                "7d773d00c144c525ac619d18c84a3f47" \
                                                                "18e2448b2fe324d9ccda2710")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"2519498e80f1478f37ba55bd6d27618c"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test192BitKeyNonEmptyPlaintextNonEmptyAad64BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"feffe9928665731c6d6a8f9467308308" \
                                                 "feffe9928665731c")];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b39")];
    NSData *aad = [NSData iag_dataWithHexString:(@"feedfacedeadbeeffeedfacedeadbeef" \
                                                 "abaddad2")];
    NSData *iv = [NSData iag_dataWithHexString:@"cafebabefacedbad"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];
    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"0f10f599ae14a154ed24b36e25324db8" \
                                                                "c566632ef2bbb34f8347280fc4507057" \
                                                                "fddc29df9a471f75c66541d4d4dad1c9" \
                                                                "e93a19a58e8b473fa0f062f7")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"65dcc57fcf623a24094fcca40d3533f8"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test192BitKeyNonEmptyPlaintextNonEmptyAad480BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"feffe9928665731c6d6a8f9467308308" \
                                                 "feffe9928665731c")];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b39")];
    NSData *aad = [NSData iag_dataWithHexString:(@"feedfacedeadbeeffeedfacedeadbeef" \
                                                 "abaddad2")];
    NSData *iv = [NSData iag_dataWithHexString:(@"9313225df88406e555909c5aff5269aa" \
                                                "6a7a9538534f7da1e4c303d2a318a728" \
                                                "c3c0c95156809539fcf0e2429a6b5254" \
                                                "16aedbf5a0de6a57a637b39b")];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];
    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"d27e88681ce3243c4830165a8fdcf9ff" \
                                                                "1de9a1d8e6b447ef6ef7b79828666e45" \
                                                                "81e79012af34ddd9e2f037589b292db3" \
                                                                "e67c036745fa22e7e9b7373b")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"dcf566ff291c25bbb8568fc3d376a6d9"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test256BitZeroKeyEmptyPlaintextEmptyAad96BitZeroIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"00000000000000000000000000000000" \
                                                 "00000000000000000000000000000000")];
    NSData *plainData = [NSData data];
    NSData *aad = [NSData data];
    NSData *iv = [NSData iag_dataWithHexString:@"000000000000000000000000"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];

    // then
    NSData *expectedCiphertext = [NSData data];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"530f8afbc74536b9a963b4f1c4cb738b"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test256BitZeroKeyNonEmptyPlaintextEmptyAad96BitZeroIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"00000000000000000000000000000000" \
                                                 "00000000000000000000000000000000")];
    NSData *plainData = [NSData iag_dataWithHexString:@"00000000000000000000000000000000"];
    NSData *aad = [NSData data];
    NSData *iv = [NSData iag_dataWithHexString:@"000000000000000000000000"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];

    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:@"cea7403d4d606b6e074ec5d3baf39d18"];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"d0d1c8a799996bf0265b98b5d48ab919"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test256BitKeyAlignedPlaintextEmptyAad96BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"feffe9928665731c6d6a8f9467308308" \
                                                 "feffe9928665731c6d6a8f9467308308")];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b391aafd255")];
    NSData *aad = [NSData data];
    NSData *iv = [NSData iag_dataWithHexString:@"cafebabefacedbaddecaf888"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];

    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"522dc1f099567d07f47f37a32a84427d" \
                                                                "643a8cdcbfe5c0c97598a2bd2555d1aa" \
                                                                "8cb08e48590dbb3da7b08b1056828838" \
                                                                "c5f61e6393ba7a0abcc9f662898015ad")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"b094dac5d93471bdec1a502270e3cc6c"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test256BitKeyNonEmptyPlaintextNonEmptyAad96BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"feffe9928665731c6d6a8f9467308308" \
                                                 "feffe9928665731c6d6a8f9467308308")];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b39")];
    NSData *aad = [NSData iag_dataWithHexString:(@"feedfacedeadbeeffeedfacedeadbeef" \
                                                 "abaddad2")];
    NSData *iv = [NSData iag_dataWithHexString:@"cafebabefacedbaddecaf888"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];
    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"522dc1f099567d07f47f37a32a84427d" \
                                                                "643a8cdcbfe5c0c97598a2bd2555d1aa" \
                                                                "8cb08e48590dbb3da7b08b1056828838" \
                                                                "c5f61e6393ba7a0abcc9f662")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"76fc6ece0f4e1768cddf8853bb2d551b"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test256BitKeyNonEmptyPlaintextNonEmptyAad64BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"feffe9928665731c6d6a8f9467308308" \
                                                 "feffe9928665731c6d6a8f9467308308")];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b39")];
    NSData *aad = [NSData iag_dataWithHexString:(@"feedfacedeadbeeffeedfacedeadbeef" \
                                                 "abaddad2")];
    NSData *iv = [NSData iag_dataWithHexString:@"cafebabefacedbad"];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];
    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"c3762df1ca787d32ae47c13bf19844cb" \
                                                                "af1ae14d0b976afac52ff7d79bba9de0" \
                                                                "feb582d33934a4f0954cc2363bc73f78" \
                                                                "62ac430e64abe499f47c9b1f")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"3a337dbf46a792c45e454913fe2ea8f2"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];

    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

- (void)test256BitKeyNonEmptyPlaintextNonEmptyAad480BitIvAnd128BitAuthTagLength_authenticatedEncryptingPlainData_returnsExpectedCipherData
{
    // given
    NSData *key = [NSData iag_dataWithHexString:(@"feffe9928665731c6d6a8f9467308308" \
                                                 "feffe9928665731c6d6a8f9467308308")];
    NSData *plainData = [NSData iag_dataWithHexString:(@"d9313225f88406e5a55909c5aff5269a" \
                                                       "86a7a9531534f7da2e4c303d8a318a72" \
                                                       "1c3c0c95956809532fcf0e2449a6b525" \
                                                       "b16aedf5aa0de657ba637b39")];
    NSData *aad = [NSData iag_dataWithHexString:(@"feedfacedeadbeeffeedfacedeadbeef" \
                                                 "abaddad2")];
    NSData *iv = [NSData iag_dataWithHexString:(@"9313225df88406e555909c5aff5269aa" \
                                                "6a7a9538534f7da1e4c303d2a318a728" \
                                                "c3c0c95156809539fcf0e2429a6b5254" \
                                                "16aedbf5a0de6a57a637b39b")];

    // when
    IAGCipheredData *cipheredData = [IAGAesGcm cipheredDataByAuthenticatedEncryptingPlainData:plainData
                                                              withAdditionalAuthenticatedData:aad
                                                                      authenticationTagLength:IAGAuthenticationTagLength128
                                                                         initializationVector:iv
                                                                                          key:key
                                                                                        error:nil];
    // then
    NSData *expectedCiphertext = [NSData iag_dataWithHexString:(@"5a8def2f0c9e53f1f75d7853659e2a20" \
                                                                "eeb2b22aafde6419a058ab4f6f746bf4" \
                                                                "0fc0c3b780f244452da3ebf1c5d82cde" \
                                                                "a2418997200ef82e44ae7e3f")];
    NSData *expectedAuthTag = [NSData iag_dataWithHexString:@"a44a8266ee1c8eb0c8b5d4cf5ae9f19a"];

    IAGCipheredData *expectedCipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:expectedCiphertext.bytes
                                                                       cipheredBufferLength:expectedCiphertext.length
                                                                          authenticationTag:expectedAuthTag.bytes
                                                                    authenticationTagLength:expectedAuthTag.length];
    
    XCTAssertEqualObjects(cipheredData, expectedCipheredData);
}

@end
