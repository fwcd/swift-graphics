#if canImport(Cairo)
import Cairo
import Utils

/**
 * A vector graphic that internally wraps a Cairo surface.
 */
public struct SVG: Image {
    let surface: Surface.SVG
    let width: Int
    let height: Int

    public var size: Vec2<Int> { return Vec2(x: width, y: height) }

    init(rawSurface: Surface.SVG, width: Int, height: Int) {
        self.surface = surface
        self.width = width
        self.height = height
    }

    public init(svgFilePath filePath: String, width: Int, height: Int) throws {
        self.init(from: try Surface.SVG(filename: filePath, width: Double(width), height: Double(height)), width: width, height: height)
    }
}
#endif
