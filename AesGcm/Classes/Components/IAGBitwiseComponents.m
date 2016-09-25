//
//  IAGBitwiseComponents.m
//  Pods
//
//  Created by Enrique de la Torre (dev) on 25/09/2016.
//
//

#import "IAGBitwiseComponents.h"

static const IAGUInt8Type kBitsInUChar = 8;

const IAGUInt8Type IAGMaxBitPositionInABlock = (kBitsInUChar * sizeof(IAGBlockType) - 1);

@implementation IAGBitwiseComponents

+ (void)getXorBlock:(IAGBlockType)buffer
          withBlock:(IAGBlockType)value1
           andBlock:(IAGBlockType)value2
{
    [IAGBitwiseComponents getXorBuffer:buffer
                            withBuffer:value1
                                buffer:value2
                            bufferSize:sizeof(IAGBlockType)];
}

+ (void)getXorBuffer:(IAGUCharType *)buffer
          withBuffer:(IAGUCharType *)value1
              buffer:(IAGUCharType *)value2
          bufferSize:(IAGSizeType)bufferSize
{
    for (IAGSizeType i = 0; i < bufferSize; i++)
    {
        buffer[i] = (value1[i] ^ value2[i]);
    }
}

+ (void)getSingleRightShiftedBlock:(IAGBlockType)shiftedBlock withBlock:(IAGBlockType)block
{
    memset(shiftedBlock, 0x00, sizeof(IAGUCharType));
    memcpy(shiftedBlock + sizeof(IAGUCharType), block, sizeof(IAGBlockType) - sizeof(IAGUCharType));
}

+ (void)getMostSignificantBytes:(IAGUCharType *)msb
                       withSize:(IAGSizeType)msbSyze
                       inBuffer:(IAGUCharType *)buffer
                       withSize:(IAGSizeType)bufferSize
{
    NSParameterAssert(msbSyze <= bufferSize);

    memcpy(msb, buffer, msbSyze);
}

+ (void)getLeastSignificantBytes:(IAGUCharType *)lsb
                        withSize:(IAGSizeType)lsbSyze
                        inBuffer:(IAGUCharType *)buffer
                        withSize:(IAGSizeType)bufferSize
{
    NSParameterAssert(lsbSyze <= bufferSize);

    memcpy(lsb, buffer + (bufferSize - lsbSyze), lsbSyze);
}

+ (BOOL)isMostSignificantBitActivatedAtPosition:(IAGUInt8Type)position
                                        inBlock:(IAGBlockType)block
{
    NSParameterAssert(position <= IAGMaxBitPositionInABlock);

    IAGUCharType mostSignificantByte = block[position / kBitsInUChar];
    IAGUCharType mask = 0x80 >> (position % kBitsInUChar);
    IAGUCharType mostSignificantBit = (mostSignificantByte & mask);

    return (mostSignificantBit != 0);
}

+ (BOOL)isLeastSignificantBitActivatedAtPosition:(IAGUInt8Type)position
                                         inBlock:(IAGBlockType)block
{
    NSParameterAssert(position <= IAGMaxBitPositionInABlock);

    IAGUCharType leastSignificantByte = block[IAGMaxBitPositionInABlock - (position / kBitsInUChar)];
    IAGUCharType mask = 0x01 << (position % kBitsInUChar);
    IAGUCharType leastSignificantBit = (leastSignificantByte & mask);

    return (leastSignificantBit != 0);
}

@end
