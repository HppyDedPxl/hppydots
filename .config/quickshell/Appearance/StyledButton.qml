import QtQuick
import Quickshell
import Quickshell.Widgets

Rectangle {
    id: button
    property var text: ""
    property var onClick: ()=>{}
    radius: AppearanceProvider.rounding / 2
    color: AppearanceProvider.accentColor
    property var hoverColor: AppearanceProvider.accentColorLighter
    property var padding: 10
    property var bIsHovered : false;
    property var fontSize: 16
    property alias textColor : innerText.color
    property var hoverTextColor;
    width:innerText.paintedWidth+padding*2

    StyledText {
        id: innerText
        anchors.centerIn:parent
        text:button.text
        font.pointSize: button.fontSize
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
            button.onClick()
        }
    }

    states:[
        State{
            name:"hovered"
            when: bIsHovered
            PropertyChanges{
                button {
                    color: hoverColor
                }
                innerText {
                    color: hoverTextColor
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