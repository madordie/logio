# logio for iOS

A [log.io](http://logio.org/) logger for [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack).

![screenshot.gif](https://github.com/madordie/logio/blob/master/Images/screenshot.gif?raw=true)

[Doc](https://madordie.github.io/post/logio-brief/)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

logio is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'logio', :git => 'https://github.com/madordie/logio.git'
```

## Usage

Assume that the server IP is `10.12.12.10`

```swift
DDLog.add(LogIO.shared)
LogIO.shared.content(host: "10.12.12.10", port: 28777)
```

or

```oc
[DDLog addLogger: LogIO.shared];
[LogIO.shared contentHost:@"10.12.12.10" port:28777];
```

## Author

madordie, e.madordie@gmail.com

## Thx

- [CocoaLumberjack](https://github.com/CocoaLumberjack/CocoaLumberjack)
- [LogIO-CocoaLumberjack](https://github.com/s4nchez/LogIO-CocoaLumberjack)
- [logio.org](http://logio.org/)
- [blacklabelops-legacy/logio](https://github.com/blacklabelops-legacy/logio)

## License

logio is available under the MIT license. See the LICENSE file for more info.
