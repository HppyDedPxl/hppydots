import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Item {
    id: root
    required property var notification
    implicitHeight:card.height + 10
    property var displayTimeout: 3000
    property var onShowAnimFinished: ()=>{}

    // ~~~ Begin
    // Assemble parts of a clipping mask
    // So we can create an array of regions
    // to make an accurate mouse blocking mask
    // for a potential popup window that will
    // display those on screen
    property var getRegion: ()=>{
        return cardClippingRegion;
    }
    Region {
        id:cardClippingRegion
        item:mouseClippingRectangle
    }
    Rectangle{
        id:mouseClippingRectangle
        anchors.fill:item
        color:'transparent'
    }
    /// ~~~ End

    Item {
        id: item
        anchors.top:parent.top
        anchors.bottom:parent.bottom
        anchors.left:parent.left
        anchors.right:parent.right

        anchors.topMargin:20
        anchors.bottomMargin:20
        anchors.rightMargin:20
        anchors.leftMargin:20

        Timer{
            id: displayTimeoutTimer
            interval: displayTimeout
            running:false
            onTriggered : {
                hideAnimation.onAnimDone = ()=>{NotificationHandler.removeDisplayNotification(notification)}
                hideAnimation.start()
            }
        }
        ScaleAnimator {
            target: item
            from:0
            to:1
            duration: 1000
            running: true
            easing.type: Easing.OutElastic
            onFinished:{
                if(notification.actions.length == 0 && notification.urgency <= 1)
                    displayTimeoutTimer.running = true
                    onFinished:{
                        onShowAnimFinished()
                    }
            }
        }

        ScaleAnimator {
            target: item
            id: hideAnimation
            from:1
            to:0
            duration: 100
            running: false
            easing.type: Easing.InOutQuad
            property var onAnimDone : ()=>{}
            onFinished: {
                onAnimDone()
            }
        }

        NotificationCard {
            id: card
            notification: root.notification
            onDismiss: ()=>{
                hideAnimation.onAnimDone = ()=>{NotificationHandler.dismissNotification(notification)}
                hideAnimation.start()
            }   
        }


    }

}
