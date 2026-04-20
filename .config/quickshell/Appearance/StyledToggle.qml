import QtQuick
import Quickshell
import Quickshell.Widgets

Rectangle {
    id: button
    property var text: ""
    property var onToggledOn: ()=>{}
    property var onToggledOff: ()=>{}
    property var bIsToggled: false;
    property var bIsToggledPersistent : false;
    property var _toggleVisuals : bIsToggled || bIsToggledPersistent
    property var bIsEnabled: true;
    radius: height
    border.width:1
    property var buttonPrimaryColor : !_toggleVisuals ? AppearanceProvider.inactiveColor : AppearanceProvider.highlightColor
    border.color:Qt.darker(AppearanceProvider.inactiveColor)
    color: Qt.darker(buttonPrimaryColor)
    property var hoverColor: Qt.lighter(buttonPrimaryColor)
    property var padding: 10
    property var bIsHovered : false;
    property var fontSize: 16
    opacity: bIsEnabled ? 1 : 0.5
    Behavior on color{
        ColorAnimation { duration: 150; }
    }
    Behavior on opacity {
        NumberAnimation { duration: 150;}
    }
    Rectangle{
        width:parent.width/2-parent.border.width*2
        height:parent.height-parent.border.width*2
        radius: height
        color: AppearanceProvider.backgroundColor
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.topMargin:parent.border.width
        anchors.leftMargin: !_toggleVisuals ? parent.border.width : parent.border.width + parent.width/2-parent.border.width 
        Behavior on anchors.leftMargin {
            NumberAnimation { duration : 150; easing.type: Easing.InOutQuad}
        }
    }
     
    MouseArea{
        anchors.fill:parent
        enabled:true
        hoverEnabled:true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            bIsHovered = true
        }
        onExited: {
            bIsHovered = false
        }
        onClicked: {
            bIsToggled = !(bIsToggled || bIsToggledPersistent)
            if(bIsToggled && button.onToggledOn != null)
                button.onToggledOn()
            else if(!bIsToggled && button.onToggledOff != null)
                button.onToggledOff()
        }
    }

    states:[
        State{
            name:"hovered"
            when: bIsHovered
            PropertyChanges{
            }
        }
    ]
    transitions:[
        Transition{
            id: hoverTransition
        }
    ]

}