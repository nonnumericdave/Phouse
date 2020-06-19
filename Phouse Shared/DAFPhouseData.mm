//
//  DAFPhouseData.mm
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#include "DAFPhouseData.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFPhouseData
{
	DAFPhouseVector m_phouseAccelerationVector;
}

@dynamic description;
@synthesize acceleration = m_phouseAccelerationVector;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (nonnull NSString*)description
{
	return [NSString stringWithFormat:@"acceleration = { .x = %+04.3f, .y = %+04.3f, .z = %+04.3f }", m_phouseAccelerationVector.x, m_phouseAccelerationVector.y, m_phouseAccelerationVector.z];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ (nullable NSArray<NSString*>*)observableKeyPaths
{
	return @[@"acceleration"];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)setData:(nullable NSData*)pData
{
	if ( [pData length] != 3 * sizeof(double) )
		return;

	[self willChangeValueForKey:@"acceleration"];
	
	const uint8_t* puData = static_cast<const uint8_t*>(pData.bytes);
	
	m_phouseAccelerationVector.x = *reinterpret_cast<const double*>(&puData[0 * sizeof(double)]);
	m_phouseAccelerationVector.y = *reinterpret_cast<const double*>(&puData[1 * sizeof(double)]);
	m_phouseAccelerationVector.z = *reinterpret_cast<const double*>(&puData[2 * sizeof(double)]);

	[self didChangeValueForKey:@"acceleration"];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (nullable NSData*)data
{
	uint8_t uData[3 * sizeof(double)];
	
	double* prAccelerationX = reinterpret_cast<double*>(&uData[0 * sizeof(double)]);
	*prAccelerationX = m_phouseAccelerationVector.x;
	
	double* prAccelerationY = reinterpret_cast<double*>(&uData[1 * sizeof(double)]);
	*prAccelerationY = m_phouseAccelerationVector.y;
	
	double* prAccelerationZ = reinterpret_cast<double*>(&uData[2 * sizeof(double)]);
	*prAccelerationZ = m_phouseAccelerationVector.z;
	
	return [NSData dataWithBytes:&uData[0] length:sizeof(uData)];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (nullable instancetype)initWithData:(nullable NSData*)pData
{
	if ( [pData length] != 3 * sizeof(double) )
		return nil;
	
	self = [super init];
	
	if ( self != nil )
		[self setData:pData];

	return self;
}

@end
