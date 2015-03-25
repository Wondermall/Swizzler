# Swizzler

[![Build Status](https://travis-ci.org/Wondermall/Swizzler.svg?branch=master&style=flat)](https://travis-ci.org/Wondermall/Swizzler)
[![Version](https://img.shields.io/cocoapods/v/Swizzler.svg?style=flat)](http://cocoapods.org/pods/Swizzler)
[![License](https://img.shields.io/cocoapods/l/Swizzler.svg?style=flat)](http://cocoapods.org/pods/Swizzler)
[![Platform](https://img.shields.io/cocoapods/p/Swizzler.svg?style=flat)](http://cocoapods.org/pods/Swizzler)

## Why

Swizzling is all fun and giggles until you screw it up. Please refer to these articles for more info:

* [A Story About Swizzling "the Right Way™" and Touch Forwarding](http://petersteinberger.com/blog/2014/a-story-about-swizzling-the-right-way-and-touch-forwarding/)
* [The Right Way to Swizzle in Objective-C](http://blog.newrelic.com/2014/04/16/right-way-to-swizzle/)

## How to use?

```objectivec
[NSArray wml_replaceInstanceMethod:@selector(setObject:atIndex:) withBlock:^(NSArray *self, id object, NSInteger index){
	// your logic...
}];
```

Or if you want to call the original method from your new implementation

```objectivec
__block IMP setObjectAtIndex = [NSArray wml_replaceInstanceMethod:@selector(setObject:atIndex:) withBlock:^(NSArray *self, id object, NSInteger index){
    if (index % 2 == 0) {
        setObjectAtIndex(self, @selector(setObject:atIndex:), object, index);
    } else {
        setObjectAtIndex(self, @selector(setObject:atIndex:), object, index + 1);
    }
}];
```

## Installation

Swizzler is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Swizzler"
```

## Author

Sash Zats, sash@zats.io

## License

Swizzler is available under the MIT license. See the LICENSE file for more info.
