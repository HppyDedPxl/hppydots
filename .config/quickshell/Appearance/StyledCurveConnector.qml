import QtQuick
import QtQuick.Shapes
import QtQuick.Effects

Item{
    id:connector
    property var shape : shape1
    property var size :0
    property var rotation : 0
    property var overlay : null
    property var explicitColor : AppearanceProvider.backgroundColorSecondary
    transform : Rotation {origin.x:size/2; origin.y:size/2;angle:rotation}
    height:size
    width:size

    Shape {
        id: shape1
        preferredRendererType: Shape.CurveRenderer
        x: 0
        y: 0
        width: size
        height: size
        layer.enabled:true
        antialiasing: true
        ShapePath {
            id:shape2
            strokeWidth: 0
            fillColor: baseModule ? baseModule.usedBackgroundColor : explicitColor
            startX: 0
            startY: 0

            PathArc {
                x: size
                y: size
                radiusX: size
                radiusY: size
            }

            PathLine {
                x: size
                y: 0
            }

            PathLine {
                x: 0
                y: 0
            }

        }
    }
}