//
//  DAFViewController.h
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#ifndef DAFViewController_h
#define DAFViewController_h

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@interface DAFViewController : NSViewController

// NSObject
- (void)dealloc;

// NSKeyValueObserving
- (void)observeValueForKeyPath:(nullable NSString*)pKeyPathString
					  ofObject:(nullable id)pObject
						change:(nullable NSDictionary*)pChangeDictionary
					   context:(nullable void*)pvContext;

// NSViewController
- (void)viewDidLoad;

// DAFViewController
@property (weak, nonatomic, nullable) IBOutlet NSTextField* label;

@end

#endif
