![BubbleBlurView](https://raw.githubusercontent.com/wfltaylor/BubbleBlurView/master/Logo.png)

[![Version](https://img.shields.io/cocoapods/v/BubbleBlurView.svg?style=flat)](https://cocoapods.org/pods/BubbleBlurView)
[![License](https://img.shields.io/cocoapods/l/BubbleBlurView.svg?style=flat)](https://cocoapods.org/pods/BubbleBlurView)
[![Platform](https://img.shields.io/cocoapods/p/BubbleBlurView.svg?style=flat)](https://cocoapods.org/pods/BubbleBlurView)

BubbleBlurView is a UIView which has a blurred bubble effect that somewhat resembles the Apple Card.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Getting Started

Simply create a view and call startBubbles when you are ready to start the animation.

```swift
let bubbleView = BubbleBlurView()

bubbleView.startBubbles()
```

See example for more details.

## Installation

BubbleBlurView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BubbleBlurView'
```

## Pitfalls

* Low Performance (will be soon updated to use SpriteKit to remedy)
* Repetitive Animation (will soon be updated with more randomness)

## Author

William Taylor

## License

BubbleBlurView is available under the MIT license. See the LICENSE file for more info.
