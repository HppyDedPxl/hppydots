import QtQuick
import Quickshell
import "../Appearance"
import "../Services"

// Todo: Popout that shows a list by core

BaseModule{
    id:baseModule
    content: _content
    popupContent: null
    width:60
    Component {
        id: _content
        Rectangle {
            id:root
            anchors.fill:parent
            color: 'transparent'
             StyledText {
                anchors.centerIn:parent
                color: baseModule.textColorOnBar
                text:  Math.round(SystemInfo.avgCpuLoad * 100) + "% "
            }
        }
       
    }

}