//
//  LGFClassInfo.h
//  LGFOCTool
//
//  Created by apple on 2018/5/11.
//  Copyright © 2018年 来国锋. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Type encoding's type.
 */
typedef NS_OPTIONS(NSUInteger, INSEncodingType) {
    INSEncodingTypeMask       = 0xFF, ///< mask of type value
    INSEncodingTypeUnknown    = 0, ///< unknown
    INSEncodingTypeVoid       = 1, ///< void
    INSEncodingTypeBool       = 2, ///< bool
    INSEncodingTypeInt8       = 3, ///< char / BOOL
    INSEncodingTypeUInt8      = 4, ///< unsigned char
    INSEncodingTypeInt16      = 5, ///< short
    INSEncodingTypeUInt16     = 6, ///< unsigned short
    INSEncodingTypeInt32      = 7, ///< int
    INSEncodingTypeUInt32     = 8, ///< unsigned int
    INSEncodingTypeInt64      = 9, ///< long long
    INSEncodingTypeUInt64     = 10, ///< unsigned long long
    INSEncodingTypeFloat      = 11, ///< float
    INSEncodingTypeDouble     = 12, ///< double
    INSEncodingTypeLongDouble = 13, ///< long double
    INSEncodingTypeObject     = 14, ///< id
    INSEncodingTypeClass      = 15, ///< Class
    INSEncodingTypeSEL        = 16, ///< SEL
    INSEncodingTypeBlock      = 17, ///< block
    INSEncodingTypePointer    = 18, ///< void*
    INSEncodingTypeStruct     = 19, ///< struct
    INSEncodingTypeUnion      = 20, ///< union
    INSEncodingTypeCString    = 21, ///< char*
    INSEncodingTypeCArray     = 22, ///< char[10] (for example)
    
    INSEncodingTypeQualifierMask   = 0xFF00,   ///< mask of qualifier
    INSEncodingTypeQualifierConst  = 1 << 8,  ///< const
    INSEncodingTypeQualifierIn     = 1 << 9,  ///< in
    INSEncodingTypeQualifierInout  = 1 << 10, ///< inout
    INSEncodingTypeQualifierOut    = 1 << 11, ///< out
    INSEncodingTypeQualifierBycopy = 1 << 12, ///< bycopy
    INSEncodingTypeQualifierByref  = 1 << 13, ///< byref
    INSEncodingTypeQualifierOneway = 1 << 14, ///< oneway
    
    INSEncodingTypePropertyMask         = 0xFF0000, ///< mask of property
    INSEncodingTypePropertyReadonly     = 1 << 16, ///< readonly
    INSEncodingTypePropertyCopy         = 1 << 17, ///< copy
    INSEncodingTypePropertyRetain       = 1 << 18, ///< retain
    INSEncodingTypePropertyNonatomic    = 1 << 19, ///< nonatomic
    INSEncodingTypePropertyWeak         = 1 << 20, ///< weak
    INSEncodingTypePropertyCustomGetter = 1 << 21, ///< getter=
    INSEncodingTypePropertyCustomSetter = 1 << 22, ///< setter=
    INSEncodingTypePropertyDynamic      = 1 << 23, ///< @dynamic
};

/**
 Get the type from a Type-Encoding string.
 
 @discussion See also:
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
 https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
 
 @param typeEncoding  A Type-Encoding string.
 @return The encoding type.
 */
INSEncodingType INSEncodingGetType(const char *typeEncoding);


/**
 Instance variable information.
 */
@interface INSClassIvarInfo : NSObject
@property (nonatomic, assign, readonly) Ivar ivar; ///< ivar
@property (nonatomic, strong, readonly) NSString *name; ///< Ivar's name
@property (nonatomic, assign, readonly) ptrdiff_t offset; ///< Ivar's offset
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< Ivar's type encoding
@property (nonatomic, assign, readonly) INSEncodingType type; ///< Ivar's type
- (instancetype)initWithIvar:(Ivar)ivar;
@end

/**
 Method information.
 */
@interface INSClassMethodInfo : NSObject
@property (nonatomic, assign, readonly) Method method; ///< method
@property (nonatomic, strong, readonly) NSString *name; ///< method name
@property (nonatomic, assign, readonly) SEL sel; ///< method's selector
@property (nonatomic, assign, readonly) IMP imp; ///< method's implementation
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< method's parameter and return types
@property (nonatomic, strong, readonly) NSString *returnTypeEncoding; ///< return value's type
@property (nullable, nonatomic, strong, readonly) NSArray<NSString *> *argumentTypeEncodings; ///< array of arguments' type
- (instancetype)initWithMethod:(Method)method;
@end

/**
 Property information.
 */
@interface INSClassPropertyInfo : NSObject
@property (nonatomic, assign, readonly) objc_property_t property; ///< property
@property (nonatomic, strong, readonly) NSString *name; ///< property's name
@property (nonatomic, assign, readonly) INSEncodingType type; ///< property's type
@property (nonatomic, strong, readonly) NSString *typeEncoding; ///< property's encoding value
@property (nonatomic, strong, readonly) NSString *ivarName; ///< property's ivar name
@property (nullable, nonatomic, assign, readonly) Class cls; ///< may be nil
@property (nonatomic, assign, readonly) SEL getter; ///< getter (nonnull)
@property (nonatomic, assign, readonly) SEL setter; ///< setter (nonnull)
- (instancetype)initWithProperty:(objc_property_t)property;
@end

/**
 Class information for a class.
 */
@interface LGFClassInfo : NSObject
@property (nonatomic, assign, readonly) Class cls; ///< class object
@property (nullable, nonatomic, assign, readonly) Class superCls; ///< super class object
@property (nullable, nonatomic, assign, readonly) Class metaCls;  ///< class's meta class object
@property (nonatomic, readonly) BOOL isMeta; ///< whether this class is meta class
@property (nonatomic, strong, readonly) NSString *name; ///< class name
@property (nullable, nonatomic, strong, readonly) LGFClassInfo *superClassInfo; ///< super class's class info
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, INSClassIvarInfo *> *ivarInfos; ///< ivars
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, INSClassMethodInfo *> *methodInfos; ///< methods
@property (nullable, nonatomic, strong, readonly) NSDictionary<NSString *, INSClassPropertyInfo *> *propertyInfos; ///< properties

/**
 If the class is changed (for example: you add a method to this class with
 'class_addMethod()'), you should call this method to refresh the class info cache.
 
 After called this method, you may call 'classInfoWithClass' or 
 'classInfoWithClassName' to get the updated class info.
 */
- (void)setNeedUpdate;

/**
 If this method returns `YES`, you should stop using this instance and call
 `classInfoWithClass` or `classInfoWithClassName` to get the updated class info.
 
 @return Whether this class info need update.
 */
- (BOOL)needUpdate;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param cls A class.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClass:(Class)cls;

/**
 Get the class info of a specified Class.
 
 @discussion This method will cache the class info and super-class info
 at the first access to the Class. This method is thread-safe.
 
 @param className A class name.
 @return A class info, or nil if an error occurs.
 */
+ (nullable instancetype)classInfoWithClassName:(NSString *)className;

@end

NS_ASSUME_NONNULL_END
