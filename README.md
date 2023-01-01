# Swift Graphics

[![Build](https://github.com/fwcd/swift-graphics/actions/workflows/build.yml/badge.svg)](https://github.com/fwcd/swift-graphics/actions/workflows/build.yml)

2D drawing library for Swift with multiple backends, currently including

- Cairo (cross-platform)
- Core Graphics (Apple platforms)

## Example

```swift
import PlatformGraphics
import Utils

// Create a new image and a graphics context
let ctx = try PlatformGraphicsContext(width: 300, height: 300)

// Draw some shapes
ctx.draw(line: LineSegment(fromX: 20, y: 20, toX: 50, y: 30))
ctx.draw(rect: Rectangle(fromX: 80, y: 90, width: 10, height: 40, color: Colors.yellow))
ctx.draw(text: Text("Test", at: Vec2(x: 0, y: 15)))
ctx.draw(ellipse: Ellipse(centerX: 150, y: 80, radius: 40))

// Encode the image to a byte buffer
let image = try ctx.makeImage()
let data = try image.pngEncoded()
```

The full example can be found in [`Snippets/DrawShapes.swift`](Snippets/DrawShapes.swift). To run it, invoke

```sh
swift run DrawShapes Output/shapes.png
```

The resulting PNG will be written to `Output/shapes.png`.

## System Dependencies

* Swift 5.7+
* For the Cairo backend (required on Linux, optional on macOS):
    * Debian: `apt-get install libcairo2-dev`
    * macOS: `brew install cairo`

## Building

```sh
swift build
```

## Testing

```sh
swift test
```
