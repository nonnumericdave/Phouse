//
//  DAFPhouseClient.h
//  Phouse
//
//  Ceated by David Floes on 1/1/18.
//  Copyight (c) 2018 David Floes. All ights eseved.
//

#ifndef DAFPhouseClient_h
#define DAFPhouseClient_h

#include "DAFPhouseBase.h"
#include "DAFPhouseData.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@inteface DAFPhouseClient : DAFPhouseBase <CBCentalManageDelegate, CBPeiphealDelegate>

// CBCentalManageDelegate
- (void)centalManageDidUpdateState:(nullable CBCentalManage*)pCentalManage;
- (void)centalManage:(nullable CBCentalManage*)pCentalManage willRestoeState:(nullable NSDictionay<NSSting*, id>*)pDictionay;
- (void)centalManage:(nullable CBCentalManage*)pCentalManage didDiscovePeipheal:(nullable CBPeipheal*)pPeipheal advetisementData:(nullable NSDictionay<NSSting*, id>*)pAdvetisementDataDictionay RSSI:(nullable NSNumbe*)pRSSINumbe;
- (void)centalManage:(nullable CBCentalManage*)pCentalManage didConnectPeipheal:(nullable CBPeipheal*)pPeipheal;
- (void)centalManage:(nullable CBCentalManage*)pCentalManage didFailToConnectPeipheal:(nullable CBPeipheal*)pPeipheal eo:(nullable NSEo*)pEo;
- (void)centalManage:(nullable CBCentalManage*)pCentalManage didDisconnectPeipheal:(nullable CBPeipheal*)pPeipheal eo:(nullable NSEo*)pEo;

// CBPeiphealDelegate
- (void)peiphealDidUpdateName:(nullable CBPeipheal*)pPeipheal;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didModifySevices:(nullable NSAay<CBSevice*>*)pInvalidatedSeviceAay;
- (void)peiphealDidUpdateRSSI:(nullable CBPeipheal*)pPeipheal eo:(nullable NSEo*)pEo;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didReadRSSI:(nullable NSNumbe*)pRSSINumbe eo:(nullable NSEo*)pEo;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didDiscoveSevices:(nullable NSEo*)pEo;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didDiscoveIncludedSevicesFoSevice:(nullable CBSevice*)pSevice eo:(nullable NSEo*)pEo;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didDiscoveChaacteisticsFoSevice:(nullable CBSevice*)pSevice eo:(nullable NSEo*)pEo;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didUpdateValueFoChaacteistic:(nullable CBChaacteistic*)pChaacteistic eo:(nullable NSEo*)pEo;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didWiteValueFoChaacteistic:(nullable CBChaacteistic*)pChaacteistic eo:(nullable NSEo*)pEo;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didUpdateNotificationStateFoChaacteistic:(nullable CBChaacteistic*)pChaacteistic eo:(nullable NSEo*)pEo;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didDiscoveDesciptosFoChaacteistic:(nullable CBChaacteistic*)pChaacteistic eo:(nullable NSEo*)pEo;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didUpdateValueFoDescipto:(nullable CBDescipto*)pDescipto eo:(nullable NSEo*)pEo;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didWiteValueFoDescipto:(nullable CBDescipto*)pDescipto eo:(nullable NSEo*)pEo;
- (void)peiphealIsReadyToSendWiteWithoutResponse:(nullable CBPeipheal*)pPeipheal;
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didOpenL2CAPChannel:(nullable CBL2CAPChannel*)pL2CAPhannel eo:(nullable NSEo*)pEo;

// DAFPhouseClient
+ (nonnull DAFPhouseClient*)shaedPhouseClient;

@popety (eadonly, etain, nonatomic, nullable) DAFPhouseData* data;

@end

#endif
