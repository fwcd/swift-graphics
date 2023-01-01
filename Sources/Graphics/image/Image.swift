import Utils

/**
 * A mutable image.
 */
public protocol Image {
    var width: Int { get }
    var height: Int { get }
}

public extension Image {
    var size: Vec2<Int> { return Vec2(x: width, y: height) }
}
