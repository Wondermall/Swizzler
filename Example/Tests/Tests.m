//
//  SwizzlerTests.m
//  SwizzlerTests
//
//  Created by Sash Zats on 03/25/2015.
//  Copyright (c) 2014 Sash Zats. All rights reserved.
//

#import "WMLSwizzler.h"


@interface Dog : NSObject
+ (instancetype)dog;
@property (nonatomic, copy, readonly) NSString *voice;
- (BOOL)eatFood:(NSUInteger)food;
@end

@implementation Dog
+ (instancetype)dog {
    return [[self alloc] init];
}
- (NSString *)voice {
    return @"Woof! Woof!";
}
- (BOOL)eatFood:(NSUInteger)food {
    if (food == 0xbadf00d || food == 0xdeadbeef) {
        return NO;
    }
    return YES;
}
@end


SpecBegin(InitialSpecs)

context(@"Instance method", ^{
    __block Dog *dog;
    beforeEach(^{
        dog = [[Dog alloc] init];
    });
    
    context(@"without parameters", ^{
        it(@"replaces original method", ^{
            IMP originalImp = [Dog wml_replaceInstanceMethod:@selector(voice) withBlock:^NSString *(Dog *dog){
                return @"meow!";
            }];

            expect(dog.voice).to.equal(@"meow!");
            
            // Restoring original method
            [WMLSwizzler replaceInstanceMethod:@selector(voice) inClass:[Dog class] withImplementation:originalImp];
        });
        
        it(@"returns original method", ^{
            __block IMP originalImp = [Dog wml_replaceInstanceMethod:@selector(voice) withBlock:^NSString *(Dog *dog){
                NSString *originalResult = originalImp(self, @selector(voice));
                return [originalResult stringByAppendingString:@" Meow!"];
            }];
            
            expect(dog.voice).to.equal(@"Woof! Woof! Meow!");
            
            // Restoring original method
            [WMLSwizzler replaceInstanceMethod:@selector(voice) inClass:[Dog class] withImplementation:originalImp];
        });
    });
    
    context(@"with one parameters", ^{
        it(@"replaces the origin method", ^{
            IMP originalImp = [Dog wml_replaceInstanceMethod:@selector(eatFood:) withBlock:^BOOL(Dog *dog, NSUInteger food){
                return YES;
            }];
            
            expect([dog eatFood:0xbadf00d]).to.beTruthy();
            expect([dog eatFood:0xdeadbeef]).to.beTruthy();
            
            // Restore original method
            [WMLSwizzler replaceInstanceMethod:@selector(eatFood:) inClass:[Dog class] withImplementation:originalImp];
        });
        
        it(@"returns original method", ^{
            __block IMP originalImp = [Dog wml_replaceInstanceMethod:@selector(eatFood:) withBlock:^BOOL(Dog *dog, NSUInteger food){
                if (food != 0xdeadbeef) {
                    return originalImp(dog, @selector(eatFood:), food);
                }
                return YES;
            }];
            
            expect([dog eatFood:0xbadf00d]).to.beFalsy();
            expect([dog eatFood:0xdeadbeef]).to.beTruthy();
            
            // Restoring original method
            [WMLSwizzler replaceInstanceMethod:@selector(eatFood:) inClass:[Dog class] withImplementation:originalImp];
        });
    });
});

SpecEnd
