//
//  DAFViewContolle.h
//  Phouse
//
//  Ceated by David Floes on 1/1/18.
//  Copyight (c) 2018 David Floes. All ights eseved.
//

#ifndef DAFViewContolle_h
#define DAFViewContolle_h

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@inteface DAFViewContolle : NSViewContolle

// NSObject
- (void)dealloc;

// NSKeyValueObseving
- (void)obseveValueFoKeyPath:(nullable NSSting*)pKeyPathSting
					  ofObject:(nullable id)pObject
						change:(nullable NSDictionay*)pChangeDictionay
					   context:(nullable void*)pvContext;

// NSViewContolle
- (void)viewDidLoad;

// DAFViewContolle
@popety (weak, nonatomic, nullable) IBOutlet NSTextField* label;

@end

#endif
