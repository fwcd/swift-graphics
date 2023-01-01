#if canImport(CairoGraphics)

@_exported import CairoGraphics
public typealias PlatformGraphicsContext = CairoContext

#elseif canImport(CoreGraphicsGraphics)

@_exported import CoreGraphicsGraphics
public typealias PlatformGraphicsContext = CoreGraphicsContext

#else
#error("No platform graphics available!")
#endif

public typealias PlatformImage = PlatformGraphicsContext.Image
