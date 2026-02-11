import QtQuick
import QtQuick.Shapes

Item{
    id:connector
    property var shape : shape1
    property var size :0
    property var rotation : 0
    transform : Rotation {origin.x:size/2; origin.y:size/2;angle:rotation}
    Shape {
            
            id: shape1
            preferredRendererType: Shape.CurveRenderer
            x: 0
            y: 0
            width: size
            height: size
            ShapePath {
                strokeWidth: 0
                fillColor: baseModule.usedBackgroundColor
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