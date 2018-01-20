//
//  IAGCipheredDataTest.m
//  AesGcm_Tests
//
//  Created by Enrique de la Torre (dev) on 21/10/2017.
//  Copyright © 2017 Enrique de la Torre. All rights reserved.
//

#import <AesGcm/AesGcm-umbrella.h>
#import <XCTest/XCTest.h>

#import "NSData+IAGHexString.h"

@interface IAGCipheredDataTest : XCTestCase

@end

@implementation IAGCipheredDataTest

- (void)testAuthenticationTagSmallerThanTheSmallestAcceptableSize_initWithCipheredData_returnNil
{
    // given
    NSData *cipheredData = [NSData data];

    u_char authenticationTagBuffer[IAGAuthenticationTagLength96 - 1];
    NSData *authenticationTag = [NSData dataWithBytes:authenticationTagBuffer
                                               length:sizeof(authenticationTagBuffer)];

    // when
    IAGCipheredData *result = [[IAGCipheredData alloc] initWithCipheredData:cipheredData
                                                          authenticationTag:authenticationTag];
    
    // then
    XCTAssertNil(result);
}

- (void)testAuthenticationTagBiggerThanTheBiggestAcceptableSize_initWithCipheredData_returnNil
{
    // given
    NSData *cipheredData = [NSData data];

    u_char authenticationTagBuffer[IAGAuthenticationTagLength128 + 1];
    NSData *authenticationTag = [NSData dataWithBytes:authenticationTagBuffer
                                               length:sizeof(authenticationTagBuffer)];

    // when
    IAGCipheredData *result = [[IAGCipheredData alloc] initWithCipheredData:cipheredData
                                                          authenticationTag:authenticationTag];

    // then
    XCTAssertNil(result);
}

- (void)testAutheticatioTagWithTheSmallestAcceptableSize_initWithCipheredData_doesNotReturNil
{
    // given
    NSData *cipheredData = [NSData data];

    u_char authenticationTagBuffer[IAGAuthenticationTagLength96];
    NSData *authenticationTag = [NSData dataWithBytes:authenticationTagBuffer
                                               length:sizeof(authenticationTagBuffer)];

    // when
    IAGCipheredData *result = [[IAGCipheredData alloc] initWithCipheredData:cipheredData
                                                          authenticationTag:authenticationTag];

    // then
    XCTAssertNotNil(result);
}

- (void)testAutheticatioTagWithTheBiggestAcceptableSize_initWithCipheredData_doesNotReturNil
{
    // given
    NSData *cipheredData = [NSData data];

    u_char authenticationTagBuffer[IAGAuthenticationTagLength128];
    NSData *authenticationTag = [NSData dataWithBytes:authenticationTagBuffer
                                               length:sizeof(authenticationTagBuffer)];

    // when
    IAGCipheredData *result = [[IAGCipheredData alloc] initWithCipheredData:cipheredData
                                                          authenticationTag:authenticationTag];

    // then
    XCTAssertNotNil(result);
}

- (void)testAnyArchivedCipheredData_unarchived_isEqualToOriginalCipheredData {
    // given
    NSData *ciphertext = [NSData iag_dataWithHexString:@"0388dace60b6a392f328c2b971b2fe78"];
    NSData *authTag = [NSData iag_dataWithHexString:@"ab6e47d42cec13bdf53a67b21257bddf"];
    IAGCipheredData *cipheredData = [[IAGCipheredData alloc] initWithCipheredBuffer:ciphertext.bytes
                                                               cipheredBufferLength:ciphertext.length
                                                                  authenticationTag:authTag.bytes
                                                            authenticationTagLength:authTag.length];

    NSData *archivedCipheredData = [NSKeyedArchiver archivedDataWithRootObject:cipheredData];

    // when
    IAGCipheredData *unarchivedCipheredData = [NSKeyedUnarchiver unarchiveObjectWithData:archivedCipheredData];

    // then
    XCTAssertEqualObjects(cipheredData, unarchivedCipheredData);
}

@end
