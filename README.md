# Swizzler

[![Build Status](https://travis-ci.org/Wondermall/Swizzler.svg?branch=master&style=flat-square)](https://travis-ci.org/Wondermall/Swizzler)
[![Version](https://img.shields.io/cocoapods/v/Swizzler.svg?style=flat-square)](http://cocoapods.org/pods/Swizzler)
[![License](https://img.shields.io/cocoapods/l/Swizzler.svg?style=flat-square)](http://cocoapods.org/pods/Swizzler)
[![Platform](https://img.shields.io/cocoapods/p/Swizzler.svg?style=flat-square)](http://cocoapods.org/pods/Swizzler)
[![Twitter: @zats](https://img.shields.io/badge/contact-@zats-blue.svg?style=flat-square)](https://twitter.com/zats)

## Usage

Vanilla swizzling:

```objectivec
SEL setObjectSelector = @selector(setObject:atIndex:);
[NSArray wml_replaceInstanceMethod:setObjectSelector withBlock:^(NSArray *self, id object, NSInteger index){
	// your logic...
}];
```

Or if you want to call the original method from your new implementation:

```objectivec
__block IMP originalIMP = [NSArray wml_replaceInstanceMethod:setObjectSelector withBlock:^(NSArray *self, id object, NSInteger index){
	// hopefully this not what you're doing
	originalIMP(self, setObjectSelector, object, self.count - index - 1);
}];
```

Restore the original implementation, once you're done with swizzling:

```objectivec
[WMLSwizzler replaceClassMethod:setObjectSelector inClass:[NSArray class] withImplementation:originalIMP];
```


## Why

### TL;DR

If you're swizzling "the old" way, you might run into issues since you new selector `xyz_swizzledMethod` might be passed when you call the original implementation. Besides, the block-based API is nicer and more concise.

### Details

Swizzling is all fun and giggles until you screw it up. Please refer to these articles for more info:

* [A Story About Swizzling "the Right Way™" and Touch Forwarding](http://petersteinberger.com/blog/2014/a-story-about-swizzling-the-right-way-and-touch-forwarding/)
* [The Right Way to Swizzle in Objective-C](http://blog.newrelic.com/2014/04/16/right-way-to-swizzle/)



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
