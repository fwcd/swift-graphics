#if canImport(CoreGraphics)

public typealias DefaultGraphicsContext = CoreGraphicsContext
public typealias DefaultImage = DefaultGraphicsContext.Image

#elseif canImport(Cairo)

public typealias DefaultGraphicsContext = CairoContext
public typealias DefaultImage = DefaultGraphicsContext.Image

#else
#error("No default graphics context available for this platform!")
#endif
