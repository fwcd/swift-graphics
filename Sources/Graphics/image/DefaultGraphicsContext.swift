#if canImport(CoreGraphics)

public typealias DefaultGraphicsContext = CoreGraphicsContext

#elseif canImport(Cairo)

public typealias DefaultGraphicsContext = CairoContext

#else
#error("No default graphics context available for this platform!")
#endif
