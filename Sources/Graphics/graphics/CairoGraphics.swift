import Cairo
import Utils

public class CairoGraphics: Graphics {
    private let context: Cairo.Context

    init(surface: Surface) {
        context = Cairo.Context(surface: surface)
    }

    public convenience init(fromImage image: Image) {
        self.init(surface: image.surface)
    }

    public func flush() {
        context.surface.flush()
    }

    public func save() {
        context.save()
    }

    public func restore() {
        context.restore()
    }

    public func translate(by offset: Vec2<Double>) {
        context.translate(x: offset.x, y: offset.y)
    }

    public func rotate(by angle: Double) {
        context.rotate(angle)
    }

    public func draw(_ line: LineSegment<Double>) {
        context.setSource(color: line.color.asDoubleTuple)
        context.move(to: line.start.asTuple)
        context.line(to: line.end.asTuple)
        context.stroke()
    }

    public func draw(_ rect: Rectangle<Double>) {
        // Floating point comparison is intended since this flag only allows potential optimizations
        var rotated = false

        if let rotation = rect.rotation {
            context.save()
            context.rotate(rotation)
            rotated = true
        }

        context.setSource(color: rect.color.asDoubleTuple)

        if let radius = rect.cornerRadius {
            context.newSubpath()
            context.addArc(center: (rect.topLeft + Vec2(x: radius, y: radius)).asTuple, radius: radius, angle: (Double.pi, (3.0 / 2.0) * Double.pi))
            context.addArc(center: (rect.topRight + Vec2(x: -radius, y: radius)).asTuple, radius: radius, angle: (-Double.pi / 2.0, 0))
            context.addArc(center: (rect.bottomRight + Vec2(x: -radius, y: -radius)).asTuple, radius: radius, angle: (0, Double.pi / 2.0))
            context.addArc(center: (rect.bottomLeft + Vec2(x: radius, y: -radius)).asTuple, radius: radius, angle: (Double.pi / 2.0, Double.pi))
            context.closePath()
        } else {
            context.addRectangle(x: rect.topLeft.x, y: rect.topLeft.y, width: rect.width, height: rect.height)
        }

        if rect.isFilled {
            context.fill()
        } else {
            context.stroke()
        }

        if rotated {
            context.restore()
        }
    }

    public func draw(_ image: Image, at position: Vec2<Double>, withSize size: Vec2<Int>, rotation optionalRotation: Double?) {
        draw(image.surface, of: image.size, at: position, withSize: size, rotation: optionalRotation)
    }

    public func draw(_ svg: SVG, at position: Vec2<Double>, withSize size: Vec2<Int>, rotation optionalRotation: Double?) {
        draw(svg.surface, of: svg.size, at: position, withSize: size, rotation: optionalRotation)
    }

    private func draw(_ surface: Surface, of originalSize: Vec2<Int>, at position: Vec2<Double>, withSize size: Vec2<Int>, rotation optionalRotation: Double?) {
        context.save()

        let scaleFactor = Vec2(x: Double(size.x) / Double(originalSize.x), y: Double(size.y) / Double(originalSize.y))
        context.translate(x: position.x, y: position.y)

        if let rotation = optionalRotation {
            let center = (size / 2).asDouble
            context.translate(x: center.x, y: center.y)
            context.rotate(rotation)
            context.translate(x: -center.x, y: -center.y)
        }

        if originalSize != size {
            context.scale(x: scaleFactor.x, y: scaleFactor.y)
        }

        context.source = Pattern(surface: surface)
        context.paint()
        context.restore()
    }

    public func draw(_ text: Text) {
        context.setSource(color: text.color.asDoubleTuple)
        context.setFont(size: text.fontSize)
        context.move(to: text.position.asTuple)
        context.show(text: text.value)
    }

    public func draw(_ ellipse: Ellipse<Double>) {
        context.save()
        context.translate(x: ellipse.center.x, y: ellipse.center.y)
        context.rotate(ellipse.rotation)
        context.scale(x: ellipse.radius.x, y: ellipse.radius.y)
        context.addArc(center: (x: 0.0, y: 0.0), radius: 1.0, angle: (0, 2.0 * Double.pi))
        context.restore()

        context.save()
        context.setSource(color: ellipse.color.asDoubleTuple)

        if ellipse.isFilled {
            context.fill()
        } else {
            context.stroke()
        }

        context.restore()
    }
}
