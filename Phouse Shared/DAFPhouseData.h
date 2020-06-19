//
// DAFPhouseData.h
//  Phouse
//
//  Created by David Flores on 1/1/18.
//  Copyright (c) 2018 David Flores. All rights reserved.
//

#ifndef DAFPhouseData_h
#define DAFPhouseData_h

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
struct DAFPhouseVector
{
	double x;
	double y;
	double z;
};

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@interface DAFPhouseData : NSObject

// NSObject
@property (readonly, copy, nonnull) NSString* description;
- (nonnull NSString*)description;

// DAFPhouseData
+ (nullable NSArray<NSString*>*)observableKeyPaths;

@property (readwrite, assign, nonatomic) DAFPhouseVector acceleration;
@property (readwrite, assign, nonatomic, nullable) NSData* data;
- (void)setData:(nullable NSData*)data;
- (nullable NSData*)data;

- (nullable instancetype)initWithData:(nullable NSData*)pData;

@end

#endif
