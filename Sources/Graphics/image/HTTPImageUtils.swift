import Utils

extension HTTPRequest {
    public func fetchPNGAsync() -> Promise<Image, Error> {
        runAsync().mapCatching { try Image(fromPng: $0) }
    }
}
