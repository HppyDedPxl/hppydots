import "../Appearance"
import "../Services"
import "../Widgets"
import "./"
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Services.Notifications

BaseModule {
    id: baseModule
    width:parent.height
    content: _content
    popupContent: _popupContent

    Component {
        id: _content

        Rectangle {
            id: root
            color: 'transparent'

            StyledBarIcon {
                id: icon
                text: "󰎟"
            }

            StyledAlertCount {
                targetIcon: icon
                count: NotificationHandler.getAmountOfNotifications()
            }

        }

    }

    // Todo:// add "dismiss all" and "dnd" buttons
    Component {
        id: _popupContent

        Rectangle {
            id: popupRoot

            height: 430
            width: 400
            color: 'transparent'

            StyledText {
                id: heading

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 20
                anchors.leftMargin: 20
                text: "Notification Center"
            }

            StyledButton {
                id: dismissAllButton

                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 20
                anchors.topMargin: 15
                height: 35
                width: 80
                text: ""
                fontSize: 16
                onClick: () => {
                    NotificationHandler.dismissAll();
                }
            }

            Rectangle {
                anchors.top: heading.bottom
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                border.width: 2
                border.color: AppearanceProvider.textColorSecondary
                color: AppearanceProvider.inactiveColor
                radius: AppearanceProvider.rounding
                height: 360

                NotificationList {
                    anchors.fill: parent
                }

            }

        }

    }

}
