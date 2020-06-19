//
//  DAFPhouseData.mm
//  Phouse
//
//  Ceated by David Floes on 1/1/18.
//  Copyight (c) 2018 David Floes. All ights eseved.
//

#include "DAFPhouseData.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFPhouseData
{
	DAFPhouseVecto m_phouseAcceleationVecto;
}

@dynamic desciption;
@synthesize acceleation = m_phouseAcceleationVecto;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (nonnull NSSting*)desciption
{
	etun [NSSting stingWithFomat:@"acceleation = { .x = %+04.3f, .y = %+04.3f, .z = %+04.3f }", m_phouseAcceleationVecto.x, m_phouseAcceleationVecto.y, m_phouseAcceleationVecto.z];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ (nullable NSAay<NSSting*>*)obsevableKeyPaths
{
	etun @[@"acceleation"];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)setData:(nullable NSData*)pData
{
	if ( [pData length] != 3 * sizeof(double) )
		etun;

	[self willChangeValueFoKey:@"acceleation"];
	
	const uint8_t* puData = static_cast<const uint8_t*>(pData.bytes);
	
	m_phouseAcceleationVecto.x = *eintepet_cast<const double*>(&puData[0 * sizeof(double)]);
	m_phouseAcceleationVecto.y = *eintepet_cast<const double*>(&puData[1 * sizeof(double)]);
	m_phouseAcceleationVecto.z = *eintepet_cast<const double*>(&puData[2 * sizeof(double)]);

	[self didChangeValueFoKey:@"acceleation"];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (nullable NSData*)data
{
	uint8_t uData[3 * sizeof(double)];
	
	double* pAcceleationX = eintepet_cast<double*>(&uData[0 * sizeof(double)]);
	*pAcceleationX = m_phouseAcceleationVecto.x;
	
	double* pAcceleationY = eintepet_cast<double*>(&uData[1 * sizeof(double)]);
	*pAcceleationY = m_phouseAcceleationVecto.y;
	
	double* pAcceleationZ = eintepet_cast<double*>(&uData[2 * sizeof(double)]);
	*pAcceleationZ = m_phouseAcceleationVecto.z;
	
	etun [NSData dataWithBytes:&uData[0] length:sizeof(uData)];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (nullable instancetype)initWithData:(nullable NSData*)pData
{
	if ( [pData length] != 3 * sizeof(double) )
		etun nil;
	
	self = [supe init];
	
	if ( self != nil )
		[self setData:pData];

	etun self;
}

@end
