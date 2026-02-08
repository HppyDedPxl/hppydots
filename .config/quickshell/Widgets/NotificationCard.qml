import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Item {
    id: card

    property var notification: null
    property var onDismiss: () => {
        NotificationHandler.dismissNotification(notification)
    }

    height: childrenRect.height + 5
    Layout.alignment: Qt.AlignHCenter
    width: parent.width

    HoverHandler {
        id: hoverHandler

        target: columnLayout
    }

    RectangularShadow {
        anchors.fill: columnLayout
        spread: 0
        blur: 10
        radius: AppearanceProvider.rounding / 2
        color: AppearanceProvider.shadowColor
        opacity: 1
        offset.x: 5
        offset.y: 5
    }

    RectangularShadow {
        id: dismissButtonShadow

        anchors.fill: dismissButton
        radius: 12
        spread: 1
        blur: 5
        offset.x: 2
        offset.y: 2
        opacity: 0
    }

    Column {
        id: columnLayout

        width: parent.width

        Rectangle {
            id: headerRect

            width: parent.width
            height: 30
            topLeftRadius: AppearanceProvider.rounding / 2
            topRightRadius: AppearanceProvider.rounding / 2
            color: AppearanceProvider.backgroundColor

            StyledText {
                anchors.centerIn: parent
                text: notification.summary
                elide: Text.ElideRight
                clip: true
                width: parent.width - 25
                color: AppearanceProvider.textColor
            }

            IconImage {
                visible: notification.appIcon !== ""
                source: notification.appIcon

            }

            Rectangle{
                visible: notification.urgency > 1
                width:25
                height:25
                radius:13
                color: AppearanceProvider.accentColor
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin:-12
                anchors.leftMargin:-12
                StyledText{
                    anchors.centerIn:parent
                    text: ""
                    color: AppearanceProvider.textColor
                }
            }

        }
        Rectangle {
            id: bottomRect
            clip:true

            default property alias data: rowLayout.data

            color: AppearanceProvider.textColor
            implicitWidth: headerRect.width
            implicitHeight: rowLayout.implicitHeight
            bottomLeftRadius: AppearanceProvider.rounding / 2
            bottomRightRadius: AppearanceProvider.rounding / 2

            RowLayout {
                id: rowLayout

                width: headerRect.width
                implicitWidth: headerRect.width

                Image {
                    source: notification.image
                    Layout.leftMargin: 5
                    Layout.topMargin: 5
                    Layout.bottomMargin: 5
                    Layout.maximumWidth: 50
                    Layout.maximumHeight: 50
                    smooth: true
                    antialiasing: true
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignLeft
                    fillMode: Image.PreserveAspectFit
                    z: 1
                }

                StyledText {
                    id: messageBody

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight
                    Layout.topMargin: 10
                    Layout.bottomMargin: 10
                    wrapMode: Text.WordWrap
                    color: AppearanceProvider.textColorDark
                    text: notification.body
                    clip: true
                    elide: Text.ElideRight
                    font.pointSize: 10
                    maximumLineCount: 4
                }

            }

        
        }

    }

    RoundButton {
        id: dismissButton

        text: "x"
        height: 24
        width: 24
        anchors.right: parent.right
        anchors.top: parent.top
        onClicked: {
            onDismiss();
        }
        opacity: 0
        states: [
            State {
                name: "visible"
                when: hoverHandler.hovered

                PropertyChanges {
                    dismissButton {
                        opacity: 1
                    }

                    dismissButtonShadow {
                        opacity: 1
                    }

                }

            }
        ]
        transitions: [
            Transition {
                from: ""
                to: "visible"
                reversible: true

                PropertyAnimation {
                    property: "opacity"
                    duration: 50
                }

            }
        ]

        background: Rectangle {
            color: !dismissButton.hovered ? AppearanceProvider.accentColor : AppearanceProvider.accentColorLighter
            radius: 12
        }

    }

}
