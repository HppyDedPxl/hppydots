import Quickshell
import QtQuick.Layouts
import Quickshell.Networking
import Quickshell.Services.SystemTray
import QtQuick
import "../Appearance"
import "../Services"

BaseModule{
    id: baseModule
    dbgName: "bluetooth Module"
    width: 27
    content: _content
    property var contentAnchor: _contentAnchor
    property var mouseArea : mArea
    popupContent : null
    bHasClickAction: true

    property QsMenuAnchor openedMenu: menuAnchor

    function openNmApplet(anchor){
        for(var i = 0; i < SystemTray.items.values.length; i++){
            if(SystemTray.items.values[i].id == "nm-applet"){
                menuAnchor.menu = SystemTray.items.values[i].menu;
               var global = anchor.mapToGlobal(anchor.x, anchor.y);
                global.x-=scope.modelData.x
                global.y-=scope.modelData.y
                win.anchor.rect.x = global.x;
                win.anchor.rect.y = global.y;
                win.visible = true;
                menuAnchor.open();

            }
        }
    }

    function getNetwork(){
        var device = null;
        // Find a device that is currently connected:
        for(var i = 0; i < Networking.devices.values.length; i++){
            if(Networking.devices.values[i].state == ConnectionState.Connected){
                console.log("sadjasd")
                device = Networking.devices.values[i];
                break;
            }
        }
        
        if ( device == null) device = Networking.devices.values[i];

        var deviceType = device.type;
        var connectionState = device.state;

        if (deviceType == DeviceType.None){
            return "X";
        }
        else if (deviceType == DeviceType.Wifi){
            return connectionState == ConnectionState.Connected ? "" : "󰖪"
        }
        else if (deviceType == DeviceType.Wired){
            return connectionState == ConnectionState.Connected ? "󰈀" : "󰌙";
        }
        return "";
    }


    function modAlpha(color, alphaChange){
        let c = Object.assign({},color)
        c.a -= alphaChange
        return c;
    }

    function modHsvValue(color, valueChange){
        let c = Object.assign({},color)
        c.hslLightness -= valueChange
        return c;
    }

  // Dummy Elements to Anchor the context menu for the tray icons in
    // ~~ Begin
    PopupWindow {
        id: win
        anchor.window: topBar
        implicitWidth: 1
        implicitHeight: 1
        visible: false
        color: 'red'
        Text {
        }
    }
    QsMenuAnchor {
        id: menuAnchor
        anchor.window: win
        onClosed: {
            win.visible = false;
            baseModule.bInhibitClose = false;
        }
    }
    // ~~ End

     Component {
        id: _content
        MouseArea {
            id: mArea
            anchors.fill : parent
            onClicked: openNmApplet(_contentAnchor)
        
            Rectangle{
                id: _contentAnchor
                anchors.fill : parent
                color: 'transparent'
                Item{
                    id:img
                }
                StyledText {
                    anchors.centerIn:  parent
                    color: baseModule.textColorOnBar
                    font.pointSize: AppearanceProvider.primaryFontSize + 1
                    
                    text: getNetwork();
                }
                
                
            }  
        }  
    }

}