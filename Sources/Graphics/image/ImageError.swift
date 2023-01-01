public enum ImageError: Error {
    case couldNotCreate(width: Int, height: Int)
    case couldNotCreateDataProvider
    case couldNotReadImage
    case couldNotCreatePngBuffer
    case couldNotWritePng
}
