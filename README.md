# GfycatSwift
A Gfycat API Client written in Swift 3.0

[![CI Status](http://img.shields.io/travis/geek/GfycatSwift.svg?style=flat)](https://travis-ci.org/geek1706/GfycatSwift)
[![Version](https://img.shields.io/cocoapods/v/GfycatSwift.svg?style=flat)](http://cocoapods.org/pods/GfycatSwift)
[![License](https://img.shields.io/cocoapods/l/GfycatSwift.svg?style=flat)](http://cocoapods.org/pods/GfycatSwift)
[![Platform](https://img.shields.io/cocoapods/p/GfycatSwift.svg?style=flat)](http://cocoapods.org/pods/GfycatSwift)

## Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift 3.0+

## Installation

### Cocoapods
GfycatSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:


```ruby
platform :ios, '8.0'
pod 'GfycatSwift'
```

### Carthage

```ruby
github "geek1706/GfycatSwift" 
```

## Usage 

```swift
// Get trending gifs
Gfycat.trending { (results, error) in
// Do something with gifs
}

// Get trending gifs with a tag name
Gfycat.trending("funny") { (results, error) in
// Do something with gifs
}

// Get trending tags
Gfycat.trendingTags { (results, error) in
// Do something with tags
}
// Get trending tags with pre-populeted gifs
Gfycat.trendingTagsPopulated { (results, error) in
// Do something with gifs
}

// Search
Gfycat.search("funny") { (results, error) in
// Do something with gifs
}
```

## Author

[Trung Nguyen](twitter.com/geek1706)

## License

GfycatSwift is available under the MIT license. See the LICENSE file for more info.
