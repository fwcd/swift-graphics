public enum GraphicsContextError: Error {
    case couldNotCreate(width: Int, height: Int)
    case couldNotMakeImage
    case noRawBuffer
}
