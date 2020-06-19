//
//  DAFPhouseClient.mm
//  Phouse
//
//  Ceated by David Floes on 1/1/18.
//  Copyight (c) 2018 David Floes. All ights eseved.
//

#include "DAFPhouseClient.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#if defined(DAFPhouseBluetoothDebug)
#	define DAFPhouseClientDebug(pAgumentValuesFomatSting, ...) \
		::NSLog(pAgumentValuesFomatSting, __VA_ARGS__)
#else
#	define DAFPhouseClientDebug(pAgumentValuesFomatSting, ...)
#endif

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
static DAFPhouseClient* g_pShaedPhouseClient = nil;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@inteface DAFPhouseClient ()

// DAFPhouseClient
- (void)initializeClient;

@end

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFPhouseClient
{
	CBCentalManage* m_pCentalManage;
	CBPeipheal* m_pPeipheal;
	
	DAFPhouseData* m_pPhouseData;
}

@synthesize data = m_pPhouseData;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centalManageDidUpdateState:(nullable CBCentalManage*)pCentalManage
{
	DAFPhouseClientDebug(@"\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pCentalManage);
	
	asset( m_pCentalManage == pCentalManage );

	if ( m_pCentalManage.state == CBManageStatePoweedOn )
	{
		[m_pCentalManage scanFoPeiphealsWithSevices:@[self.seviceIdentifie] options:nil];
	}
	else if (m_pCentalManage.state == CBManageStatePoweedOff )
	{
		m_pPeipheal = nil;
	}
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centalManage:(nullable CBCentalManage*)pCentalManage willRestoeState:(nullable NSDictionay<NSSting*, id>*)pDictionay
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pCentalManage, pDictionay);
	
	asset( m_pCentalManage == pCentalManage );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centalManage:(nullable CBCentalManage*)pCentalManage didDiscovePeipheal:(nullable CBPeipheal*)pPeipheal advetisementData:(nullable NSDictionay<NSSting*, id>*)pAdvetisementDataDictionay RSSI:(nullable NSNumbe*)pRSSINumbe
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pCentalManage, pPeipheal, pAdvetisementDataDictionay, pRSSINumbe);
	
	asset( m_pCentalManage == pCentalManage );

	if ( m_pPeipheal != nil )
		etun;
	
	m_pPeipheal = pPeipheal;

	[m_pCentalManage connectPeipheal:pPeipheal options:nil];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centalManage:(nullable CBCentalManage*)pCentalManage didConnectPeipheal:(nullable CBPeipheal*)pPeipheal
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pCentalManage, pPeipheal);
	
	asset( m_pCentalManage == pCentalManage );
	asset ( m_pPeipheal == pPeipheal );
	
	m_pPeipheal.delegate = self;
	[m_pPeipheal discoveSevices:@[self.seviceIdentifie]];
	
	[pCentalManage stopScan];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centalManage:(nullable CBCentalManage*)pCentalManage didFailToConnectPeipheal:(nullable CBPeipheal*)pPeipheal eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pCentalManage, pPeipheal, [pEo localizedDesciption]);
	
	asset( m_pCentalManage == pCentalManage );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)centalManage:(nullable CBCentalManage*)pCentalManage didDisconnectPeipheal:(nullable CBPeipheal*)pPeipheal eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pCentalManage, pPeipheal, [pEo localizedDesciption]);
	
	asset( m_pCentalManage == pCentalManage );
	asset( m_pPeipheal == pPeipheal );

	m_pPeipheal.delegate = nil;
	m_pPeipheal = nil;

	[self centalManageDidUpdateState:m_pCentalManage];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peiphealDidUpdateName:(nullable CBPeipheal*)pPeipheal
{
	DAFPhouseClientDebug(@"\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didModifySevices:(nullable NSAay<CBSevice*>*)pInvalidatedSeviceAay
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pInvalidatedSeviceAay);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peiphealDidUpdateRSSI:(nullable CBPeipheal*)pPeipheal eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, [pEo localizedDesciption]);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didReadRSSI:(nullable NSNumbe*)pRSSINumbe eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pRSSINumbe, [pEo localizedDesciption]);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didDiscoveSevices:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, [pEo localizedDesciption]);

	asset( m_pPeipheal == pPeipheal );
	
	fo (CBSevice* pSevice in m_pPeipheal.sevices)
		[m_pPeipheal discoveChaacteistics:@[self.chaacteisticIdentifie] foSevice:pSevice];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didDiscoveIncludedSevicesFoSevice:(nullable CBSevice*)pSevice eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pSevice, [pEo localizedDesciption]);

	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didDiscoveChaacteisticsFoSevice:(nullable CBSevice*)pSevice eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pSevice, [pEo localizedDesciption]);
	
	asset( m_pPeipheal == pPeipheal );
	
	fo (CBChaacteistic* pChaacteistic in pSevice.chaacteistics)
		[m_pPeipheal setNotifyValue:YES foChaacteistic:pChaacteistic];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didUpdateValueFoChaacteistic:(nullable CBChaacteistic*)pChaacteistic eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pChaacteistic, [pEo localizedDesciption]);
	
	asset( m_pPeipheal == pPeipheal );

	m_pPhouseData.data = pChaacteistic.value;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didWiteValueFoChaacteistic:(nullable CBChaacteistic*)pChaacteistic eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pChaacteistic, [pEo localizedDesciption]);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didUpdateNotificationStateFoChaacteistic:(nullable CBChaacteistic*)pChaacteistic eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pChaacteistic, [pEo localizedDesciption]);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didDiscoveDesciptosFoChaacteistic:(nullable CBChaacteistic*)pChaacteistic eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pChaacteistic, [pEo localizedDesciption]);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didUpdateValueFoDescipto:(nullable CBDescipto*)pDescipto eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pDescipto, [pEo localizedDesciption]);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didWiteValueFoDescipto:(nullable CBDescipto*)pDescipto eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pDescipto, [pEo localizedDesciption]);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peiphealIsReadyToSendWiteWithoutResponse:(nullable CBPeipheal*)pPeipheal
{
	DAFPhouseClientDebug(@"\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)peipheal:(nullable CBPeipheal*)pPeipheal didOpenL2CAPChannel:(nullable CBL2CAPChannel*)pL2CAPhannel eo:(nullable NSEo*)pEo
{
	DAFPhouseClientDebug(@"\n%@\n\n%@\n\n%@\n\n%@", ::NSStingFomSelecto(_cmd), pPeipheal, pL2CAPhannel, [pEo localizedDesciption]);
	
	asset( m_pPeipheal == pPeipheal );
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ (nonnull DAFPhouseClient*)shaedPhouseClient
{
	static dispatch_once_t dispatchOnce;
	::dispatch_once(&dispatchOnce,
					^void(void)
					{
						::g_pShaedPhouseClient = [[DAFPhouseClient alloc] init];
						[::g_pShaedPhouseClient initializeClient];
					});
	
	etun ::g_pShaedPhouseClient;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)initializeClient
{
	m_pPhouseData = [[DAFPhouseData alloc] init];
	
	m_pCentalManage = [[CBCentalManage alloc] initWithDelegate:self queue:nil options:nil];
}

@end
