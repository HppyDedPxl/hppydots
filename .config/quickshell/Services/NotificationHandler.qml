pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Notifications

Singleton {
    id: notificationHandler

    ScriptModel{
        id:backlogNotifications
    }

    ScriptModel{
        id:displayNotifications
    }
    
    function wrapCopyNotification(_notification){
        let obj = 
        {   
            id: _notification.id,
            appIcon : _notification.appIcon,
            image : _notification.image,
            summary : _notification.summary,
            body : _notification.body,
            resident : _notification.resident,
            urgency : _notification.urgency,
            notification: _notification
        }
        return obj
    }

    function dismissAll(){
        displayNotifications.values = []
        while(backlogNotifications.values.length>0){
            console.log(backlogNotifications.values[0])
            if(backlogNotifications.values[0] != null){
                dismissBacklogNotification(backlogNotifications.values[0])
            }
        }
    }

    function getDisplayNotifications(){
        return displayNotifications;
    }

    function getNotificationBacklog(){
        return backlogNotifications;
    }

    function dismissBacklogNotification(notification){
        let i = backlogNotifications.values.findIndex(x=>x.id == notification.id)
        if(i >= 0)
        {
            if(backlogNotifications.values[i].notification){
                backlogNotifications.values[i].notification.dismiss()
            }
            backlogNotifications.values = backlogNotifications.values.filter(x => x.id !== notification.id)
        }
    }

    function removeDisplayNotification(notification){
        displayNotifications.values = displayNotifications.values.filter(x => x.id !== notification.id)
        // if the notification is transient its also not in the backlog, so we need to dismiss it entirely
        if(notification.transient)
            notification.dismiss()
    }

    function dismissNotification(notification){
        displayNotifications.values = displayNotifications.values.filter(x => x.id !== notification.id)
        dismissBacklogNotification(notification);
    }

    function getAmountOfNotifications(){
        return backlogNotifications.values.length;
    }

    NotificationServer {
        id: notificationServer
        persistenceSupported: true
        actionsSupported: true
        imageSupported: true
        onNotification:notification=>{
            notification.tracked = true
            if(!notification.lastGeneration){
                
                displayNotifications.values.push(wrapCopyNotification(notification))
                backlogNotifications.values.push(wrapCopyNotification(notification))
            }
        }
    }

}