import Utils

/**
 * A mutable image that provides direct access to its pixels.
 */
public protocol BufferedImage: Image {
    init(width: Int, height: Int, format: PixelFormat) throws

    subscript(_ y: Int, _ x: Int) -> Color { get set }
}

public extension BufferedImage {
    init(width: Int, height: Int) throws {
        try self.init(width: width, height: height, format: .rgba32)
    }


    init(size: Vec2<Int>) throws {
        try self.init(size: size, format: .rgba32)
    }

    init(size: Vec2<Int>, format: PixelFormat) throws {
        try self.init(width: size.x, height: size.y, format: format)
    }
}
