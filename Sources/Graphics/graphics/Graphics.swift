import Utils

public protocol Graphics {
    func flush()

    func save()

    func restore()

    func translate(by offset: Vec2<Double>)

    func rotate(by angle: Double)

    func draw(_ line: LineSegment<Double>)

    func draw(_ rect: Rectangle<Double>)

    func draw(_ ellipse: Ellipse<Double>)

    func draw(_ image: Image, at position: Vec2<Double>, withSize size: Vec2<Int>, rotation: Double?)

    func draw(_ svg: SVG, at position: Vec2<Double>, withSize size: Vec2<Int>, rotation: Double?)

    func draw(_ text: Text)
}

public extension Graphics {
    func draw(_ image: Image) {
        draw(image, at: Vec2(x: 0, y: 0))
    }

    func draw(_ image: Image, at position: Vec2<Double>) {
        draw(image, at: position, withSize: image.size)
    }

    func draw(_ image: Image, at position: Vec2<Double>, rotation: Double?) {
        draw(image, at: position, withSize: image.size, rotation: rotation)
    }

    func draw(_ image: Image, at position: Vec2<Double>, withSize size: Vec2<Int>) {
        draw(image, at: position, withSize: size, rotation: nil)
    }

    func draw(_ svg: SVG) {
        draw(svg, at: Vec2(x: 0, y: 0))
    }

    func draw(_ svg: SVG, at position: Vec2<Double>) {
        draw(svg, at: position, withSize: svg.size)
    }

    func draw(_ svg: SVG, at position: Vec2<Double>, rotation: Double?) {
        draw(svg, at: position, withSize: svg.size, rotation: rotation)
    }

    func draw(_ svg: SVG, at position: Vec2<Double>, withSize size: Vec2<Int>) {
        draw(svg, at: position, withSize: size, rotation: nil)
    }
}
