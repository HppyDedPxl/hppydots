import QtQuick
import Quickshell
import Quickshell.Widgets

Rectangle {
    id: button
    property var text: ""
    property var onClick: ()=>{}
    radius: AppearanceProvider.rounding / 2
    color: AppearanceProvider.accentColor
    property var bIsHovered : false;
    property var fontSize: 16

    StyledText {
        anchors.centerIn:parent
        text:button.text
        font.pointSize: button.fontSize
    }
    MouseArea{
        anchors.fill:parent
        enabled:true
        hoverEnabled:true
        onEntered: {
            bIsHovered = true
        }
        onExited: {
            bIsHovered = false
        }
        onClicked: [
            button.onClick()
        ]
    }

    states:[
        State{
            name:"hovered"
            when: bIsHovered
            PropertyChanges{
                button {
                    color: AppearanceProvider.accentColorLighter
                }
            }
        }
    ]
    transitions:[
        Transition{
            id: hoverTransition
            PropertyAnimation {
                duration: 100
                easing.type: Easing.InOutQuad
            }
        }
    ]

}