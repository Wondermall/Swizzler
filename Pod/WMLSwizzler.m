//
//  WMLSwizzler.m
//  Pods
//
//  Created by Sash Zats on 3/25/15.
//
//

#import "WMLSwizzler.h"
#import <objc/runtime.h>


@implementation WMLSwizzler

+ (IMP)replaceInstanceMethod:(SEL)selector inClass:(Class)class withBlock:(dispatch_block_t)block {
    return [self replaceInstanceMethod:selector inClass:class withImplementation:imp_implementationWithBlock(block)];
}

+ (IMP)replaceInstanceMethod:(SEL)selector inClass:(Class)class withImplementation:(IMP)implementation {
    return [self _replaceMethod:selector inClass:class withImplementation:implementation];
}

+ (IMP)replaceClassMethod:(SEL)selector inClass:(Class)class withBlock:(dispatch_block_t)block {
    return [self replaceClassMethod:selector inClass:class withImplementation:imp_implementationWithBlock(block)];
}

+ (IMP)replaceClassMethod:(SEL)selector inClass:(Class)class withImplementation:(IMP)implementation {
    return [self _replaceMethod:selector inClass:object_getClass(class) withImplementation:implementation];
}

#pragma mark - Private

+ (IMP)_replaceMethod:(SEL)originalSelector inClass:(Class)cls withImplementation:(IMP)newIMP {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    IMP originalIMP = method_getImplementation(originalMethod);
    const char *originalMethodEncoding = method_getTypeEncoding(originalMethod);
    class_replaceMethod(cls, originalSelector, newIMP, originalMethodEncoding);
    return originalIMP;
}

@end


@implementation NSObject (Swizzler)

#pragma mark - Public

+ (IMP)wml_replaceInstanceMethod:(SEL)originalSelector withBlock:(id)block {
    return [WMLSwizzler replaceInstanceMethod:originalSelector inClass:self withBlock:block];
}

+ (IMP)wml_replaceClassMethod:(SEL)originalSelector withBlock:(id)block {
    return [WMLSwizzler replaceClassMethod:originalSelector inClass:self withBlock:block];
}

@end

