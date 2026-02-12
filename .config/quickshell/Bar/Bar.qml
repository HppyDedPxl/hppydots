import "../Appearance"
import "../Modules"
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell

PanelWindow {
    id: topBar
    property list<Item> content
    screen: scope.modelData
    implicitHeight: AppearanceProvider.topBarWidth + AppearanceProvider.topBarPadding
    color: 'transparent'
    exclusiveZone: AppearanceProvider.topBarWidth

    anchors {
        top: true
        right: true
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
        anchors.fill: topBarGeometry
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        radius: 0
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }

    Rectangle {
        id: topBarGeometry
        width: parent.width
        height: AppearanceProvider.topBarWidth
        clip: true

        Rectangle {
            height: parent.width
            width: parent.width
            anchors.centerIn: parent
            rotation: 45
            containmentMask: topBarGeometry

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0
                    color: AppearanceProvider.backgroundColor
                }
                GradientStop {
                    position: 0.17
                    color: AppearanceProvider.backgroundColor
                }
                GradientStop {
                    position: 0.170001
                    color: AppearanceProvider.accentColor
                }
                GradientStop {
                    position: 0.18
                    color: AppearanceProvider.accentColor
                }
                GradientStop {
                    position: 0.180001
                    color: AppearanceProvider.accentColorLighter
                }
                GradientStop {
                    position: 0.19
                    color: AppearanceProvider.accentColorLighter
                }
                GradientStop {
                    position: 0.190001
                    color: AppearanceProvider.backgroundColorSecondary
                }
            }
        }

        RowLayout {
            id: barWidgets
            anchors.fill: parent
            spacing: 1
            children: topBar.content         
        }
    }

    Shape {
        id: shapeL

        preferredRendererType: Shape.CurveRenderer
        x: 0
        y: AppearanceProvider.topBarWidth
        width: AppearanceProvider.topBarAdornmentSize
        height: AppearanceProvider.topBarAdornmentSize

        ShapePath {
            strokeWidth: 0
            fillColor: AppearanceProvider.backgroundColor
            startX: 0
            startY: AppearanceProvider.topBarAdornmentSize

            PathArc {
                x: AppearanceProvider.topBarAdornmentSize
                y: 0
                radiusX: AppearanceProvider.topBarAdornmentSize
                radiusY: AppearanceProvider.topBarAdornmentSize
            }

            PathLine {
                x: 0
                y: 0
            }
            PathLine {
                x: 0
                y: AppearanceProvider.topBarAdornmentSize
            }
        }
    }

    Shape {
        id: shapeR

        preferredRendererType: Shape.CurveRenderer
        x: parent.width - AppearanceProvider.topBarAdornmentSize
        y: AppearanceProvider.topBarWidth
        width: AppearanceProvider.topBarAdornmentSize
        height: AppearanceProvider.topBarAdornmentSize

        ShapePath {
            strokeWidth: 0
            fillColor: AppearanceProvider.backgroundColorSecondary
            startX: 0
            startY: 0

            PathArc {
                // direction: PathArc.Counterclockwise

                x: AppearanceProvider.topBarAdornmentSize
                y: AppearanceProvider.topBarAdornmentSize
                radiusX: AppearanceProvider.topBarAdornmentSize
                radiusY: AppearanceProvider.topBarAdornmentSize
            }

            PathLine {
                x: AppearanceProvider.topBarAdornmentSize
                y: AppearanceProvider.topBarAdornmentSize
            }

            PathLine {
                x: AppearanceProvider.topBarAdornmentSize
                y: 0
            }

        }

    }

    mask: Region {
        item: {
            topBarGeometry;
        }
    }

}
