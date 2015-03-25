//
//  WMLSwizzler.h
//  Pods
//
//  Created by Sash Zats on 3/25/15.
//
//

#import <Foundation/Foundation.h>


@interface WMLSwizzler : NSObject

/**
 *  Replaces specified instance method with specified block.
 *
 *  @discussion If you're using this to <i>add</i> functionality on top of the 
 *  original method, or to conditionally call the original method, you can store
 *  returned implementation in a @c __block variable and call it from you 
 *  implementation inside the @c block.
 *
 *  @param selector Instance method to replace.
 *  @param class    Target class to replace method in.
 *  @param block    New method implementation. Block signature mimicks the 
 *  original method, but it inserts @c self as a first parameter, e.g. if you're 
 *  swizzling -[NSArray objectAtIndex:], you block signature should look like
 *  id(^)(NSArray self, NSInteger index)
 *
 *  @return Implementation of the replaced instance method before swizzling
 */
+ (IMP)replaceInstanceMethod:(SEL)selector inClass:(Class)class withBlock:(dispatch_block_t)block;

/**
 *  Replaces specified instance method with specified implementation.
 *
 *  @discussion This might be usefull to restore previously swizzled method with
 *  original implementation.
 *
 *  @param selector         Instance method to replace.
 *  @param class            Target class to replace method in.
 *  @param implementation   New method implementation.
 *
 *  @return Implementation of the replaced instance method before swizzling
 */
+ (IMP)replaceInstanceMethod:(SEL)selector inClass:(Class)class withImplementation:(IMP)implementation;

/**
 *  Replaces specified class method with specified block.
 *
 *  @discussion If you're using this to <i>add</i> functionality on top of the
 *  original method, or to conditionally call the original method, you can store
 *  returned implementation in a @c __block variable and call it from you
 *  implementation inside the @c block.
 *
 *  @param selector Class method to replace.
 *  @param class    Target class to replace method in.
 *  @param block    New method implementation. Block signature mimicks the
 *  original method, but it inserts @c self as a first parameter, e.g. if you're
 *  swizzling -[NSArray objectAtIndex:], you block signature should look like
 *  id(^)(NSArray self, NSInteger index)
 *
 *  @return Implementation of the replaced class method before swizzling
 */
+ (IMP)replaceClassMethod:(SEL)selector inClass:(Class)class withBlock:(dispatch_block_t)block;

/**
 *  Replaces specified class method with specified implementation.
 *
 *  @discussion This might be usefull to restore previously swizzled method with
 *  original implementation.
 *
 *  @param selector         Class method to replace.
 *  @param class            Target class to replace method in.
 *  @param implementation   New method implementation.
 *
 *  @return Implementation of the replaced class method before swizzling
 */
+ (IMP)replaceClassMethod:(SEL)selector inClass:(Class)class withImplementation:(IMP)implementation;

@end


@interface NSObject (Swizzler)

/**
 *  Replaces specified instance method with specified block.
 *
 *  @discussion If you're using this to <i>add</i> functionality on top of the
 *  original method, or to conditionally call the original method, you can store
 *  returned implementation in a @c __block variable and call it from you
 *  implementation inside the @c block.
 *
 *  @param selector Instance method to replace.
 *  @param class    Target class to replace method in.
 *  @param block    New method implementation. Block signature mimicks the
 *  original method, but it inserts @c self as a first parameter, e.g. if you're
 *  swizzling -[NSArray objectAtIndex:], you block signature should look like
 *  id(^)(NSArray self, NSInteger index)
 *
 *  @return Implementation of the replaced instance method before swizzling
 */
+ (IMP)wml_replaceInstanceMethod:(SEL)originalSelector withBlock:(id)block;

/**
 *  Replaces specified class method with specified block.
 *
 *  @discussion If you're using this to <i>add</i> functionality on top of the
 *  original method, or to conditionally call the original method, you can store
 *  returned implementation in a @c __block variable and call it from you
 *  implementation inside the @c block.
 *
 *  @param selector Class method to replace.
 *  @param block    New method implementation. Block signature mimicks the
 *  original method, but it inserts @c self as a first parameter, e.g. if you're
 *  swizzling -[NSArray objectAtIndex:], you block signature should look like
 *  id(^)(NSArray self, NSInteger index)
 *
 *  @return Implementation of the replaced class method before swizzling
 */
+ (IMP)wml_replaceClassMethod:(SEL)originalSelector withBlock:(id)block;

@end
