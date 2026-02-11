import QtQuick
import QtQuick.Effects
import Quickshell
import QtQuick.Shapes
import QtQuick.Layouts
import "../Appearance"
PanelWindow {
    id: bottomBar
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

        x: AppearanceProvider.bottomBarAdornmentSize 
        y: AppearanceProvider.bottomBarPadding-AppearanceProvider.bottomBarAdornmentSize

        width: AppearanceProvider.bottomBarAdornmentSize
        height: AppearanceProvider.bottomBarAdornmentSize

        ShapePath {
            strokeWidth: 0
            strokeColor: 'red'
            fillColor: AppearanceProvider.backgroundColorSecondary
            startX: 0
            startY: AppearanceProvider.bottomBarAdornmentSize

            PathArc {
                x: -AppearanceProvider.bottomBarAdornmentSize
                y: 0
                radiusX: AppearanceProvider.bottomBarAdornmentSize
                radiusY: AppearanceProvider.bottomBarAdornmentSize
            }

            PathLine {
                x: -AppearanceProvider.bottomBarAdornmentSize
                y: 0
            }
            PathLine {
                x: -AppearanceProvider.bottomBarAdornmentSize
                y: AppearanceProvider.bottomBarAdornmentSize
            }
        }
    }

    Shape {
        id: shapeR

        preferredRendererType: Shape.CurveRenderer
        x: parent.width - AppearanceProvider.bottomBarAdornmentSize
        y: AppearanceProvider.bottomBarPadding-AppearanceProvider.bottomBarAdornmentSize
        width: AppearanceProvider.bottomBarAdornmentSize
        height: AppearanceProvider.bottomBarAdornmentSize

        ShapePath {
            strokeWidth: 0
            fillColor: AppearanceProvider.backgroundColorSecondary
            startX: AppearanceProvider.bottomBarAdornmentSize
            startY: 0

            PathArc {
                // direction: PathArc.Counterclockwise

                x: 0
                y: AppearanceProvider.bottomBarAdornmentSize
                radiusX: AppearanceProvider.bottomBarAdornmentSize
                radiusY: AppearanceProvider.bottomBarAdornmentSize
            }

            PathLine {
                x: AppearanceProvider.bottomBarAdornmentSize
                y: AppearanceProvider.bottomBarAdornmentSize
            }

            PathLine {
                x: AppearanceProvider.bottomBarAdornmentSize
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

        RowLayout {
            id: barWidgets
            anchors.fill: parent
            spacing: 1
            children: bottomBar.content         
        }
        
    }
}