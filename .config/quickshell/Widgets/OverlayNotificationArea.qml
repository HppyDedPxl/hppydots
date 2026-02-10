import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland

PanelWindow {
    screen: scope.modelData
    anchors {
        right: true
        top: true
        bottom: true
    }
    width:350
    exclusiveZone: 0
    id: window
    visible:true
    property list<Item> activePopups: []
    property list<Region> activeRegions: []
    property var spacing: 5
    WlrLayershell.layer: WlrLayer.Overlay
    color: 'transparent'
    mask: Region { id: cutoutRegion; regions: activeRegions; }
    property var isOnFocusedWindow: Hyprland.focusedMonitor.name == modelData.name
    function updateMask(){
        activeRegions = []     
        for (var i = 0; i < activePopups.length; i++){
            if(activePopups[i] !== null)
                activeRegions.push(activePopups[i].getRegion())
        }
        cutoutRegion.regions = activeRegions;
        window.mask = cutoutRegion;
    }
    Item {
        anchors.fill:parent
        opacity: isOnFocusedWindow ? 1 : 0
        Behavior on opacity {
            NumberAnimation{
                duration:250
            }
        }

        Repeater {
                id: rp

                model: NotificationHandler.getDisplayNotifications()

                onItemAdded:(idx,item)=> {
                    activePopups.push(item.item)
                    activeRegions.push(item.item.getRegion())

                }
                onItemRemoved:(idx)=>{
                    activePopups.splice(idx,1)
                    activeRegions.splice(idx,1)
                }

                

                Loader {
                    required property var modelData
                    required property var index
                    active: true

                    function getYForIndex(idx){
                        if(idx == 0){
                            return 0
                        } 
                        if(window.activePopups[idx-1] == undefined){
                            return 0
                        }
                        return window.activePopups[idx-1].y + window.activePopups[idx-1].height + window.spacing
                    }
                    sourceComponent: Component {
                        NotificationPopup {
                            id: _popupInside
                            anchors.top: window.top
                            anchors.left: window.left
                            anchors.right: window.right
                            notification: modelData            
                            y: getYForIndex(index)
                            width: window.implicitWidth
                            Behavior on y {
                                SequentialAnimation {
                                    NumberAnimation {
                                        duration: 200
                                    }
                                    ScriptAction {
                                        script:window.updateMask()
                                    }
                                }
                            }
                            onShowAnimFinished:()=>{
                                window.updateMask()
                            }
                        }
                    }
                }

            }
    }

  

}
