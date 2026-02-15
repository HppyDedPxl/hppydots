import Quickshell
import QtQuick
import "../Appearance"
import "../Services"

BaseModule{
    id: baseModule
    dbgName: "batteryModule"
    width: 55
    visible: SystemInfo.bHasBattery
    content: _content
    popupContent : null

    property var iconLookupNotCharging:[
        [98,"󰁹"],
        [90,"󰂂"],
        [80,"󰂁"],
        [70,"󰂀"],
        [60,"󰁿"],
        [50,"󰁾"],
        [40,"󰁽"],
        [30,"󰁼"],
        [20,"󰁻"],
        [10,"󰁺"],
        [0,"󰂎"]
    ]

    function getBatteryDischargingIcon(capacity){
   
        for (let i = 0; i < iconLookupNotCharging.length; i++){
            if(capacity > iconLookupNotCharging[i][0]){
                return iconLookupNotCharging[i][1]
            }
        }
    }

    function getBatteryStateIcon(){
        if (SystemInfo.batteryStatus.toString() == "Not charging"){
            return ""
        }
        if (SystemInfo.batteryStatus == "Discharging" || SystemInfo.batteryStatus == "Full")
            return getBatteryDischargingIcon(SystemInfo.batteryPercentage)
        if (SystemInfo.batteryStatus == "Charging")
            return "󰂄"
        
        return SystemInfo.batteryStatus 
    }

    Component {
        id: _content

    Rectangle{
        anchors.fill : parent
        color: 'transparent'
            StyledText {
                anchors.centerIn:  parent
                color:baseModule.textColorOnBar
                text: SystemInfo.batteryPercentage + "% " + getBatteryStateIcon()
            }
    }
            
        
    }

}