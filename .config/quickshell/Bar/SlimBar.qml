import "../Appearance"
import "../Modules"
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell

PanelWindow {
    id: topBar

    property list<Item> leftContent
    property list<Item> rightContent
    property var leftBarWidth
    property var rightBarWidth
    screen: scope.modelData
    implicitHeight: AppearanceProvider.topBarWidth + AppearanceProvider.topBarPadding
    color: 'transparent'
    exclusiveZone: AppearanceProvider.topBarWidth

    anchors {
        top: true
        right: true
        left: true
    }
    // Shadows of the bar on the lowest layer
    RectangularShadow {
        anchors.fill: topBarGeometry
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        radius: 0
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }
    // Top Bar content segment
    BarContentSegment {
        id: leftSegment
        width: leftBarWidth
        height: AppearanceProvider.topBarWidth
        color: AppearanceProvider.backgroundColor
        content: leftContent
        y: AppearanceProvider.slimBarWidth-1
        anchors.left : topBarGeometry.left
        
        isLeftAligned:true
    }

        // Top Bar content segment
    BarContentSegment {
        id: rightSegment

        width: rightBarWidth
        height: AppearanceProvider.topBarWidth
        color: AppearanceProvider.backgroundColorSecondary
        content: rightContent
        y: AppearanceProvider.slimBarWidth-1
        anchors.right : topBarGeometry.right
        
        isRightAligned:true
    }

    // highest layer is the actual top bar geometry
    Rectangle {
        id: topBarGeometry

        width: parent.width
        height: AppearanceProvider.slimBarWidth
        clip: true

        Rectangle {
            height: parent.width
            width: parent.width
            anchors.centerIn: parent
            rotation: -45
            containmentMask: topBarGeometry

            gradient: Gradient {
                orientation: Gradient.Horizontal

                GradientStop {
                    position: 0
                    color: AppearanceProvider.backgroundColor
                }

                GradientStop {
                    position: 0.25
                    color: AppearanceProvider.backgroundColor
                }

                GradientStop {
                    position: 0.250001
                    color: AppearanceProvider.accentColor
                }

                GradientStop {
                    position: 0.26
                    color: AppearanceProvider.accentColor
                }

                GradientStop {
                    position: 0.260001
                    color: AppearanceProvider.accentColorLighter
                }

                GradientStop {
                    position: 0.27
                    color: AppearanceProvider.accentColorLighter
                }

                GradientStop {
                    position: 0.270001
                    color: AppearanceProvider.backgroundColorSecondary
                }

            }

        }

    }

}
