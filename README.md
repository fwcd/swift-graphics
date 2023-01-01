# Swift Graphics

[![Build](https://github.com/fwcd/swift-graphics/actions/workflows/build.yml/badge.svg)](https://github.com/fwcd/swift-graphics/actions/workflows/build.yml)

Cross-platform 2D drawing library for Swift based on Cairo.

## Example
```swift
// Create a new image and a graphics context
let image = try DefaultImage(width: 300, height: 300)
let ctx = DefaultGraphicsContext(fromImage: image)

// Draw some shapes
ctx.draw(line: LineSegment(fromX: 20, y: 20, toX: 50, y: 30))
ctx.draw(rect: Rectangle(fromX: 80, y: 90, width: 10, height: 40, color: Colors.yellow))
ctx.draw(text: Text("Test", at: Vec2(x: 0, y: 15)))
ctx.draw(ellipse: Ellipse(centerX: 150, y: 80, radius: 40))

// Encode the image to a byte buffer
let data = try image.pngEncoded()
```

## System Dependencies
* Swift 5.2+

### Linux
* `sudo apt-get install libcairo2-dev`

### macOS
* `brew install cairo`

## Building
`swift build`

## Testing
`swift test`
