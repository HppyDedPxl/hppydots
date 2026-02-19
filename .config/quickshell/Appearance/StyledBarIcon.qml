import Quickshell
import QtQuick
import "./"

Rectangle{
    property var text
    height:parent.height
    width:height
    color:'transparent'
    property var dynFontSize: Math.round(parent.height * 0.45)
    clip:true
    StyledText{
        id: icon
        anchors.centerIn:parent
        color: baseModule.textColorOnBar
        font.pointSize: { dynFontSize > 0 ? dynFontSize : 14 }
        text: parent.text
    }
}

