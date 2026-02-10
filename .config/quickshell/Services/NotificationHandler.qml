pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Notifications

Singleton {
    id: notificationHandler

    ScriptModel{
        id:displayNotifications
    }
    
    function dismissAll(){
        displayNotifications.values = []
        while(notificationServer.trackedNotifications.values.length>0){
            if(notificationServer.trackedNotifications.values[0] !== null){
                notificationServer.trackedNotifications.values[0].dismiss()
            }
        }
    }

    function getDisplayNotifications(){
        return displayNotifications;
    }

    function getNotificationBacklog(){
        return notificationServer.trackedNotifications;
    }

    function removeDisplayNotification(notification){
        displayNotifications.values = displayNotifications.values.filter(x => x !== notification)
        // if the notification is transient its also not in the backlog, so we need to dismiss it entirely
        if(notification.transient)
            notification.dismiss()
    }

    function dismissNotification(notification){
        displayNotifications.values = displayNotifications.values.filter(x => x !== notification)
        notification.dismiss();
    }

    function getAmountOfNotifications(){
        return notificationServer.trackedNotifications.values.length;
    }

    NotificationServer {
        id: notificationServer
        persistenceSupported: true
        actionsSupported: true
        imageSupported: true
        onNotification:notification=>{
            notification.tracked = true
            console.log(notification.actions)
            if(!notification.lastGeneration)
                displayNotifications.values.push(notification)
        }
    }

}