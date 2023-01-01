#if canImport(CoreGraphics) && canImport(ImageIO)
import CoreGraphics
import ImageIO
import Foundation

public struct CoreGraphicsImage: Image {
    public let cgImage: CGImage

    public var width: Int { cgImage.width }
    public var height: Int { cgImage.height }

    public init(cgImage: CGImage) {
        self.cgImage = cgImage
    }

    public init(pngData: Data) throws {
        guard let dataProvider = CGDataProvider(data: pngData as CFData) else {
            throw ImageError.couldNotCreateDataProvider
        }
        guard let cgImage = CGImage(
            pngDataProviderSource: dataProvider,
            decode: nil,
            shouldInterpolate: false,
            intent: .defaultIntent
        ) else {
            throw ImageError.couldNotReadImage
        }
        self.init(cgImage: cgImage)
    }

    public func pngEncoded() throws -> Data {
        guard let data = CFDataCreateMutable(nil, 0),
              let dest = CGImageDestinationCreateWithData(data, kUTTypePNG, 1, nil) else {
            throw ImageError.couldNotCreatePngBuffer
        }
        CGImageDestinationAddImage(dest, cgImage, nil)
        guard CGImageDestinationFinalize(dest) else {
            throw ImageError.couldNotWritePng
        }
        return data as Data
    }
}
#endif
