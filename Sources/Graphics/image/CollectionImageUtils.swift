import Utils

extension Array where Element == CairoContext.Image {
    public func horizontallyImageJoined() -> Element? {
        guard !isEmpty else { return nil }

        let totalWidth = map { $0.width }.reduce(0, +)
        let totalHeight = map { $0.height }.max() ?? 0

        guard let ctx = try? CairoContext(width: totalWidth, height: totalHeight) else { return nil }
        var pos = Vec2<Double>(x: 0.0, y: 0.0)

        for image in self {
            ctx.draw(image, at: pos)
            pos = pos + Vec2(x: Double(image.width), y: 0.0)
        }

        return ctx.makeImage()
    }
}
