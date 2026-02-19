import QtQuick
import Quickshell
import QtQuick.Layouts
import "../Appearance"
import "../Services"

BaseModule {
    id: baseModule
    dbgName: "kbdModule"
    content: _content
    popupContent: _popupContent
    width:parent.height
    height:parent.height

    Component {
        id: _content
        Rectangle {
            anchors.fill:parent
            color:'transparent'
            RowLayout {
                height:parent.height
                width:parent.width
                StyledBarIcon {
                    id:icon
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: height
                    text: ""
                }
                
            }
        }
        
    }

    Component {
        id:_popupContent
        Rectangle{
            height:30
            width:200
            color:'transparent'
            StyledText {
                anchors.centerIn:parent
                id:text
                text: SystemInfo.currentKeymap
                verticalAlignment: Text.AlignVCenter
            }
        }
    }
}