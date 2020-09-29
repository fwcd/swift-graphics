import Utils

public struct LineSegment<T: IntExpressibleAlgebraicField> {
    public let start: Vec2<T>
    public let end: Vec2<T>
    public let color: Color

    // TODO: Stroke thickness

    public init(from start: Vec2<T> = Vec2(x: 0, y: 0), to end: Vec2<T> = Vec2(x: 0, y: 0), color: Color = ShapeDefaults.color) {
        self.start = start
        self.end = end
        self.color = color
    }

    public init(fromX startX: T = 0, y startY: T = 0, toX endX: T = 0, y endY: T = 0, color: Color = ShapeDefaults.color) {
        self.init(from: Vec2(x: startX, y: startY), to: Vec2(x: endX, y: endY), color: color)
    }
}
