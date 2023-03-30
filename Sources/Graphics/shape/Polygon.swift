import Utils

public struct Polygon<T: IntExpressibleAlgebraicField> {
    public let points: [Vec2<T>]
    public let color: Color
    public let isFilled: Bool

    public init(
        points: [Vec2<T>],
        color: Color = ShapeDefaults.color,
        isFilled: Bool = ShapeDefaults.isFilled
    ) {
        self.points = points
        self.color = color
        self.isFilled = isFilled
    }
}
