//
//  DAFPhouseClient.h
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#ifndef DAFPhouseClient_h
#define DAFPhouseClient_h

#include "DAFPhouseBase.h"
#include "DAFPhouseData.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@interface DAFPhouseClient : DAFPhouseBase <CBCentralManagerDelegate, CBPeripheralDelegate>

// CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(nullable CBCentralManager*)pCentralManager;
- (void)centralManager:(nullable CBCentralManager*)pCentralManager willRestoreState:(nullable NSDictionary<NSString*, id>*)pDictionary;
- (void)centralManager:(nullable CBCentralManager*)pCentralManager didDiscoverPeripheral:(nullable CBPeripheral*)pPeripheral advertisementData:(nullable NSDictionary<NSString*, id>*)pAdvertisementDataDictionary RSSI:(nullable NSNumber*)pRSSINumber;
- (void)centralManager:(nullable CBCentralManager*)pCentralManager didConnectPeripheral:(nullable CBPeripheral*)pPeripheral;
- (void)centralManager:(nullable CBCentralManager*)pCentralManager didFailToConnectPeripheral:(nullable CBPeripheral*)pPeripheral error:(nullable NSError*)pError;
- (void)centralManager:(nullable CBCentralManager*)pCentralManager didDisconnectPeripheral:(nullable CBPeripheral*)pPeripheral error:(nullable NSError*)pError;

// CBPeripheralDelegate
- (void)peripheralDidUpdateName:(nullable CBPeripheral*)pPeripheral;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didModifyServices:(nullable NSArray<CBService*>*)pInvalidatedServiceArray;
- (void)peripheralDidUpdateRSSI:(nullable CBPeripheral*)pPeripheral error:(nullable NSError*)pError;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didReadRSSI:(nullable NSNumber*)pRSSINumber error:(nullable NSError*)pError;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didDiscoverServices:(nullable NSError*)pError;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didDiscoverIncludedServicesForService:(nullable CBService*)pService error:(nullable NSError*)pError;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didDiscoverCharacteristicsForService:(nullable CBService*)pService error:(nullable NSError*)pError;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didUpdateValueForCharacteristic:(nullable CBCharacteristic*)pCharacteristic error:(nullable NSError*)pError;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didWriteValueForCharacteristic:(nullable CBCharacteristic*)pCharacteristic error:(nullable NSError*)pError;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didUpdateNotificationStateForCharacteristic:(nullable CBCharacteristic*)pCharacteristic error:(nullable NSError*)pError;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didDiscoverDescriptorsForCharacteristic:(nullable CBCharacteristic*)pCharacteristic error:(nullable NSError*)pError;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didUpdateValueForDescriptor:(nullable CBDescriptor*)pDescriptor error:(nullable NSError*)pError;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didWriteValueForDescriptor:(nullable CBDescriptor*)pDescriptor error:(nullable NSError*)pError;
- (void)peripheralIsReadyToSendWriteWithoutResponse:(nullable CBPeripheral*)pPeripheral;
- (void)peripheral:(nullable CBPeripheral*)pPeripheral didOpenL2CAPChannel:(nullable CBL2CAPChannel*)pL2CAPhannel error:(nullable NSError*)pError;

// DAFPhouseClient
+ (nonnull DAFPhouseClient*)sharedPhouseClient;

@property (readonly, retain, nonatomic, nullable) DAFPhouseData* data;

@end

#endif
