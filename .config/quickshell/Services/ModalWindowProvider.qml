pragma Singleton
import QtQuick
import Quickshell
Singleton {
    id:modalWindowProvider
    property var widgets : ({})

    function showModalOnScreen(screen,component){
        console.log("widgets:" + widgets)
        //if(widgets[screen.name] !== undefiend){
            widgets[screen.name].show(component);
        //}
    }

    function registerModalComponent(screen, modalComponent){
        console.log("Registering modal component");
        widgets[screen.name] = modalComponent
    }
}