pragma Singleton
import QtQuick
import Quickshell
import "../Modules"

Singleton {
    id: popupObserver

    property list<var> popups : []

    function registerOpenPopup(popup) {
        if(popups.indexOf(popup)==-1)
            popups.push(popup);
    }

    function deregisterOpenPopup(popup) {
        popups.splice(popups.indexOf(popup),1);
    }

    function isAnyPopupOpen() {
        return popups.length > 0;
    }

    function isAnyPopupOpenOnBar(bar) {
        return popups.find(((x)=>{
            if(!x)
                return false
            return x.targetBar == bar;
        }));
    }
}