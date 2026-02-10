import QtQuick
import Quickshell
import "../Appearance"
BaseModule {
    id:baseModule
    content:_content
    popupContent: null
    width: 1
    Component {
        id:_content

        Rectangle{
            anchors.fill:parent
            anchors.topMargin:5
            anchors.bottomMargin:5
            height:parent.width
            color: AppearanceProvider.inactiveColor
            opacity:0.5

        }
    }
}