import Foundation
import Utils

/**
 * A mutable image that can be constructed from and converted to PNG.
 */
public protocol Image: Sized {
    init(pngData: Data) throws

    func pngEncoded() throws -> Data
}

public extension Image {
    init(pngFileUrl url: URL) throws {
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: url.path) else { throw DiskFileError.fileNotFound(url) }

        if let data = fileManager.contents(atPath: url.path) {
            try self.init(pngData: data)
        } else {
            throw DiskFileError.noData("Image at \(url) contained no data")
        }
    }

    init(pngFilePath: String) throws {
        try self.init(pngFileUrl: URL(fileURLWithPath: pngFilePath))
    }
}
