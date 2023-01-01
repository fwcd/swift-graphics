/**
 * An uninhabeted type (similar to ``Never``) that conforms to ``Image``.
 */
public enum NoImage: Image {
    public var width: Int { fatalError("Unreachable") }
    public var height: Int { fatalError("Unreachable") }
}
