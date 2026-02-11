import QtQuick
import Quickshell
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Widgets
import "../Appearance"
Rectangle{
    id:desktopEntry
    required property var _data
    width: parent.width
    height: 64
    property var isFocused: false
    color : isFocused ? AppearanceProvider.highlightColor : AppearanceProvider.backgroundColorSecondary
    border.width:0
    radius: AppearanceProvider.rounding
    Rectangle {
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.margins:6  
        color:'transparent'
        RowLayout {
            id:layout
            anchors.fill:parent
            spacing:15
            

                Rectangle{
                    id: imageRect
                    width:desktopEntry.height-12
                    height:desktopEntry.height-12
                    color:'transparent'
                    radius:AppearanceProvider.rounding
                    clip:true
                    Image {
                        anchors.fill:parent
                        id: image
                        visible:true
                        source: Quickshell.iconPath(_data.icon)
                    }
                }
            
            StyledText {
                text: _data.name
                clip:true
                elide: Text.ElideRight
                color: desktopEntry.isFocused ? AppearanceProvider.highlightTextColor : AppearanceProvider.textColor
                Layout.fillWidth:true
            }
        }
    }
}