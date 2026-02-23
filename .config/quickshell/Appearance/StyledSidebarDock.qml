import QtQuick
import Quickshell
import Quickshell.Widgets
import "../Services"

Rectangle {
    height: parent.height
    width: parent.width
    x: baseModule.orientation % 2 != 0 ? ( (baseModule.orientation == 1 ? -1:1) * parent.width/3) : 0
    color:'transparent'
    radius:AppearanceProvider.rounding
    required property var content
    WrapperMouseArea {
        width: parent.width
        height: width
        hoverEnabled: true
        Rectangle {
            id: iconRect
            visible: true
            color : AppearanceProvider.backgroundColorSecondary
            width: parent.width         
            height: parent.width
            radius: parent.width/2
            clip:true
            children: content
            opacity: !PopupObserver.isAnyPopupOpenOnBar(targetBar) || targetBar.width >= width ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }      
        }
        cursorShape: baseModule.hasPopupContent() ? Qt.PointingHandCursor : null
        onClicked:{
            if(baseModule.hasPopupContent())
                baseModule.openPopup()
        }
        onEntered:{
            baseModule.bIsHovered = true
        }
        onExited:{
            baseModule.bIsHovered = false
        }
    }
}
        