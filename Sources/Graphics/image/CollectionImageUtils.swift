import Utils

extension GraphicsContext {
    public static func joinHorizontally(images: [Image]) -> Image? {
        guard !images.isEmpty else { return nil }

        let totalWidth = images.map { $0.width }.reduce(0, +)
        let totalHeight = images.map { $0.height }.max() ?? 0

        guard let ctx = try? Self(width: totalWidth, height: totalHeight) else { return nil }
        var pos = Vec2<Double>(x: 0.0, y: 0.0)

        for image in images {
            ctx.draw(image: image, at: pos)
            pos = pos + Vec2(x: Double(image.width), y: 0.0)
        }

        return try? ctx.makeImage()
    }
}
