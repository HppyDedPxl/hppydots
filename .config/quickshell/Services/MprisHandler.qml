pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Mpris
import Quickshell.Hyprland

Singleton {
    id: mprisHandler

    property var primaryActivePlayer : null;

    function initService() {

    }

    function getPrimaryPlayer(){
        if(Mpris.players.values.length > 0)
            return Mpris.players.values[0]
        return null;
    }

    function getPlayingPlayer() {
        for (let i = 0; i < Mpris.players.values.length; i++){
            if(Mpris.players.values[i].isPlaying){
                return Mpris.players.values[i];
            }
        }
        return null;
    }

    function getPlayerByName(name) {
        for (let i = 0; i < Mpris.players.values.length; i++){
            if(Mpris.players.values[i].desktopEntry === name){
                return Mpris.players.values[i];
            }
        }
        return null;
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            console.log(Mpris.players.values[0].desktopEntry)
        }
    }
}
