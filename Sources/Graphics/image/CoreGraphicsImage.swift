#if canImport(CoreGraphics)
import CoreGraphics

public struct CoreGraphicsImage: Image {
    public let cgImage: CGImage

    public var width: Int { cgImage.width }
    public var height: Int { cgImage.height }

    public init(cgImage: CGImage) {
        self.cgImage = cgImage
    }
}
#endif
