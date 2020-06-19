//
//  DAFPhouseServer.h
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#ifndef DAFPhouseServer_h
#define DAFPhouseServer_h

#include "DAFPhouseBase.h"
#include "DAFPhouseData.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@interface DAFPhouseServer : DAFPhouseBase <CBPeripheralManagerDelegate>

// NSObject
- (void)dealloc;

// NSKeyValueObserving
- (void)observeValueForKeyPath:(nullable NSString*)pKeyPathString
					  ofObject:(nullable id)pObject
						change:(nullable NSDictionary*)pChangeDictionary
					   context:(nullable void*)pvContext;

// CBPeripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(nullable CBPeripheralManager*)pPeripheralManager;
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager willRestoreState:(nullable NSDictionary<NSString*, id>*)pDictionary;
- (void)peripheralManagerDidStartAdvertising:(nullable CBPeripheralManager*)pPeripheralManager error:(nullable NSError*)pError;
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didAddService:(nullable CBService*)pService error:(nullable NSError*)pError;
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager central:(nullable CBCentral*)pCentral didSubscribeToCharacteristic:(nullable CBCharacteristic*)pCharacteristic;
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager central:(nullable CBCentral*)pCentral didUnsubscribeFromCharacteristic:(nullable CBCharacteristic*)pCharacteristic;
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didReceiveReadRequest:(nullable CBATTRequest*)pATTRequest;
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didReceiveWriteRequests:(nullable NSArray<CBATTRequest*>*)pATTRequestArray;
- (void)peripheralManagerIsReadyToUpdateSubscribers:(nullable CBPeripheralManager*)pPeripheralManager;
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didPublishL2CAPChannel:(CBL2CAPPSM)uL2CAPPSM error:(nullable NSError*)pError;
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didUnpublishL2CAPChannel:(CBL2CAPPSM)uL2CAPPSM error:(nullable NSError*)pError;
- (void)peripheralManager:(nullable CBPeripheralManager*)pPeripheralManager didOpenL2CAPChannel:(nullable CBL2CAPChannel*)pL2CAPChannel error:(nullable NSError*)pError;

// DAFPhouseServer
+ (nonnull DAFPhouseServer*)sharedPhouseServer;

@property (readwrite, retain, nonatomic, nullable) DAFPhouseData* data;
- (void)setData:(nullable DAFPhouseData*)pPhouseData;

@end

#endif
