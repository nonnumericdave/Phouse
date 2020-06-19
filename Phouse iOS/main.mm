//
//  main.mm
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#include "DAFApplicationDelegate.h"

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int
main(int iArgumentCount, char* aszArguments[])
{
	@autoreleasepool
	{
		return ::UIApplicationMain(iArgumentCount, aszArguments, nil, ::NSStringFromClass([DAFApplicationDelegate class]));
	}
	                        
}
