import Utils

public struct Ellipse<T: IntExpressibleAlgebraicField> {
    public var center: Vec2<T>
    public var radius: Vec2<T>
    public var color: Color
    public var isFilled: Bool
    public var rotation: T

    public var boundingRectangle: Rectangle<T> {
        Rectangle(topLeft: center - radius, size: Vec2(x: 2, y: 2) * radius, rotation: rotation, color: color, isFilled: isFilled)
    }

    public init(
        center: Vec2<T> = Vec2(x: 0, y: 0),
        radius: Vec2<T> = Vec2(x: 1, y: 1),
        rotation: T = 0,
        color: Color = ShapeDefaults.color,
        isFilled: Bool = ShapeDefaults.isFilled
    ) {
        self.center = center
        self.radius = radius
        self.color = color
        self.isFilled = isFilled
        self.rotation = rotation
    }

    public init(
        centerX: T = 0,
        y centerY: T = 0,
        radiusX: T = 1,
        y radiusY: T = 1,
        rotation: T = 0,
        color: Color = ShapeDefaults.color,
        isFilled: Bool = ShapeDefaults.isFilled
    ) {
        self.init(center: Vec2(x: centerX, y: centerY), radius: Vec2(x: radiusX, y: radiusY), rotation: rotation, color: color, isFilled: isFilled)
    }

    public init(
        centerX: T = 0,
        y centerY: T = 0,
        radius: T = 1,
        rotation: T = 0,
        color: Color = ShapeDefaults.color,
        isFilled: Bool = ShapeDefaults.isFilled
    ) {
        self.init(centerX: centerX, y: centerY, radiusX: radius, y: radius, rotation: rotation, color: color, isFilled: isFilled)
    }
}
