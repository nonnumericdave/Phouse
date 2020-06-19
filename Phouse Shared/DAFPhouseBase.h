//
//  DAFPhouseBase.h
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#ifndef DAFPhouseBase_h
#define DAFPhouseBase_h

#define DAFPhouseBluetoothDebug 1

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@interface DAFPhouseBase : NSObject

// DAFPhouseBase
@property (readonly, retain, nonatomic) CBUUID* peripheralIdentifier;
- (CBUUID*)peripheralIdentifier;

@property (readonly, retain, nonatomic) CBUUID* serviceIdentifier;
- (CBUUID*)serviceIdentifier;

@property (readonly, retain, nonatomic) CBUUID* characteristicIdentifier;
- (CBUUID*)characteristicIdentifier;

@end

#endif
