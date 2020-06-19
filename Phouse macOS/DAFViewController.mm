//
//  DAFViewController.h
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#include "DAFViewController.h"

#include "DAFPhouseClient.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
static const void* g_pvKeyValueObservingContext = nullptr;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@interface DAFViewController ()

// DAFViewController
- (void)didChangeData;

@end

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFViewController
{
	DAFPhouseClient* m_pSharedPhouseClient;
	
	DAFPhouseData* m_pPhouseData;
	
	std::chrono::time_point<std::chrono::high_resolution_clock> m_previousHighResolutionClockTimePoint;
	
	double m_rXMetersPerSecond;
	double m_rYMetersPerSecond;
	
	double m_rXPointDeltaRemainder;
	double m_rYPointDeltaRemainder;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)dealloc
{
	for (NSString* pKeyPathString in [DAFPhouseData observableKeyPaths])
		[m_pPhouseData addObserver:self forKeyPath:pKeyPathString options:0 context:&::g_pvKeyValueObservingContext];
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
		[self didChangeData];
	}
	else
	{
		[super observeValueForKeyPath:pKeyPathString ofObject:pObject change:pChangeDictionary context:pvContext];
	}
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	m_pSharedPhouseClient = [DAFPhouseClient sharedPhouseClient];
	
	m_pPhouseData = m_pSharedPhouseClient.data;
	
	m_previousHighResolutionClockTimePoint = std::chrono::high_resolution_clock::now();
	
	for (NSString* pKeyPathString in [DAFPhouseData observableKeyPaths])
		[m_pPhouseData addObserver:self forKeyPath:pKeyPathString options:0 context:&::g_pvKeyValueObservingContext];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)didChangeData
{
	self.label.stringValue = m_pPhouseData.description;
	
	std::chrono::time_point<std::chrono::high_resolution_clock> highResolutionClockTimePoint = std::chrono::high_resolution_clock::now();
	std::chrono::time_point<std::chrono::high_resolution_clock>::duration deltaHighResolutionClockTimePointDuration = highResolutionClockTimePoint - m_previousHighResolutionClockTimePoint;
	m_previousHighResolutionClockTimePoint = highResolutionClockTimePoint;
	
	double rSecondsDelta =
		static_cast<double>(std::chrono::time_point<std::chrono::high_resolution_clock>::duration::period::num) *
		static_cast<double>(deltaHighResolutionClockTimePointDuration.count()) /
		static_cast<double>(std::chrono::time_point<std::chrono::high_resolution_clock>::duration::period::den);

	DAFPhouseVector phouseVectorAcceleration = m_pSharedPhouseClient.data.acceleration;
	
	m_rXMetersPerSecond = m_rXMetersPerSecond + phouseVectorAcceleration.x * 9.81 * rSecondsDelta;
	m_rYMetersPerSecond = m_rYMetersPerSecond + phouseVectorAcceleration.y * 9.81 * rSecondsDelta;

	double rXMetersDelta = m_rXMetersPerSecond * rSecondsDelta;
	double rYMetersDelta = m_rYMetersPerSecond * rSecondsDelta;
	
	double rXPointDelta = rXMetersDelta * 100;
	double rYPointDelta = rYMetersDelta * 100;
	
	double rXPointDeltaIntegral;
	m_rXPointDeltaRemainder = std::modf(rXPointDelta + m_rXPointDeltaRemainder, &rXPointDeltaIntegral);

	double rYPointDeltaIntegral;
	m_rYPointDeltaRemainder = std::modf(rYPointDelta + m_rYPointDeltaRemainder, &rYPointDeltaIntegral);

	CGEventRef refPreviousMouseEvent = ::CGEventCreate(NULL);
	CGPoint pointPreviousMouse = ::CGEventGetLocation(refPreviousMouseEvent);
	::CFRelease(refPreviousMouseEvent);
	
	CGPoint pointMouse = {
		.x = pointPreviousMouse.x + rXPointDeltaIntegral,
		.y = pointPreviousMouse.y + rYPointDeltaIntegral
	};
	
	CGEventRef refMouseEvent = ::CGEventCreateMouseEvent(NULL, kCGEventMouseMoved, pointMouse, kCGMouseButtonLeft);

	::CGEventPost(kCGHIDEventTap, refMouseEvent);
	
	::CFRelease(refMouseEvent);
}

@end
