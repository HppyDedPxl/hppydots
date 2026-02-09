pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
Singleton {
    id: packagesHandler

    property var amountPendingPackageUpdates:0

    function initService(){
        timer.running=true
        getPackageUpdatesProc.running=true
    }

    Timer{
        id: timer
        interval: 10000*1800 // check every 30 minutes after start
        running: false
        repeat:true
        onTriggered:{
            getPackageUpdatesProc.running=true;
        }
    }

    Process {
        id: getPackageUpdatesProc
        command: ["sh","-c","(checkupdates && yay -Qua) | wc -l"]
        running: false

        stdout: StdioCollector {
            onStreamFinished: {
                amountPendingPackageUpdates=this.text
            }
        }
    }
}