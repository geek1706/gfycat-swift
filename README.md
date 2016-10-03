# GfycatSwift
A [Gfycat](https://gfycat.com/) API Client written in Swift 3.0

[![CI Status](https://travis-ci.org/geek1706/gfycat-swift.svg?branch=master)](https://travis-ci.org/geek1706/gfycat-swift)
[![Version](https://img.shields.io/cocoapods/v/GfycatSwift.svg?style=flat)](http://cocoapods.org/pods/GfycatSwift)
[![License](https://img.shields.io/cocoapods/l/GfycatSwift.svg?style=flat)](http://cocoapods.org/pods/GfycatSwift)
[![Platform](https://img.shields.io/cocoapods/p/GfycatSwift.svg?style=flat)](http://cocoapods.org/pods/GfycatSwift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

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

// Get trending tags with pre-populated gifs
Gfycat.trendingTagsPopulated { (results, error) in
  // Do something with gifs
}

// Search
Gfycat.search("funny") { (results, error) in
  // Do something with gifs
}
```

## Author

Trung Nguyen, trung1706@gmail.com

## License

GfycatSwift is available under the MIT license. See the LICENSE file for more info.
