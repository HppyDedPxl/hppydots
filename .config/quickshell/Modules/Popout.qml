import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland

PopupWindow {
    id: root

    property var margin: AppearanceProvider.rounding
    property var bIsHovered: hoverHandler.hovered
    property Component content
    property var bOpen: false
    property var bOpenOnHover: false
    property var hyprlandGrabber: grab
    property double overrideWidth: -1
    property double baseWidth: overrideWidth > 0 ? overrideWidth : width
    property var shadow: shadowEffect

    function openOnClick() {
        grab.active = true;
    }

    function close() {
        if (grab.active)
            grab.active = false;

    }

    anchor.window: topBar
    anchor.rect.x: baseModule.x + (baseModule.width / 2) - (width / 2)
    anchor.rect.y: parentWindow.height - AppearanceProvider.topBarPadding
    implicitWidth: (overrideWidth > 0 ? overrideWidth : c.width) + margin * 2
    implicitHeight: c.height + AppearanceProvider.topBarPadding * 2
    color:'transparent'
    Item {
        states: [
            State {
                name: "open"
                when: root.bOpen == true

                PropertyChanges {
                    popupGroup {
                        y: 0
                    }

                    shapeGroup {
                        y: 0
                    }
                }
            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "open"
                reversible: true

                SequentialAnimation {
                    PropertyAnimation {
                        properties: "shapeGroup.y"
                        duration: {
                            var travelShapeGroup = (-AppearanceProvider.rounding * 2) * -1;
                            var travelMainGroup = (-c.height + AppearanceProvider.rounding * 1) * -1;
                            var totalTravel = travelShapeGroup + travelMainGroup;
                            return (travelShapeGroup / totalTravel) * AppearanceProvider.popoutAnimDuration;
                        }
                        easing.type: Easing.InQuad
                    }

                    PropertyAnimation {
                        properties: "popupGroup.y"
                        duration: {
                            var travelShapeGroup = (-AppearanceProvider.rounding * 2) * -1;
                            var travelMainGroup = (-c.height + AppearanceProvider.rounding * 1) * -1;
                            var totalTravel = travelShapeGroup + travelMainGroup;
                            return (travelMainGroup / totalTravel) * AppearanceProvider.popoutAnimDuration;
                        }
                        easing.type: Easing.OutCubic
                    }


                }

            }
        ]
    }

    HoverHandler {
        id: hoverHandler
        enabled: true
        blocking:false
    }


    Item {
        id: shapeGroup

        y: -AppearanceProvider.rounding * 2

       
        Item {
            id: popupGroup
        
            y: -c.height + AppearanceProvider.rounding + (AppearanceProvider.rounding/2)

             MultiEffect {
                id: shadowEffect
                source: rect
                anchors.fill: rect
                shadowBlur: 1
                shadowEnabled: true
                shadowColor: AppearanceProvider.shadowColor
                shadowScale: 1.03
                shadowVerticalOffset: 3
                visible: true
            }

            Rectangle {
                id: rect
                color: baseModule.usedBackgroundColor
                x: margin-1
                width: (root.overrideWidth > 0 ? root.overrideWidth : c.width) + 2
                height: c.height
                anchors.leftMargin: AppearanceProvider.rounding
                anchors.rightMargin: AppearanceProvider.rounding
                bottomLeftRadius: AppearanceProvider.rounding
                bottomRightRadius: AppearanceProvider.rounding
                antialiasing: true

                Loader {
                    id: c

                    active: root.visible
                    anchors.centerIn: parent
                    sourceComponent: content !== null ? content : dummyContent
                }

            }

        }

        Shape {
            id: shape1

            preferredRendererType: Shape.CurveRenderer
            x: 0
            y: 0
            width: 45
            height: 45

            ShapePath {
                strokeWidth: 0
                fillColor: baseModule.usedBackgroundColor
                startX: 0
                startY: 0

                PathArc {
                    x: AppearanceProvider.rounding
                    y: AppearanceProvider.rounding
                    radiusX: AppearanceProvider.rounding
                    radiusY: AppearanceProvider.rounding
                }

                PathLine {
                    x: AppearanceProvider.rounding
                    y: 0
                }

                PathLine {
                    x: 0
                    y: 0
                }

            }

        }

        Shape {
            id: shape2

            preferredRendererType: Shape.CurveRenderer
            x: 0
            y: 0
            width: 45
            height: 45

            ShapePath {
                strokeWidth: 0
                fillColor: baseModule.usedBackgroundColor
                startX: implicitWidth - AppearanceProvider.rounding
                startY: AppearanceProvider.rounding

                PathArc {
                    x: implicitWidth
                    y: 0
                    radiusX: AppearanceProvider.rounding
                    radiusY: AppearanceProvider.rounding
                }

                PathLine {
                    x: implicitWidth - AppearanceProvider.rounding
                    y: 0
                }

                PathLine {
                    x: implicitWidth - AppearanceProvider.rounding
                    y: AppearanceProvider.rounding
                }

            }

        }

    }

    HyprlandFocusGrab {
        id: grab
        windows: [root]
        onCleared: {
            close();
        }
    }

    Component {
        id: dummyContent

        Text {
        }

    }

}
