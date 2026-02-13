
import "./"
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets

Slider {
    id: control
    width:300
    property var thickness: 15
    property var target
    property var barHeight : 20

    onMoved:{
        if(target) 
            target.position = (control.value * (target.length))
    }
    Timer {
        interval: 500
        running: target ? target.isPlaying : false
        repeat:true
        onTriggered: {
            control.value = target.position / target.length
        }
    }

    // Behavior on value {
    //     PropertyAnimation{
    //         duration: 500
    //     }
    // }

    background: Rectangle {
        x: control.leftPadding
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: control.availableWidth
        implicitHeight: barHeight/3
        width: control.availableWidth
        height: implicitHeight
        radius: AppearanceProvider.rounding
        color: AppearanceProvider.inactiveColor


        // Rectangle {
        //     width: control.visualPosition * parent.width
        //     height: parent.height
        //     color: AppearanceProvider.backgroundColor
        //     radius: parent.radius
        // }
    }

    handle: Rectangle {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding + control.availableHeight / 2 - height / 2
        implicitWidth: control.thickness
        implicitHeight: control.thickness
        radius: 13
        color: AppearanceProvider.backgroundColor
        border.color: 'transparent'
    }

}


