import QtQuick
import Quickshell
import Quickshell.Widgets

Rectangle {
    height: parent.height
    width: parent.width
    color:'transparent'
    radius:AppearanceProvider.rounding
    required property var content
    // callbacks for fade timing aniamted with behavior further down
    property var onPopupStartOpen:()=>{
        iconRect.opacity = 0
    }
    property var onPopupOpened:()=>{
        iconRect.visible = false
    }
    property var onPopupClosed: ()=>{
        iconRect.visible = true
        iconRect.opacity = 1
    }
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
        