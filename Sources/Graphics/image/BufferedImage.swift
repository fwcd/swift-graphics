/**
 * A mutable image that provides direct access to its pixels.
 */
public protocol BufferedImage: Image {
    init(width: Int, height: Int) throws

    subscript(_ y: Int, _ x: Int) -> Color { get set }
}
