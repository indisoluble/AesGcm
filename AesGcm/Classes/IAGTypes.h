//
//  IAGTypes.h
//  Pods
//
//  Created by Enrique de la Torre (dev) on 20/09/2016.
//
//

#ifndef IAGTypes_h
#define IAGTypes_h

typedef size_t IAGSizeType;
typedef u_char IAGUCharType;
typedef u_int8_t IAGUInt8Type;
typedef u_int32_t IAGUInt32Type;

typedef IAGUCharType IAGBlockType[16];

static const IAGUInt8Type IAGBitsInUChar = 8;
static const IAGUInt8Type IAGMaxBitPositionInABlock = (IAGBitsInUChar * sizeof(IAGBlockType) - 1);

#endif /* IAGTypes_h */
