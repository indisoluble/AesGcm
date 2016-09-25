//
//  IAGGcmMathComponentsTest.m
//  AesGcm
//
//  Created by Enrique de la Torre (dev) on 25/09/2016.
//  Copyright © 2016 Enrique de la Torre. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "IAGGcmMathComponents.h"

#import "NSData+IAGHexString.h"

@interface IAGGcmMathComponentsTest : XCTestCase

@end

@implementation IAGGcmMathComponentsTest

- (void)testBufferAndHashSubkey_getGhashBlock_returnsExpectedBlock
{
    // given
    NSData *buffer = [NSData iag_dataWithHexString:(@"9313225df88406e555909c5aff5269aa" \
                                                    "6a7a9538534f7da1e4c303d2a318a728" \
                                                    "c3c0c95156809539fcf0e2429a6b5254" \
                                                    "16aedbf5a0de6a57a637b39b00000000" \
                                                    "000000000000000000000000000001e0")];
    NSData *hashSubkey = [NSData iag_dataWithHexString:@"b83b533708bf535d0aa6e52980d53b78"];

    // when
    IAGBlockType ghashBlock;
    [IAGGcmMathComponents getGhashBlock:ghashBlock
                             withBuffer:(IAGUCharType *)buffer.bytes
                             bufferSize:buffer.length
                             hashSubkey:(IAGUCharType *)hashSubkey.bytes];

    // then
    NSData *ghashBlockData = [NSData dataWithBytes:ghashBlock length:sizeof(IAGBlockType)];
    NSData *expectedGhashBlock = [NSData iag_dataWithHexString:@"3bab75780a31c059f83d2a44752f9864"];
    XCTAssertEqualObjects(ghashBlockData, expectedGhashBlock);
}

@end
