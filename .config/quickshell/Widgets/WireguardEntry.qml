
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
            StyledButton {
                Layout.fillHeight:true
                color:AppearanceProvider.backgroundColor
                hoverColor:AppearanceProvider.activeColor
                textColor:AppearanceProvider.textColor
                hoverTextColor:AppearanceProvider.activeTextColor
                text: VPNHandler.isConnected() ? "Disconnect" : "Connect"
                fontSize:12
                onClick:()=>{
                    if(VPNHandler.isConnected())
                        VPNHandler.disconnect()
                    else
                        VPNHandler.connectToInterface(interfaceName)
                }
            }
        }
        
    }   
}
