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
        self.color = color
        self.isFilled = isFilled

        if isFilled && points.count > 1 && points.first! != points.last! {
            var closedPoints = points
            closedPoints.append(points.first!)
            self.points = closedPoints
        } else {
            self.points = points
        }
    }
}
