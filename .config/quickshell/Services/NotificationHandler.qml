pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Notifications

Singleton {
    id: notificationHandler

    ScriptModel{
        id:displayNotifications
    }
    ScriptModel {
        id:notificationBacklog
    }

    function getDisplayNotifications(){
        return displayNotifications;
    }

    function getNotificationBacklog(){
        return notificationBacklog;
    }

    function removeDisplayNotification(notification){
        displayNotifications.values = displayNotifications.values.filter(x => x !== notification)
        // if the notification is transient its also not in the backlog, so we need to dismiss it entirely
        if(notification.transient)
            notification.dismiss()
    }

    function dismissNotification(notification){
        displayNotifications.values = displayNotifications.values.filter(x => x !== notification)
        notificationBacklog.values = notificationBacklog.values.filter(x => x !== notification)
        notification.dismiss();
    }

    function getAmountOfNotifications(){
        return notificationBacklog.values.length;
    }

    NotificationServer {
        id: notificationServer
        onNotification:notification=>{
            notification.tracked = true
            if(!notification.transient)
                notificationBacklog.values.push(notification)
            displayNotifications.values.push(notification)

            console.log("~~~Received Notification~~~")
            console.log("summary: " + notification.summary)
            console.log("body: " + notification.body)
            console.log("actions:" + notification.actions)
            console.log("transient:" + notification.transient)
            console.log("inlineReply?:" + notification.hasInlineReply)
            console.log("urgency: " + notification.urgency)
            
        }
    }

}