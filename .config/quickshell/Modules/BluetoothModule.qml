import Quickshell
import Quickshell.Bluetooth
import QtQuick
import "../Appearance"
import "../Services"

BaseModule{
    id: baseModule
    dbgName: "bluetooth Module"
    width: 30
    content: _content
    popupContent : null
    bHasClickAction: true
    onClickExecCommand: ["blueman-manager"]
    function getBT(){
        var iState = 0;
        if (Bluetooth.adapters.values.length > 0) 
        {
            iState = Bluetooth.adapters.values[0].state;
        }
            
        var state = BluetoothAdapterState.toString(iState);
        switch(iState){
            case 0:
                return "󰂲";
            case 1:
                return "󰂯";
            case 2:
            case 3:
                return "󰂳";
            case 4:
                return "󰂲";
        }
        return state;
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

     Component {
        id: _content

        Rectangle{
            anchors.fill : parent
            color: 'transparent'
            StyledText {
                anchors.centerIn:  parent
                color: Bluetooth.adapters.values[0].state == 1 ? baseModule.textColorOnBar : modAlpha(baseModule.textColorOnBar,0.7)
                font.pointSize: AppearanceProvider.primaryFontSize + 2
                
                text: getBT();
            }
        }    
    }

}