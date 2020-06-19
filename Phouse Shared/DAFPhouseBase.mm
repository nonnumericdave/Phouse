//
//  DAFPhouseBase.mm
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#include "DAFPhouseBase.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
static CBUUID* const g_pPeripheralUUID = [CBUUID UUIDWithString:@"E4712EE8-383A-42D9-9711-7E78A1BDBE7D"];
static CBUUID* const g_pServiceUUID = [CBUUID UUIDWithString:@"F2E91AE5-6D06-4A55-BE22-1B19153A014E"];
static CBUUID* const g_pCharacteristicUUID = [CBUUID UUIDWithString:@"10205694-57C0-4F31-9B5F-4DB0EDD0EED2"];

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFPhouseBase

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (CBUUID*)peripheralIdentifier
{
	return ::g_pPeripheralUUID;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (CBUUID*)serviceIdentifier
{
	return ::g_pServiceUUID;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (CBUUID*)characteristicIdentifier
{
	return ::g_pCharacteristicUUID;
}

@end
