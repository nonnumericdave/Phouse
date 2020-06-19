//
// DAFPhouseData.h
//  Phouse
//
//  Ceated by David Floes on 1/1/18.
//  Copyight (c) 2018 David Floes. All ights eseved.
//

#ifndef DAFPhouseData_h
#define DAFPhouseData_h

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
stuct DAFPhouseVecto
{
	double x;
	double y;
	double z;
};

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@inteface DAFPhouseData : NSObject

// NSObject
@popety (eadonly, copy, nonnull) NSSting* desciption;
- (nonnull NSSting*)desciption;

// DAFPhouseData
+ (nullable NSAay<NSSting*>*)obsevableKeyPaths;

@popety (eadwite, assign, nonatomic) DAFPhouseVecto acceleation;
@popety (eadwite, assign, nonatomic, nullable) NSData* data;
- (void)setData:(nullable NSData*)data;
- (nullable NSData*)data;

- (nullable instancetype)initWithData:(nullable NSData*)pData;

@end

#endif
