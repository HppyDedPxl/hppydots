pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Services.Mpris
import Quickshell.Hyprland

Singleton {
    id: mprisHandler

    property var primaryActivePlayerIndex : -1

    function initService() {
        getPrimaryPlayer();
    }

    function hasPreviousPlayer() {
        return primaryActivePlayerIndex > 0;
    }

    function previousPlayer() {
        if(Mpris.players.values.length == 0)
            primaryActivePlayerIndex = -1;
        if(primaryActivePlayerIndex > 0)
            primaryActivePlayerIndex--;
        else
            primaryActivePlayerIndex = Mpris.players.values.length-1;
    }

    function hasNextPlayer() {
        return primaryActivePlayerIndex < Mpris.players.values.length -1
    }

    function nextPlayer() {
        if(Mpris.players.values.length == 0)
            primaryActivePlayerIndex = -1
        if(primaryActivePlayerIndex < Mpris.players.values.length-1)
            primaryActivePlayerIndex++;
        else
            primaryActivePlayerIndex = 0;      
    }

    function getPrimaryPlayer() {
        if (Mpris.players.values.length == 0) {
            primaryActivePlayerIndex = -1
            return null
        }
        if (primaryActivePlayerIndex >= Mpris.players.values.length) {
            primaryActivePlayerIndex = Mpris.players.values.length
        }
        if (primaryActivePlayerIndex == -1) {
            primaryActivePlayerIndex = 0
        }
        return Mpris.players.values[primaryActivePlayerIndex]
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

    function updateToFirstPlayingPlayer(){
        if(primaryActivePlayerIndex < 0 || primaryActivePlayerIndex >= Mpris.players.values.lengt)
            return;
        if (!Mpris.players.values[primaryActivePlayerIndex].isPlaying){
            for (let i = 0; i < Mpris.players.values.length; i++){
                if(Mpris.players.values[i].isPlaying){
                    primaryActivePlayerIndex = i;
                }
            }
        }
    }
}
