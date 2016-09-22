//
//  IAGGcmMathComponents.m
//  Pods
//
//  Created by Enrique de la Torre (dev) on 20/09/2016.
//
//

#import "IAGGcmMathComponents.h"

#import "IAGAesComponents.h"
#import "IAGError.h"

@implementation IAGGcmMathComponents

#pragma mark - Public class methods

+ (void)getGhashBlock:(IAGBlockType)ghashBlock
           withBuffer:(IAGUCharType *)buffer
           bufferSize:(IAGSizeType)bufferSize
           hashSubkey:(IAGBlockType)hashSubkey
{
    NSParameterAssert((bufferSize % sizeof(IAGBlockType)) == 0);

    // Steps:
    // 1. Let X1, X 2, ... , X m-1, X m denote the unique sequence of blocks such that
    //    X = X 1 || X 2 || ... || X m-1 || X m.
    // 2. Let Y0 be the “zero block,” 0128.
    IAGBlockType y;
    memset(y, 0, sizeof(IAGBlockType));

    // 3. For i = 1, ..., m, let Yi = (Yi-1 ⊕ Xi) • H.
    for (IAGSizeType i = 0; i < bufferSize; i += sizeof(IAGBlockType))
    {
        IAGBlockType xor;
        [IAGGcmMathComponents getXorBlock:xor withBlock:y andBlock:(buffer + i)];

        [IAGGcmMathComponents getProductBlock:y byMultiplyingBlock:xor andBlock:hashSubkey];
    }

    // 4. Return Ym.
    memcpy(ghashBlock, y, sizeof(IAGBlockType));
}

+ (BOOL)getGCounterBuffer:(IAGUCharType *)gcounterBuffer
               withBuffer:(IAGUCharType *)buffer
               bufferSize:(IAGSizeType)bufferSize
      initialCounterBlock:(IAGBlockType)icb
                      key:(NSData *)key
                    error:(NSError **)error
{
    //Steps:
    // 1. If X is the empty string, then return the empty string as Y.
    if (bufferSize == 0)
    {
        return YES;
    }

    // 2. Let n = ⎡len(X)/128⎤.
    // 3. Let X1, X2, ... , Xn-1, Xn
    //    denote the unique sequence of bit strings such that
    //    X = X1 || X2 || ... || Xn-1 || Xn;
    //    X1, X2,..., Xn-1 are complete blocks.
    // 4. Let CB1 = ICB.
    // 5. For i = 2 to n, let CBi = inc32(CBi-1).
    // 6. For i = 1 to n - 1, let Yi = Xi ⊕ CIPH(CBi).
    // 7. Let Yn = Xn ⊕ MSB(CIPH(CBn)).
    // 8. Let Y = Y1 || Y2 || ... || Yn.
    // 9. Return Y.

    IAGUCharType y[bufferSize];

    IAGBlockType cb;
    memcpy(cb, icb, sizeof(IAGBlockType));

    IAGSizeType uncompleteBlockSize = (bufferSize % sizeof(IAGBlockType));

    for (IAGSizeType i = 0; i < (bufferSize - uncompleteBlockSize); i += sizeof(IAGBlockType))
    {
        IAGBlockType cipheredBlock;
        BOOL success = [IAGAesComponents getCipheredBlock:cipheredBlock
                                        byUsingAESOnBlock:cb
                                                  withKey:key
                                                    error:error];
        if (!success)
        {
            return NO;
        }
        [IAGGcmMathComponents getXorBlock:(y + i)
                                withBlock:(buffer + i)
                                 andBlock:cipheredBlock];

        IAGBlockType intermediateCb;
        memcpy(intermediateCb, cb, sizeof(IAGBlockType));
        [IAGGcmMathComponents get32BitIncrementedBuffer:cb
                                             withBuffer:intermediateCb
                                                   size:sizeof(IAGBlockType)];
    }

    if (uncompleteBlockSize > 0)
    {
        IAGBlockType cipheredBlock;
        BOOL success = [IAGAesComponents getCipheredBlock:cipheredBlock
                                        byUsingAESOnBlock:cb
                                                  withKey:key
                                                    error:error];
        if (!success)
        {
            return NO;
        }

        IAGUCharType msb[uncompleteBlockSize];
        [IAGGcmMathComponents getMostSignificantBytes:msb
                                             withSize:uncompleteBlockSize
                                             inBuffer:cipheredBlock
                                             withSize:sizeof(IAGBlockType)];

        [IAGGcmMathComponents getXorBuffer:(y + bufferSize - uncompleteBlockSize)
                                withBuffer:(buffer + bufferSize - uncompleteBlockSize)
                                    buffer:msb
                                bufferSize:uncompleteBlockSize];
    }

    memcpy(gcounterBuffer, y, bufferSize);

    return YES;
}

