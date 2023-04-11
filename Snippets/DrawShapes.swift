import PlatformGraphics
import Foundation
import Utils

func generatePngImage() throws -> Data {
    // Create a new image and a graphics context
    let ctx = try PlatformGraphicsContext(width: 300, height: 300)

    // Draw some shapes
    ctx.draw(line: LineSegment(fromX: 20, y: 20, toX: 50, y: 30))
    ctx.draw(rect: Rectangle(fromX: 80, y: 90, width: 10, height: 40, color: .yellow))
    ctx.draw(text: Text("Test", at: Vec2(x: 0, y: 15)))
    ctx.draw(ellipse: Ellipse(centerX: 150, y: 80, radius: 40))
    ctx.draw(polygon: Polygon(points: [
        Vec2(x: 250.0, y: 120.0),
        Vec2(x: 280.0, y: 250.0),
        Vec2(x: 200.0, y: 170.0),
        Vec2(x: 300.0, y: 170.0),
        Vec2(x: 220.0, y: 250.0)
    ], isFilled: true))
    ctx.draw(polygon: Polygon(paths: [
        [
            Vec2(x: 20.0, y: 150.0),
            Vec2(x: 120.0, y: 150.0),
            Vec2(x: 120.0, y: 250.0),
            Vec2(x: 20.0, y: 250.0)
        ],
        [
            Vec2(x: 70.0, y: 170.0),
            Vec2(x: 10.0, y: 220.0),
            Vec2(x: 130.0, y: 220.0),
        ]
    ], isFilled: true))

    // Encode the image to a byte buffer
    let image = try ctx.makeImage()
    let data = try image.pngEncoded()

    return data
}

guard CommandLine.argc > 1 else {
    print("Usage: \(CommandLine.arguments[0]) [output path]")
    exit(1)
}

// Parse paths from arguments
let path = CommandLine.arguments[1]
let url = URL(fileURLWithPath: path)
let parentUrl = url.deletingLastPathComponent()

// Generate image and write PNG to file
try FileManager.default.createDirectory(at: parentUrl, withIntermediateDirectories: true)
try generatePngImage().write(to: url)
