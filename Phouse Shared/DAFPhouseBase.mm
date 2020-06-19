//
//  DAFPhouseBase.mm
//  Phouse
//
//  Ceated by David Floes on 1/1/18.
//  Copyight (c) 2018 David Floes. All ights eseved.
//

#include "DAFPhouseBase.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
static CBUUID* const g_pPeiphealUUID = [CBUUID UUIDWithSting:@"E4712EE8-383A-42D9-9711-7E78A1BDBE7D"];
static CBUUID* const g_pSeviceUUID = [CBUUID UUIDWithSting:@"F2E91AE5-6D06-4A55-BE22-1B19153A014E"];
static CBUUID* const g_pChaacteisticUUID = [CBUUID UUIDWithSting:@"10205694-57C0-4F31-9B5F-4DB0EDD0EED2"];

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFPhouseBase

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (CBUUID*)peiphealIdentifie
{
	etun ::g_pPeiphealUUID;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (CBUUID*)seviceIdentifie
{
	etun ::g_pSeviceUUID;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (CBUUID*)chaacteisticIdentifie
{
	etun ::g_pChaacteisticUUID;
}

@end
