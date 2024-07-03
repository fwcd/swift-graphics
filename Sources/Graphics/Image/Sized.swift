import Utils

public protocol Sized {
    var width: Int { get }
    var height: Int { get }
}

public extension Sized {
    var size: Vec2<Int> { return Vec2(x: width, y: height) }
}
