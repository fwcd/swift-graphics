import Utils
import Logging

fileprivate let log = Logger(label: "Graphics.ConsoleGraphics")

/**
 * A simple graphics context that outputs its operations to standard out. Useful for debugging.
 */
public struct ConsoleContext: GraphicsContext {
    public func flush() {
        log.info("Flushed")
    }

    public func save() {
        log.info("Saved context")
    }

    public func restore() {
        log.info("Restored context")
    }

    public func translate(by offset: Vec2<Double>) {
        log.info("Translated by \(offset)")
    }

    public func rotate(by angle: Double) {
        log.info("Rotated by \(angle) radians")
    }

    public func draw(_ line: LineSegment<Double>) {
        log.info("Drawed line \(line)")
    }

    public func draw(_ rect: Rectangle<Double>) {
        log.info("Drawed rectangle \(rect)")
    }

    public func draw(_ image: Image, at position: Vec2<Double>, withSize size: Vec2<Int>, rotation: Double?) {
        log.info("Drawed image \(image) at \(position) with size \(size)\(rotation.map { " and rotation \($0)" } ?? "")")
    }

    public func draw(_ svg: SVG, at position: Vec2<Double>, withSize size: Vec2<Int>, rotation: Double?) {
        log.info("Drawed svg \(svg) at \(position) with size \(size)\(rotation.map { " and rotation \($0)" } ?? "")")
    }
    public func draw(_ text: Text) {
        log.info("Drawed text \(text.value) of size \(text.fontSize) at \(text.position)")
    }

    public func draw(_ ellipse: Ellipse<Double>) {
        log.info("Drawed ellipse \(ellipse)")
    }
}
