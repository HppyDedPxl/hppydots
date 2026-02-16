
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
        anchors.topMargin : 5
        anchors.leftMargin : 5
        anchors.rightMargin : 15
        anchors.bottomMargin: 5
        radius: AppearanceProvider.rounding / 2
        color: AppearanceProvider.backgroundColor
        RowLayout {
            anchors.left : parent.left
            anchors.right : parent.right
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
                color:AppearanceProvider.inactiveColor
                hoverColor:AppearanceProvider.activeColor
                textColor:AppearanceProvider.inactiveTextColor
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
