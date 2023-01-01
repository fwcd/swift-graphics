import Utils

extension HTTPRequest {
    public func fetchPNGAsync() -> Promise<CairoImage, Error> {
        runAsync().mapCatching { try CairoImage(pngData: $0) }
    }
}
