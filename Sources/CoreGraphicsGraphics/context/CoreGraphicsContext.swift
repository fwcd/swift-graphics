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

private let rgbColorSpace = CGColorSpaceCreateDeviceRGB()

/**
 * A graphics context that uses CoreGraphics for its drawing primitives.
 */
public final class CoreGraphicsContext: GraphicsContext {
    private let cgContext: CGContext
    private var dataPointer: UnsafeMutableBufferPointer<UInt32>?

    deinit {
        dataPointer?.deallocate()
    }

    public init(cgContext: CGContext) {
        self.cgContext = cgContext
        dataPointer = nil
    }

    public init(width: Int, height: Int) throws {
        let dataPointer = UnsafeMutableBufferPointer<UInt32>.allocate(capacity: width * height)
        guard let cgContext = CGContext(
            data: dataPointer.baseAddress,
            width: width,
            height: height,
            bitsPerComponent: 8,
            bytesPerRow: width * 4,
            space: rgbColorSpace,
            bitmapInfo: CGBitmapInfo.byteOrder32Big.rawValue | CGImageAlphaInfo.premultipliedLast.rawValue & CGBitmapInfo.alphaInfoMask.rawValue,
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
            cgContext.move(to: CGPoint(line.start))
            cgContext.addLine(to: CGPoint(line.end))
        }
    }

    public func draw(rect: Rectangle<Double>) {
        withPath(color: rect.color, isFilled: rect.isFilled) {
            cgContext.addRect(CGRect(rect))
        }
    }

    public func draw(ellipse: Ellipse<Double>) {
        withPath(color: ellipse.color, isFilled: ellipse.isFilled) {
            cgContext.addEllipse(in: CGRect(ellipse))
        }
    }

    public func draw(image: CoreGraphicsImage, at position: Vec2<Double>, withSize size: Vec2<Int>, rotation: Double?) {
        cgContext.draw(image.cgImage, in: CGRect(origin: CGPoint(position), size: CGSize(size)))
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
        cgContext.textPosition = CGPoint(x: bounds.minX, y: bounds.minY)
        CTLineDraw(line, cgContext)
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

extension CGPoint {
    init(_ vec2: Vec2<Double>) {
        self.init(x: vec2.x, y: vec2.y)
    }
}

extension CGSize {
    init(_ vec2: Vec2<Double>) {
        self.init(width: vec2.x, height: vec2.y)
    }

    init(_ vec2: Vec2<Int>) {
        self.init(width: vec2.x, height: vec2.y)
    }
}

extension CGRect {
    init(_ rect: Rectangle<Double>) {
        self.init(x: rect.topLeft.x, y: rect.topLeft.y, width: rect.width, height: rect.height)
    }

    init(_ ellipse: Ellipse<Double>) {
        self.init(ellipse.boundingRectangle)
    }
}
#endif
