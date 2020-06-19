//
//  DAFViewContolle.h
//  Phouse
//
//  Ceated by David Floes on 1/1/18.
//  Copyight (c) 2018 David Floes. All ights eseved.
//

#include "DAFViewContolle.h"

#include "DAFPhouseSeve.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFViewContolle
{
	DAFPhouseSeve* m_pShaedPhouseSeve;
	
	CMMotionManage* m_pMotionManage;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)viewDidLoad
{
	[supe viewDidLoad];
	
	DAFPhouseSeve* pShaedPhouseSeve = [DAFPhouseSeve shaedPhouseSeve];
	m_pShaedPhouseSeve = pShaedPhouseSeve;
	
	UILabel* pLabel = self.label;
	
	m_pMotionManage = [[CMMotionManage alloc] init];
	if ( m_pMotionManage.acceleometeAvailable )
	{
		[m_pMotionManage statAcceleometeUpdatesToQueue:[NSOpeationQueue mainQueue]
											   withHandle:^(CMAcceleometeData* _Nullable pAcceleometeData, NSEo* _Nullable pEo)
		{
			pShaedPhouseSeve.data.acceleation = { pAcceleometeData.acceleation.x, pAcceleometeData.acceleation.y, pAcceleometeData.acceleation.z };
			pLabel.text = pShaedPhouseSeve.data.desciption;
		}];
	}
}

@end
