import Foundation

/**
 * An uninhabited type (similar to ``Never``) that conforms to ``Image``.
 */
public enum NoImage: Image {
    public var width: Int { fatalError("Unreachable") }
    public var height: Int { fatalError("Unreachable") }

    public init(pngData: Data) throws {
        fatalError("Cannot create NoImage")
    }

    public func pngEncoded() throws -> Data {
        fatalError("Unreachable")
    }
}
