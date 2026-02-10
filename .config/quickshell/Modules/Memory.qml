import QtQuick
import Quickshell
import "../Appearance"
import "../Services"

// Todo: Popout show all memory partitions (e.g. all swaps)

BaseModule{
    id:baseModule
    content: _content
    popupContent: null
    property bool minimalMode: true
    width: minimalMode ? 110 : 220
    Component {
        id: _content
        Rectangle {
            id:root
            anchors.fill:parent
            color: 'transparent'
             StyledText {
                anchors.centerIn:parent
                color: baseModule.textColorOnBar
                text:  minimalMode ? (SystemInfo.memFree / 1024.0 / 1024.0).toFixed(2) + "GiB " : (SystemInfo.memFree / 1024.0 / 1024.0).toFixed(2) + "GiB/" + (SystemInfo.memTotal / 1024.0 / 1024.0).toFixed(2) + "GiB "
            }
        }
       
    }

}