#pragma mark - Private class methods

+ (void)getProductBlock:(IAGBlockType)product
     byMultiplyingBlock:(IAGBlockType)x
               andBlock:(IAGBlockType)y
{
    // Let R be the bit string 11100001 || 0^120
    IAGBlockType r;
    memset(r, 0, sizeof(IAGBlockType));
    r[0] = 0xE1;

    // Steps:
    // 1. Let x0 x1 ... x127 denote the sequence of bits in X
    // 2. Let Z0 = 0^128 and V0 = Y.
    IAGBlockType z;
    memset(z, 0, sizeof(IAGBlockType));

    IAGBlockType v;
    memcpy(v, y, sizeof(IAGBlockType));

    // 3. For i = 0 to 127, calculate blocks Zi+1 and Vi+1 as follows:
    for (IAGUInt8Type i = 0; i <= IAGMaxBitPositionInABlock; i++)
    {
        // Zi+1 = Zi if xi = 0; Zi ⊕ Vi if xi = 1.
        if ([IAGGcmMathComponents isMostSignificantBitActivatedAtPosition:i inBlock:x])
        {
            IAGBlockType zi;
            memcpy(zi, z, sizeof(IAGBlockType));

            [IAGGcmMathComponents getXorBlock:z withBlock:zi andBlock:v];
        }

        // Vi+1 = Vi >> 1 if LSB1(Vi) = 0; (Vi >> 1) ⊕ R if LSB1(Vi) = 1.
        IAGBlockType vi;
        memcpy(vi, v, sizeof(IAGBlockType));

        [IAGGcmMathComponents getSingleRightShiftedBlock:v withBlock:vi];

        if ([IAGGcmMathComponents isLeastSignificantBitActivatedAtPosition:i inBlock:vi])
        {
            memcpy(vi, v, sizeof(IAGBlockType));

            [IAGGcmMathComponents getXorBlock:v withBlock:vi andBlock:r];
        }
    }

    // 4. Return Z128.
    memcpy(product, z, sizeof(IAGBlockType));
}

+ (void)get32BitIncrementedBuffer:(IAGUCharType *)incBuffer
                       withBuffer:(IAGUCharType *)buffer
                             size:(IAGSizeType)size
{
    NSParameterAssert(size >= sizeof(IAGUInt32Type));

    // From http://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf:
    // ... the function increments the right-most s bits of the string, regarded as the binary
    // representation of an integer, modulo 2^s; the remaining, left-most len(X)-s bits
    // remain unchanged.

    IAGUInt32Type lsb;
    [IAGGcmMathComponents getLeastSignificantBytes:&lsb
                                          withSize:sizeof(IAGUInt32Type)
                                          inBuffer:buffer
                                          withSize:size];

    // Notice that the increment is modulo 2^32, therefore even if it overflows, the result is
    // still correct
    lsb = CFSwapInt32HostToBig(CFSwapInt32BigToHost(lsb) + 1);

    if (size != sizeof(IAGUInt32Type))
    {
        [IAGGcmMathComponents getMostSignificantBytes:incBuffer
                                             withSize:(size - sizeof(IAGUInt32Type))
                                             inBuffer:buffer
                                             withSize:size];
    }
    memcpy(incBuffer + (size - sizeof(IAGUInt32Type)), &lsb, sizeof(IAGUInt32Type));
}

+ (void)getXorBlock:(IAGBlockType)buffer
          withBlock:(IAGBlockType)value1
           andBlock:(IAGBlockType)value2
{
    [IAGGcmMathComponents getXorBuffer:buffer
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
    memset(shiftedBlock, 0, sizeof(IAGUCharType));
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

    IAGUCharType mostSignificantByte = block[position / IAGBitsInUChar];
    IAGUCharType mask = 0x80 >> (position % IAGBitsInUChar);
    IAGUCharType mostSignificantBit = (mostSignificantByte & mask);

    return (mostSignificantBit != 0);
}

 + (BOOL)isLeastSignificantBitActivatedAtPosition:(IAGUInt8Type)position
                                          inBlock:(IAGBlockType)block
{
    NSParameterAssert(position <= IAGMaxBitPositionInABlock);

    IAGUCharType leastSignificantByte = block[IAGMaxBitPositionInABlock - (position / IAGBitsInUChar)];
    IAGUCharType mask = 0x01 << (position % IAGBitsInUChar);
    IAGUCharType leastSignificantBit = (leastSignificantByte & mask);

    return (leastSignificantBit != 0);
}

@end
