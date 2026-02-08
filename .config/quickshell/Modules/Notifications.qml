import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import "./"
import "../Appearance"
import "../Services"
import "../Widgets"

BaseModule{
    id:baseModule
    content: _content
    popupContent: _popupContent

    Component{
        id:_content
        Rectangle {
            id:root
            color:'transparent'
                    StyledBarIcon{
                        id:icon
                        text:"󰎟"
                    }
                    StyledAlertCount {
                        targetIcon:icon
                        count:NotificationHandler.getAmountOfNotifications()
                    }
        }
    }


    // Todo:// add "dismiss all" and "dnd" buttons
    Component{
        id:_popupContent
        Rectangle {
            id: popupRoot
            height:420
            width:400
            color:'transparent'
                StyledText {
                    anchors.top : parent.top
                    anchors.left: parent.left
                    anchors.topMargin:10
                    anchors.leftMargin:20
                    id: heading
                    text: "Notification Center"
                }
                Rectangle{
                    anchors.top:heading.bottom
                    anchors.topMargin: 10
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin:20
                    anchors.leftMargin:20
                    border.width:2
                    border.color:AppearanceProvider.textColorDark
                    color: AppearanceProvider.inactiveColor
                    radius: AppearanceProvider.rounding               
                    height:360
                    NotificationList {
                        anchors.fill:parent
                    }
                }
            
            
        }
    }
}
