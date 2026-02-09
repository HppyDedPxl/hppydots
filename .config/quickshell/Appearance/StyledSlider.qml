import "./"
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets

WrapperMouseArea {
    id: wrapper
    property var scrollSpeed: 0.0002
    property var onMoved: {
    }
    property var value: 0.0
    property var from:0.0
    property var to: 1.0
    scrollGestureEnabled: true
    onWheel: (event) => {
        value = Math.max(from,Math.min(to,value + event.angleDelta.y * scrollSpeed,to))
    }

    Slider {
        id: control
        value: wrapper.value
        onMoved: wrapper.onMoved
        property var thickness: 15
        from: wrapper.from
        to: wrapper.to


        background: Rectangle {
            x: control.leftPadding
            y: control.topPadding + control.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: control.availableHeight
            width: control.availableWidth
            height: implicitHeight
            radius: AppearanceProvider.rounding
            color: AppearanceProvider.backgroundColor

            Rectangle {
                width: control.visualPosition * parent.width
                height: parent.height
                color: AppearanceProvider.inactiveColor
                radius: parent.radius
            }
        }

        handle: Rectangle {
            x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
            y: control.topPadding + control.availableHeight / 2 - height / 2
            implicitWidth: control.thickness
            implicitHeight: control.thickness
            radius: 13
            color: 'transparent'
            border.color: 'transparent'
        }

    }

}
