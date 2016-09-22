//
//  IAGCipheredData.m
//  Pods
//
//  Created by Enrique de la Torre (dev) on 17/09/2016.
//
//

#import "IAGCipheredData.h"

@implementation IAGCipheredData

#pragma mark - Init object

- (instancetype)initWithData:(NSData *)data
           authenticationTag:(NSData *)authenticationTag
{
    self = [super init];

    if (self)
    {
        _data = data;
        _authenticationTag = authenticationTag;
    }

    return self;
}

@end
