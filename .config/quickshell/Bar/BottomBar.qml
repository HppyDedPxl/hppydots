import QtQuick
import QtQuick.Effects
import Quickshell
import QtQuick.Shapes
import "../Appearance"
PanelWindow {
    id: leftBar
    property list<Item> content
    screen: scope.modelData
    implicitHeight: AppearanceProvider.bottomBarWidth + AppearanceProvider.bottomBarPadding
    color: 'transparent'
    exclusiveZone: AppearanceProvider.bottomBarWidth


    anchors {
        right: true
        bottom: true
        left: true
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

    RectangularShadow {
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.topMargin: AppearanceProvider.bottomBarPadding
        radius: 0
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }


    Shape {
        id: shapeL

        preferredRendererType: Shape.CurveRenderer
        x: AppearanceProvider.bottomBarWidth
        y: AppearanceProvider.bottomBarPadding-AppearanceProvider.bottomBarWidth
        width: AppearanceProvider.bottomBarWidth
        height: AppearanceProvider.bottomBarWidth

        ShapePath {
            strokeWidth: 0
            strokeColor: 'red'
            fillColor: AppearanceProvider.backgroundColorSecondary
            startX: 0
            startY: AppearanceProvider.bottomBarWidth

            PathArc {
                x: -AppearanceProvider.bottomBarWidth
                y: 0
                radiusX: AppearanceProvider.bottomBarWidth
                radiusY: AppearanceProvider.bottomBarWidth
            }

            PathLine {
                x: -AppearanceProvider.bottomBarWidth
                y: 0
            }
            PathLine {
                x: -AppearanceProvider.bottomBarWidth
                y: AppearanceProvider.bottomBarWidth
            }
        }
    }

    Shape {
        id: shapeR

        preferredRendererType: Shape.CurveRenderer
        x: parent.width - AppearanceProvider.bottomBarWidth
        y: AppearanceProvider.bottomBarPadding-AppearanceProvider.bottomBarWidth
        width: AppearanceProvider.bottomBarWidth
        height: AppearanceProvider.bottomBarWidth

        ShapePath {
            strokeWidth: 0
            fillColor: AppearanceProvider.backgroundColorSecondary
            startX: AppearanceProvider.bottomBarWidth
            startY: 0

            PathArc {
                // direction: PathArc.Counterclockwise

                x: 0
                y: AppearanceProvider.bottomBarWidth
                radiusX: AppearanceProvider.bottomBarWidth
                radiusY: AppearanceProvider.bottomBarWidth
            }

            PathLine {
                x: AppearanceProvider.bottomBarWidth
                y: AppearanceProvider.bottomBarWidth
            }

            PathLine {
                x: AppearanceProvider.bottomBarWidth
                y: 0
            }

        }

    }

    Rectangle{
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.topMargin: AppearanceProvider.bottomBarPadding
        color: AppearanceProvider.backgroundColorSecondary
        height:AppearanceProvider.bottomBarWidth
        clip:true
        
    }
}