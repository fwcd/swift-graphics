import Cairo
import Foundation
import Logging
import Utils

fileprivate let log = Logger(label: "Graphics.Image")

/**
 * An image that internally wraps a Cairo surface.
 */
public struct Image {
    let surface: Surface.Image

    public var width: Int { return surface.width }
    public var height: Int { return surface.height }
    public var size: Vec2<Int> { return Vec2(x: width, y: height) }

    // Source: https://www.cairographics.org/manual/cairo-Image-Surfaces.html#cairo-format-t
    private var bytesPerPixel: Int? {
        switch surface.format {
            case .argb32?: return 4
            case .rgb24?: return 4
            case .a8?: return 1
            case .rgb16565?: return 2
            default: return nil
        }
    }

    init(from surface: Surface.Image) {
        self.surface = surface
    }

    public init(width: Int, height: Int) throws {
        self.init(from: try Surface.Image(format: .argb32, width: width, height: height))
    }

    public init(fromSize size: Vec2<Int>) throws {
        try self.init(width: size.x, height: size.y)
    }

    public subscript(_ y: Int, _ x: Int) -> Color {
        get {
            var pixel: Color? = nil
            surface.withUnsafeMutableBytes { ptr in
                let i: Int = (y * surface.stride) + (x * bytesPerPixel!)
                let colorPtr = UnsafeMutableRawPointer(ptr + i)
                pixel = readColorFrom(pixel: colorPtr)
            }

            return pixel ?? Colors.transparent
        }
        set(newColor) {
            surface.withUnsafeMutableBytes { ptr in
                let i: Int = (y * surface.stride) + (x * bytesPerPixel!)
                let colorPtr = UnsafeMutableRawPointer(ptr + i)
                store(color: newColor, inPixel: colorPtr)
            }
        }
    }

    /** Converts a color to the image's native representation. */
    private func store(color: Color, inPixel ptr: UnsafeMutableRawPointer) {
        switch surface.format {
            case .argb32?:
                ptr.storeBytes(of: color.argb, as: UInt32.self)
            case .rgb24?:
                ptr.storeBytes(of: color.rgb, as: UInt32.self)
            default:
                log.warning("Could not store color \(color) in an image with the format \(surface.format.map { "\($0)" } ?? "nil")")
        }
    }

    /** Convert's a color in the image's native representation to a color. */
    private func readColorFrom(pixel ptr: UnsafeMutableRawPointer) -> Color? {
        switch surface.format {
            case .argb32?:
                return Color(argb: ptr.load(as: UInt32.self))
            case .rgb24?:
                return Color(rgb: ptr.load(as: UInt32.self))
            default:
                log.warning("Color not read color from an image with the format \(surface.format.map { "\($0)" } ?? "nil")")
                return nil
        }
    }
}
