import "../Appearance"
import "../Modules"
import QtQuick

import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell

Item {
    id: root

    property alias color: rect.color
    property var content : []
    property var isLeftAligned: false
    property var isRightAligned: false
    height: AppearanceProvider.topBarWidth

    RectangularShadow {
        anchors.fill: rect
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        radius: AppearanceProvider.rounding
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }

    MultiEffect {
        id: shadowEffect

        source: shapeL
        anchors.fill: shapeL
        shadowBlur: 1
        shadowEnabled: true
        shadowColor: AppearanceProvider.shadowColor
        shadowScale: 1
        shadowVerticalOffset: 3
        shadowHorizontalOffset: 3
        visible: true
    }

    MultiEffect {
        id: shadowEffect2

        source: shapeR
        anchors.fill: shapeR
        shadowBlur: 1
        shadowEnabled: true
        shadowColor: AppearanceProvider.shadowColor
        shadowScale: 1
        shadowVerticalOffset: 3
        shadowHorizontalOffset: -3
        visible: true
    }

    Rectangle {
        id: rect
        width:parent.width
        height:parent.height
        bottomRightRadius: root.isRightAligned ? 0 : AppearanceProvider.rounding
        bottomLeftRadius: root.isLeftAligned ? 0 : AppearanceProvider.rounding
        RowLayout {
            width:parent.width
            height:parent.height
            id: barWidgets
            spacing: 1
            children: root.content
        }
    }

    Shape {
        id: shapeL

        preferredRendererType: Shape.CurveRenderer
        x: rect.x + rect.width + AppearanceProvider.rounding
        y: 0
        width: AppearanceProvider.rounding
        height: AppearanceProvider.rounding
        visible: !root.isLeftAligned

        ShapePath {
            strokeWidth: 0
            strokeColor: 'red'
            fillColor: rect.color
            startX: 0
            startY: 0

            PathArc {
                x: -AppearanceProvider.rounding
                y: AppearanceProvider.rounding
                radiusX: AppearanceProvider.rounding
                radiusY: AppearanceProvider.rounding
                useLargeArc: false
                direction: PathArc.Counterclockwise
            }

            PathLine {
                x: -AppearanceProvider.rounding
                y: -AppearanceProvider.rounding
            }

            PathLine {
                x: -AppearanceProvider.rounding
                y: 0
            }

        }

    }

    Shape {
        id: shapeR

        preferredRendererType: Shape.CurveRenderer
        x: rect.x
        y: 0
        width: AppearanceProvider.rounding
        height: AppearanceProvider.rounding
        visible: !isRightAligned

        ShapePath {
            strokeWidth: 0
            strokeColor: 'red'
            fillColor: rect.color
            startX: -AppearanceProvider.rounding
            startY: 0

            PathArc {
                x: 0
                y: AppearanceProvider.rounding
                radiusX: AppearanceProvider.rounding
                radiusY: AppearanceProvider.rounding
                useLargeArc: false
                direction: PathArc.Clockwise
            }

            PathLine {
                x: 0
                y: -AppearanceProvider.rounding
            }

            PathLine {
                x: 0
                y: 0
            }

        }

    }

}
