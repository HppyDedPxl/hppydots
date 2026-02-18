import QtQuick
import Quickshell
import Quickshell.Widgets

Rectangle {
    id: button
    property var text: ""
    property var onClick: ()=>{}
    radius: AppearanceProvider.rounding / 2
    border.width:4
    property var buttonPrimaryColor : AppearanceProvider.accentColor
    border.color:buttonPrimaryColor
    color: Qt.darker(buttonPrimaryColor)
    property var hoverColor: Qt.lighter(buttonPrimaryColor)
    property var padding: 10
    property var bIsHovered : false;
    property var fontSize: 16
    property alias textColor : innerText.color
    property var hoverTextColor : Qt.lighter(innerText.color)
    width:innerText.paintedWidth+padding*2
    

    StyledText {
        id: innerText
        anchors.centerIn:parent
        text:button.text
        font.pointSize: button.fontSize
        color: buttonPrimaryColor
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
                    border.color: hoverColor
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
        }
    ]

}