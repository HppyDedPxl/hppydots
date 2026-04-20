
import QtQuick
import Quickshell
import QtQuick.Controls
import QtQuick.Layouts
import "../Appearance"
import "../Services"
Rectangle {
    required property var interfaceName

    width:parent.width
    color:'transparent'
    height:content.buttonHeight
    Rectangle {
        anchors.left : parent.left
        anchors.right : parent.right
        anchors.top : parent.top
        anchors.bottom : parent.bottom
        radius: AppearanceProvider.rounding / 2
        color: AppearanceProvider.inactiveColor
        RowLayout {
            anchors.left : parent.left
            anchors.right : parent.right
            anchors.top : parent.top
            anchors.leftMargin : 15
            anchors.rightMargin : 0
            height:parent.height
            StyledText {
                Layout.fillHeight:true
                text: interfaceName
                color: AppearanceProvider.inactiveTextColor
            }
            Item{
                Layout.fillHeight:true
                Layout.fillWidth:true
            }
            StyledToggle {
                Layout.preferredHeight:parent.height/2
                onToggledOn:()=>{
                    VPNHandler.connectToInterface(interfaceName)
                }
                onToggledOff:()=>{
                    VPNHandler.disconnect()
                }
                bIsEnabled: !VPNHandler.isConnected() || VPNHandler.connectedInterface == interfaceName 
                bIsToggledPersistent: VPNHandler.connectedInterface == interfaceName 
                Layout.preferredWidth:height*2
            }
            Item{
                Layout.preferredWidth:5
            }
        }
        
    }   
}
