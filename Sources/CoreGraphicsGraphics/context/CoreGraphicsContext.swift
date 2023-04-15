#if canImport(CoreGraphics) && canImport(CoreText)
import CoreGraphics
import CoreText
import Foundation
import Graphics
import Utils

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif


private extension PixelFormat {

    var colorSpace: CGColorSpace {
        switch self {
            case .rgba32:
                return CGColorSpaceCreateDeviceRGB()
            case .g8:
                return CGColorSpaceCreateDeviceGray()
        }
    }

    var bytesPerPixel: Int {
        switch self {
            case .rgba32:
                return 4
            case .g8:
                return 1
        }
    }

    var bitmapInfo: UInt32 {
        switch self {
            case .rgba32:
                return CGBitmapInfo.byteOrder32Big.rawValue |
                    CGImageAlphaInfo.premultipliedLast.rawValue &
                    CGBitmapInfo.alphaInfoMask.rawValue
            case .g8:
                return 0
        }
    }
}

/**
 * A graphics context that uses CoreGraphics for its drawing primitives.
 */
public final class CoreGraphicsContext: GraphicsContext {
    private let cgContext: CGContext
    private var dataPointer: UnsafeMutableBufferPointer<UInt8>?

    deinit {
        dataPointer?.deallocate()
    }

    public init(cgContext: CGContext) {
        self.cgContext = cgContext
        dataPointer = nil
    }

    public init(width: Int, height: Int, format: PixelFormat) throws {
        let dataPointer = UnsafeMutableBufferPointer<UInt8>.allocate(capacity: width * height * format.bytesPerPixel)
        dataPointer.initialize(repeating: 0)
        guard let cgContext = CGContext(
            data: dataPointer.baseAddress,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * format.bytesPerPixel,
            space: format.colorSpace,
            bitmapInfo: format.bitmapInfo,
            releaseCallback: nil,
            releaseInfo: nil
        ) else {
            throw GraphicsContextError.couldNotCreate(width: width, height: height)
        }

        self.dataPointer = dataPointer
        self.cgContext = cgContext
    }

    public func makeImage() throws -> CoreGraphicsImage {
        guard let image = cgContext.makeImage() else { throw GraphicsContextError.couldNotMakeImage }
        return CoreGraphicsImage(cgImage: image)
    }

    public func flush() {
        cgContext.flush()
    }

    public func save() {
        cgContext.saveGState()
    }

    public func restore() {
        cgContext.restoreGState()
    }

    public func translate(by offset: Vec2<Double>) {
        cgContext.translateBy(x: offset.x, y: offset.y)
    }

    public func rotate(by angle: Double) {
        cgContext.rotate(by: angle)
    }

    private func setColor(_ color: Color, isFilled: Bool) {
        if isFilled {
            cgContext.setFillColor(color.asCGColor)
        } else {
            cgContext.setStrokeColor(color.asCGColor)
        }
    }

    private func cgPoint(for vec2: Vec2<Double>) -> CGPoint {
        .init(x: vec2.x, y: Double(cgContext.height) - vec2.y)
    }

    private func cgPoint(for vec2: Vec2<Int>) -> CGPoint {
        .init(x: vec2.x, y: cgContext.height - vec2.y)
    }

    private func cgSize(for vec2: Vec2<Double>) -> CGSize {
        .init(width: vec2.x, height: vec2.y)
    }

    private func cgSize(for vec2: Vec2<Int>) -> CGSize {
        .init(width: vec2.x, height: vec2.y)
    }

    private func cgRect(for rect: Rectangle<Double>) -> CGRect {
        .init(origin: cgPoint(for: rect.bottomLeft), size: cgSize(for: rect.size))
    }

    private func withPath(color: Color, isFilled: Bool, action: () -> Void) {
        setColor(color, isFilled: isFilled)
        cgContext.beginPath()
        action()
        if isFilled {
            cgContext.fillPath()
        } else {
            cgContext.strokePath()
        }
    }

    public func draw(line: LineSegment<Double>) {
        withPath(color: line.color, isFilled: false) {
            cgContext.move(to: cgPoint(for: line.start))
            cgContext.addLine(to: cgPoint(for: line.end))
        }
    }

    public func draw(rect: Rectangle<Double>) {
        withPath(color: rect.color, isFilled: rect.isFilled) {
            cgContext.addRect(cgRect(for: rect))
        }
    }

    public func draw(polygon: Graphics.Polygon<Double>) {
        guard polygon.paths.count > 0 else {
            return
        }
        withPath(color: polygon.color, isFilled: polygon.isFilled) {
            for path in polygon.paths {
                cgContext.addLines(between: path.map { cgPoint(for: $0) })
            }
        }
    }

    public func draw(ellipse: Ellipse<Double>) {
        withPath(color: ellipse.color, isFilled: ellipse.isFilled) {
            cgContext.addEllipse(in: cgRect(for: ellipse.boundingRectangle))
        }
    }

    public func draw(image: CoreGraphicsImage, at position: Vec2<Double>, withSize size: Vec2<Int>, rotation: Double?) {
        cgContext.draw(image.cgImage, in: CGRect(origin: cgPoint(for: position), size: cgSize(for: size)))
    }

    public func draw(svg: NoImage, at position: Vec2<Double>, withSize size: Vec2<Int>, rotation: Double?) {
        // Not supported yet
    }

    public func draw(text: Text) {
        let font = CTFontCreateWithName("Helvetica" as CFString, text.fontSize, nil)
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: text.color.asCGColor]
        let attributedString = NSAttributedString(string: text.value, attributes: attributes)
        let line = CTLineCreateWithAttributedString(attributedString)
        let bounds = CTLineGetImageBounds(line, cgContext)
        let offset = cgPoint(for: text.position)
        cgContext.textPosition = CGPoint(x: bounds.minX + offset.x, y: bounds.minY + offset.y)
        CTLineDraw(line, cgContext)
    }

    public func withUnsafeMutableBytes(_ body: (UnsafeMutableBufferPointer<UInt8>) throws -> Void) throws {
        guard let dataPointer = dataPointer else {
            throw GraphicsContextError.noRawBuffer
        }
        try body(dataPointer)
    }
}

extension Color {
    var asCGColor: CGColor {
        CGColor(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(alpha) / 255.0
        )
    }
}
#endif
