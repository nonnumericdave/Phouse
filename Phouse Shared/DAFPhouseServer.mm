//
//  DAFPhouseServer.mm
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#include "DAFPhouseServer.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#if defined(DAFPhouseBluetoothDebug)
#	define DAFPhouseServerDebug(pArgumentValuesFormatString, ...) \
		::NSLog(pArgumentValuesFormatString, __VA_ARGS__)
#else
#	define DAFPhouseServerDebug(pArgumentValuesFormatString, ...)
#endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
static const void* g_pvKeyValueObservingContext = nullptr;

static DAFPhouseServer* g_pSharedPhouseServer = nil;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@interface DAFPhouseServer ()

// DAFPhouseServer
- (void)initializeServer;

@end

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFPhouseServer
{
	CBPeripheralManager* m_pPeripheralManager;
	CBMutableCharacteristic* m_pCharacterisitic;
	CBMutableService* m_pService;
	
	DAFPhouseData* m_pPhouseData;
}

@synthesize data = m_pPhouseData;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)dealloc
{
	for (NSString* pKeyPathString in [DAFPhouseData observableKeyPaths])
		[m_pPhouseData removeObserver:self forKeyPath:pKeyPathString context:&::g_pvKeyValueObservingContext];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)observeValueForKeyPath:(nullable NSString*)pKeyPathString
					  ofObject:(nullable id)pObject
						change:(nullable NSDictionary*)pChangeDictionary
					   context:(nullable void*)pvContext
{
	if ( pObject == m_pPhouseData &&
		 pvContext == &::g_pvKeyValueObservingContext )
	{
		DAFPhouseData* pPhouseData = self.data;
		if ( pPhouseData != nil )
			[m_pPeripheralManager updateValue:pPhouseData.data forCharacteristic:m_pCharacterisitic onSubscribedCentrals:nil];
	}
	else
	{
		[super observeValueForKeyPath:pKeyPathString ofObject:pObject change:pChangeDictionary context:pvContext];
	}
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManagerDidUpdateState:(nullable CBPeripheralManager*)pPeripheralManager
{
	DAFPhouseServerDebug(@"\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager);
	
	assert( m_pPeripheralManager == pPeripheralManager );
	
	if ( pPeripheralManager.state == CBManagerStatePoweredOn )
	{
		[m_pPeripheralManager removeAllServices];
		[m_pPeripheralManager addService:m_pService];
		[m_pPeripheralManager startAdvertising:@{CBAdvertisementDataServiceUUIDsKey : @[self.serviceIdentifier]}];
	}
	else if (pPeripheralManager.state == CBManagerStatePoweredOff )
	{
		[m_pPeripheralManager stopAdvertising];
	}
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager willRestoreState:(nullable NSDictionary<NSString*, id>*)pDictionary
{
	DAFPhouseServerDebug(@"\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager, pDictionary);
	
	assert( m_pPeripheralManager == pPeripheralManager );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManagerDidStartAdvertising:(nullable CBPeripheralManager*)pPeripheralManager error:(nullable NSError*)pError
{
	DAFPhouseServerDebug(@"\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager, [pError localizedDescription]);
	
	assert( m_pPeripheralManager == pPeripheralManager );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didAddService:(nullable CBService*)pService error:(nullable NSError*)pError
{
	DAFPhouseServerDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager, pService, [pError localizedDescription]);
	
	assert( m_pPeripheralManager == pPeripheralManager );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager central:(nullable CBCentral*)pCentral didSubscribeToCharacteristic:(nullable CBCharacteristic*)pCharacteristic
{
	DAFPhouseServerDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager, pCentral, pCharacteristic);
	
	assert( m_pPeripheralManager == pPeripheralManager );
	
	[m_pPeripheralManager stopAdvertising];

	DAFPhouseData* pPhouseData = self.data;
	if ( pPhouseData != nil )
		[m_pPeripheralManager updateValue:pPhouseData.data forCharacteristic:m_pCharacterisitic onSubscribedCentrals:nil];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager central:(nullable CBCentral*)pCentral didUnsubscribeFromCharacteristic:(nullable CBCharacteristic*)pCharacteristic
{
	DAFPhouseServerDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager, pCentral, pCharacteristic);
	
	assert( m_pPeripheralManager == pPeripheralManager );
	
	[self peripheralManagerDidUpdateState:m_pPeripheralManager];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didReceiveReadRequest:(nullable CBATTRequest*)pATTRequest
{
	DAFPhouseServerDebug(@"\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager, pATTRequest);
	
	assert( m_pPeripheralManager == pPeripheralManager );
	
	DAFPhouseData* pPhouseData = self.data;
	if ( pPhouseData != nil )
		pATTRequest.value = pPhouseData.data;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didReceiveWriteRequests:(nullable NSArray<CBATTRequest*>*)pATTRequestArray
{
	DAFPhouseServerDebug(@"\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager, pATTRequestArray);
	
	assert( m_pPeripheralManager == pPeripheralManager );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManagerIsReadyToUpdateSubscribers:(nullable CBPeripheralManager*)pPeripheralManager
{
	DAFPhouseServerDebug(@"\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager);
	
	assert( m_pPeripheralManager == pPeripheralManager );
	
	DAFPhouseData* pPhouseData = self.data;
	if ( pPhouseData != nil )
		[m_pPeripheralManager updateValue:pPhouseData.data forCharacteristic:m_pCharacterisitic onSubscribedCentrals:nil];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didPublishL2CAPChannel:(CBL2CAPPSM)uL2CAPPSM error:(nullable NSError*)pError
{
	DAFPhouseServerDebug(@"\n%@\n\n%@\n\n%hu\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager, uL2CAPPSM, [pError localizedDescription]);
	
	assert( m_pPeripheralManager == pPeripheralManager );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didUnpublishL2CAPChannel:(CBL2CAPPSM)uL2CAPPSM error:(nullable NSError*)pError
{
	DAFPhouseServerDebug(@"\n%@\n\n%@\n\n%hu\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager, uL2CAPPSM, [pError localizedDescription]);
	
	assert( m_pPeripheralManager == pPeripheralManager );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didOpenL2CAPChannel:(nullable CBL2CAPChannel*)pL2CAPChannel error:(nullable NSError*)pError
{
	DAFPhouseServerDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStringFromSelector(_cmd), pPeripheralManager, pL2CAPChannel, [pError localizedDescription]);
	
	assert( m_pPeripheralManager == pPeripheralManager );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)setData:(nullable DAFPhouseData*)pPhouseData
{
	if ( m_pPhouseData == pPhouseData )
		return;
	
	for (NSString* pKeyPathString in [DAFPhouseData observableKeyPaths])
		[m_pPhouseData removeObserver:self forKeyPath:pKeyPathString context:&::g_pvKeyValueObservingContext];

	m_pPhouseData = pPhouseData;

	for (NSString* pKeyPathString in [DAFPhouseData observableKeyPaths])
		[m_pPhouseData addObserver:self forKeyPath:pKeyPathString options:0 context:&::g_pvKeyValueObservingContext];
	
	if ( m_pPhouseData != nil )
		[m_pPeripheralManager updateValue:m_pPhouseData.data forCharacteristic:m_pCharacterisitic onSubscribedCentrals:nil];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ (nonnull DAFPhouseServer*)sharedPhouseServer
{
	static dispatch_once_t dispatchOnce;
	::dispatch_once(&dispatchOnce,
					^void(void)
					{
						::g_pSharedPhouseServer = [[DAFPhouseServer alloc] init];
						[::g_pSharedPhouseServer initializeServer];
					});
	
	return ::g_pSharedPhouseServer;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)initializeServer
{
	[self setData:[[DAFPhouseData alloc] init]];
	
	m_pCharacterisitic =
		[[CBMutableCharacteristic alloc] initWithType:self.characteristicIdentifier properties:CBCharacteristicPropertyRead | CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
	
	m_pService = [[CBMutableService alloc] initWithType:self.serviceIdentifier primary:YES];
	m_pService.characteristics = @[m_pCharacterisitic];

	m_pPeripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
}

@end
