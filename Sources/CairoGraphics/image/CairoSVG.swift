import Cairo
import Graphics
import Utils

/**
 * A vector graphic that internally wraps a Cairo surface.
 */
public struct SVG: Sized {
    let surface: Surface.SVG
    public let width: Int
    public let height: Int

    public var size: Vec2<Int> { return Vec2(x: width, y: height) }

    init(surface: Surface.SVG, width: Int, height: Int) {
        self.surface = surface
        self.width = width
        self.height = height
    }

    public init(svgFilePath filePath: String, width: Int, height: Int) throws {
        self.init(surface: try Surface.SVG(filename: filePath, width: Double(width), height: Double(height)), width: width, height: height)
    }
}
