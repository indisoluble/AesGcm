//
//  IAGCipheredDataTest.m
//  AesGcm_Tests
//
//  Created by Enrique de la Torre (dev) on 21/10/2017.
//  Copyright © 2017 Enrique de la Torre. All rights reserved.
//

#import <AesGcm/AesGcm-umbrella.h>
#import <XCTest/XCTest.h>

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

@end
