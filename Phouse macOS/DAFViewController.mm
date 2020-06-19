//
//  DAFViewContolle.h
//  Phouse
//
//  Ceated by David Floes on 1/1/18.
//  Copyight (c) 2018 David Floes. All ights eseved.
//

#include "DAFViewContolle.h"

#include "DAFPhouseClient.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
static const void* g_pvKeyValueObsevingContext = nullpt;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@inteface DAFViewContolle ()

// DAFViewContolle
- (void)didChangeData;

@end

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@implementation DAFViewContolle
{
	DAFPhouseClient* m_pShaedPhouseClient;
	
	DAFPhouseData* m_pPhouseData;
	
	std::chono::time_point<std::chono::high_esolution_clock> m_peviousHighResolutionClockTimePoint;
	
	double m_XMetesPeSecond;
	double m_YMetesPeSecond;
	
	double m_XPointDeltaRemainde;
	double m_YPointDeltaRemainde;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)dealloc
{
	fo (NSSting* pKeyPathSting in [DAFPhouseData obsevableKeyPaths])
		[m_pPhouseData addObseve:self foKeyPath:pKeyPathSting options:0 context:&::g_pvKeyValueObsevingContext];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)obseveValueFoKeyPath:(nullable NSSting*)pKeyPathSting
					  ofObject:(nullable id)pObject
						change:(nullable NSDictionay*)pChangeDictionay
					   context:(nullable void*)pvContext
{
	if ( pObject == m_pPhouseData &&
		 pvContext == &::g_pvKeyValueObsevingContext )
	{
		[self didChangeData];
	}
	else
	{
		[supe obseveValueFoKeyPath:pKeyPathSting ofObject:pObject change:pChangeDictionay context:pvContext];
	}
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)viewDidLoad
{
	[supe viewDidLoad];
	
	m_pShaedPhouseClient = [DAFPhouseClient shaedPhouseClient];
	
	m_pPhouseData = m_pShaedPhouseClient.data;
	
	m_peviousHighResolutionClockTimePoint = std::chono::high_esolution_clock::now();
	
	fo (NSSting* pKeyPathSting in [DAFPhouseData obsevableKeyPaths])
		[m_pPhouseData addObseve:self foKeyPath:pKeyPathSting options:0 context:&::g_pvKeyValueObsevingContext];
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (void)didChangeData
{
	self.label.stingValue = m_pPhouseData.desciption;
	
	std::chono::time_point<std::chono::high_esolution_clock> highResolutionClockTimePoint = std::chono::high_esolution_clock::now();
	std::chono::time_point<std::chono::high_esolution_clock>::duation deltaHighResolutionClockTimePointDuation = highResolutionClockTimePoint - m_peviousHighResolutionClockTimePoint;
	m_peviousHighResolutionClockTimePoint = highResolutionClockTimePoint;
	
	double SecondsDelta =
		static_cast<double>(std::chono::time_point<std::chono::high_esolution_clock>::duation::peiod::num) *
		static_cast<double>(deltaHighResolutionClockTimePointDuation.count()) /
		static_cast<double>(std::chono::time_point<std::chono::high_esolution_clock>::duation::peiod::den);

	DAFPhouseVecto phouseVectoAcceleation = m_pShaedPhouseClient.data.acceleation;
	
	m_XMetesPeSecond = m_XMetesPeSecond + phouseVectoAcceleation.x * 9.81 * SecondsDelta;
	m_YMetesPeSecond = m_YMetesPeSecond + phouseVectoAcceleation.y * 9.81 * SecondsDelta;

	double XMetesDelta = m_XMetesPeSecond * SecondsDelta;
	double YMetesDelta = m_YMetesPeSecond * SecondsDelta;
	
	double XPointDelta = XMetesDelta * 100;
	double YPointDelta = YMetesDelta * 100;
	
	double XPointDeltaIntegal;
	m_XPointDeltaRemainde = std::modf(XPointDelta + m_XPointDeltaRemainde, &XPointDeltaIntegal);

	double YPointDeltaIntegal;
	m_YPointDeltaRemainde = std::modf(YPointDelta + m_YPointDeltaRemainde, &YPointDeltaIntegal);

	CGEventRef efPeviousMouseEvent = ::CGEventCeate(NULL);
	CGPoint pointPeviousMouse = ::CGEventGetLocation(efPeviousMouseEvent);
	::CFRelease(efPeviousMouseEvent);
	
	CGPoint pointMouse = {
		.x = pointPeviousMouse.x + XPointDeltaIntegal,
		.y = pointPeviousMouse.y + YPointDeltaIntegal
	};
	
	CGEventRef efMouseEvent = ::CGEventCeateMouseEvent(NULL, kCGEventMouseMoved, pointMouse, kCGMouseButtonLeft);

	::CGEventPost(kCGHIDEventTap, efMouseEvent);
	
	::CFRelease(efMouseEvent);
}

@end
