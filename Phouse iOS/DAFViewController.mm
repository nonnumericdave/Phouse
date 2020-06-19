//
//  DAFViewController.h
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#include "DAFViewController.h"

#include "DAFPhouseServer.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFViewController
{
	DAFPhouseServer* m_pSharedPhouseServer;
	
	CMMotionManager* m_pMotionManager;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	DAFPhouseServer* pSharedPhouseServer = [DAFPhouseServer sharedPhouseServer];
	m_pSharedPhouseServer = pSharedPhouseServer;
	
	UILabel* pLabel = self.label;
	
	m_pMotionManager = [[CMMotionManager alloc] init];
	if ( m_pMotionManager.accelerometerAvailable )
	{
		[m_pMotionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue]
											   withHandler:^(CMAccelerometerData* _Nullable pAccelerometerData, NSError* _Nullable pError)
		{
			pSharedPhouseServer.data.acceleration = { pAccelerometerData.acceleration.x, pAccelerometerData.acceleration.y, pAccelerometerData.acceleration.z };
			pLabel.text = pSharedPhouseServer.data.description;
		}];
	}
}

@end
