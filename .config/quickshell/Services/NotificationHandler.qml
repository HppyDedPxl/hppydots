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
        }
        return obj
    }

    function dismissAll(){
        displayNotifications.values = []
        while(backlogNotifications.values.length>0){
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
            dismissNotificationOnServerById(notification.id)
            backlogNotifications.values = backlogNotifications.values.filter(x => x.id !== notification.id)
        }
    }

    function dismissNotificationOnServerById(){
        for (let i = 0; i < notificationServer.trackedNotifications.values.length; i++){
            notificationServer.trackedNotifications.values[i].dismiss()
        }
    }

    function removeDisplayNotification(notification){
        displayNotifications.values = displayNotifications.values.filter(x => x.id !== notification.id)
        // if the notification is transient its also not in the backlog, so we need to dismiss it entirely
        if(notification.transient)
            dismissNotificationOnServerById(notification.id)
    }

    function dismissNotification(notification){
        displayNotifications.values = displayNotifications.values.filter(x => x.id !== notification.id)
        dismissBacklogNotification(notification);
    }

    function getAmountOfNotifications(){
        return backlogNotifications.values.length;
    }

    function notificationExistsOnServer(notification){
        for (let i = 0; i < notificationServer.trackedNotifications.values.length; i++){
            if(notificationServer.trackedNotifications.values[i].id == notification.id)
            return true;
        }
        return false
    }

    function removeOrphanedNotifications(){
        for(let i = 0; i< backlogNotifications.values.length; i++){
            if(!notificationExistsOnServer(backlogNotifications.values[i]))
            {
                backlogNotifications.values.splice(i,1)
                i--
            }
        }
    }

    Timer {
        interval: 2000
        running:true
        repeat: true
        onTriggered: {
            removeOrphanedNotifications()
        }
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