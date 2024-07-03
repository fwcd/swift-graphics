#if canImport(CoreGraphics) && canImport(CoreText)
import Graphics

public typealias DefaultGraphicsContext = CoreGraphicsContext
public typealias DefaultImage = DefaultGraphicsContext.Image
#endif
