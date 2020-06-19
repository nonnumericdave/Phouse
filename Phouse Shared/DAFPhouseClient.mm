//
//  DAFPhouseClient.mm
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#include "DAFPhouseClient.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#if defined(DAFPhouseBluetoothDebug)
#	define DAFPhouseClientDebug(pArgumentValuesFormatString, ...) \
		::NSLog(pArgumentValuesFormatString, __VA_ARGS__)
#else
#	define DAFPhouseClientDebug(pArgumentValuesFormatString, ...)
#endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
static DAFPhouseClient* g_pSharedPhouseClient = nil;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@interface DAFPhouseClient ()

// DAFPhouseClient
- (void)initializeClient;

@end

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFPhouseClient
{
	CBCentralManager* m_pCentralManager;
	CBPeripheral* m_pPeripheral;
	
	DAFPhouseData* m_pPhouseData;
}

@synthesize data = m_pPhouseData;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centralManagerDidUpdateState:(nullable CBCentralManager*)pCentralManager
{
	DAFPhouseClientDebug(@"\n%@\n\n%@", ::NSStringFromSelector(_cmd), pCentralManager);
	
	assert( m_pCentralManager == pCentralManager );

	if ( m_pCentralManager.state == CBManagerStatePoweredOn )
	{
		[m_pCentralManager scanForPeripheralsWithServices:@[self.serviceIdentifier] options:nil];
	}
	else if (m_pCentralManager.state == CBManagerStatePoweredOff )
	{
		m_pPeripheral = nil;
	}
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centralManager:(nullable CBCentralManager*)pCentralManager willRestoreState:(nullable NSDictionary<NSString*, id>*)pDictionary
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pCentralManager, pDictionary);
	
	assert( m_pCentralManager == pCentralManager );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centralManager:(nullable CBCentralManager*)pCentralManager didDiscoverPeripheral:(nullable CBPeripheral*)pPeripheral advertisementData:(nullable NSDictionary<NSString*, id>*)pAdvertisementDataDictionary RSSI:(nullable NSNumber*)pRSSINumber
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pCentralManager, pPeripheral, pAdvertisementDataDictionary, pRSSINumber);
	
	assert( m_pCentralManager == pCentralManager );

	if ( m_pPeripheral != nil )
		return;
	
	m_pPeripheral = pPeripheral;

	[m_pCentralManager connectPeripheral:pPeripheral options:nil];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centralManager:(nullable CBCentralManager*)pCentralManager didConnectPeripheral:(nullable CBPeripheral*)pPeripheral
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pCentralManager, pPeripheral);
	
	assert( m_pCentralManager == pCentralManager );
	assert ( m_pPeripheral == pPeripheral );
	
	m_pPeripheral.delegate = self;
	[m_pPeripheral discoverServices:@[self.serviceIdentifier]];
	
	[pCentralManager stopScan];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centralManager:(nullable CBCentralManager*)pCentralManager didFailToConnectPeripheral:(nullable CBPeripheral*)pPeripheral error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pCentralManager, pPeripheral, [pError localizedDescription]);
	
	assert( m_pCentralManager == pCentralManager );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centralManager:(nullable CBCentralManager*)pCentralManager didDisconnectPeripheral:(nullable CBPeripheral*)pPeripheral error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pCentralManager, pPeripheral, [pError localizedDescription]);
	
	assert( m_pCentralManager == pCentralManager );
	assert( m_pPeripheral == pPeripheral );

	m_pPeripheral.delegate = nil;
	m_pPeripheral = nil;

	[self centralManagerDidUpdateState:m_pCentralManager];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralDidUpdateName:(nullable CBPeripheral*)pPeripheral
{
	DAFPhouseClientDebug(@"\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didModifyServices:(nullable NSArray<CBService*>*)pInvalidatedServiceArray
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pInvalidatedServiceArray);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralDidUpdateRSSI:(nullable CBPeripheral*)pPeripheral error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, [pError localizedDescription]);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didReadRSSI:(nullable NSNumber*)pRSSINumber error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pRSSINumber, [pError localizedDescription]);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didDiscoverServices:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, [pError localizedDescription]);

	assert( m_pPeripheral == pPeripheral );
	
	for (CBService* pService in m_pPeripheral.services)
		[m_pPeripheral discoverCharacteristics:@[self.characteristicIdentifier] forService:pService];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didDiscoverIncludedServicesForService:(nullable CBService*)pService error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pService, [pError localizedDescription]);

	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didDiscoverCharacteristicsForService:(nullable CBService*)pService error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pService, [pError localizedDescription]);
	
	assert( m_pPeripheral == pPeripheral );
	
	for (CBCharacteristic* pCharacteristic in pService.characteristics)
		[m_pPeripheral setNotifyValue:YES forCharacteristic:pCharacteristic];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didUpdateValueForCharacteristic:(nullable CBCharacteristic*)pCharacteristic error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pCharacteristic, [pError localizedDescription]);
	
	assert( m_pPeripheral == pPeripheral );

	m_pPhouseData.data = pCharacteristic.value;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didWriteValueForCharacteristic:(nullable CBCharacteristic*)pCharacteristic error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pCharacteristic, [pError localizedDescription]);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didUpdateNotificationStateForCharacteristic:(nullable CBCharacteristic*)pCharacteristic error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pCharacteristic, [pError localizedDescription]);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didDiscoverDescriptorsForCharacteristic:(nullable CBCharacteristic*)pCharacteristic error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pCharacteristic, [pError localizedDescription]);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didUpdateValueForDescriptor:(nullable CBDescriptor*)pDescriptor error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pDescriptor, [pError localizedDescription]);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didWriteValueForDescriptor:(nullable CBDescriptor*)pDescriptor error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pDescriptor, [pError localizedDescription]);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralIsReadyToSendWriteWithoutResponse:(nullable CBPeripheral*)pPeripheral
{
	DAFPhouseClientDebug(@"\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didOpenL2CAPChannel:(nullable CBL2CAPChannel*)pL2CAPhannel error:(nullable NSError*)pError
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheral, pL2CAPhannel, [pError localizedDescription]);
	
	assert( m_pPeripheral == pPeripheral );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ (nonnull DAFPhouseClient*)sharedPhouseClient
{
	static dispatch_once_t dispatchOnce;
	::dispatch_once(&dispatchOnce,
					^void(void)
					{
						::g_pSharedPhouseClient = [[DAFPhouseClient alloc] init];
						[::g_pSharedPhouseClient initializeClient];
					});
	
	return ::g_pSharedPhouseClient;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)initializeClient
{
	m_pPhouseData = [[DAFPhouseData alloc] init];
	
	m_pCentralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
}

@end
