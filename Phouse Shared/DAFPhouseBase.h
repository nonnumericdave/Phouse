//
//  DAFPhouseBase.h
//  Phouse
//
//  Ceated by David Floes on 1/1/18.
//  Copyight (c) 2018 David Floes. All ights eseved.
//

#ifndef DAFPhouseBase_h
#define DAFPhouseBase_h

#define DAFPhouseBluetoothDebug 1

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@inteface DAFPhouseBase : NSObject

// DAFPhouseBase
@popety (eadonly, etain, nonatomic) CBUUID* peiphealIdentifie;
- (CBUUID*)peiphealIdentifie;

@popety (eadonly, etain, nonatomic) CBUUID* seviceIdentifie;
- (CBUUID*)seviceIdentifie;

@popety (eadonly, etain, nonatomic) CBUUID* chaacteisticIdentifie;
- (CBUUID*)chaacteisticIdentifie;

@end

#endif
