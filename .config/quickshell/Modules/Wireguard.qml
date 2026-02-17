import QtQuick
import QtQuick.VectorImage
import Quickshell
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import "../Services"
import "../Appearance"
import "../Widgets"

BaseModule {
    id: baseModule
    dbgName: "wgModule"
    width:parent.height
    content: _content
    popupContent: _popupContent

    Component {
        id: _content
        Rectangle {
            anchors.top:parent.top
            anchors.left:parent.left
            anchors.right:parent.right
            anchors.bottom:parent.bottom
            anchors.margins: 5
            width:parent.height
            color:'transparent'
            opacity: VPNHandler.isConnected() ? 1.0 : 0.3
            VectorImage {
                anchors.fill:parent          
                source:"../Assets/wgico.svg"
                fillMode: Image.PreserveAspectFit
                layer.enabled: true
                layer.effect: MultiEffect {
                    brightness: 1.0
                    colorization: 1.0
                    colorizationColor: baseModule.textColorOnBar
                }
            }
        }
    }

    Component {
        id: _popupContent
        Rectangle {
            height: VPNHandler.isConnected() ? 125 : 300
            width: 330
            color: 'transparent'
            ColumnLayout {
                anchors.top:parent.top
                anchors.bottom:parent.bottom
                anchors.right:parent.right
                anchors.left:parent.left
                anchors.topMargin: 15
                anchors.bottomMargin: 15
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                StyledText{
                    Layout.fillWidth:true
                    //Layout.preferredWidth:30
                    text: VPNHandler.isConnected() ? "Connected to:" : "Not connected."
                }
                WireguardEntryWidget {
                    visible : VPNHandler.isConnected()
                    interfaceName: VPNHandler.connectedInterface
                }
                ScrollView {
                    visible : !VPNHandler.isConnected()
                    width:parent.width
                    Layout.fillHeight:true
                    contentWidth: parent.width
                    contentHeight: content.height
                    ColumnLayout {
                        id: content
                        width:parent.width
                        property var buttonHeight : 65
                        spacing:5
                        height: (repeater.count) * (buttonHeight+spacing)
                        Repeater {
                            id: repeater
                            model: VPNHandler.getVPNConfigs()
                            WireguardEntryWidget {
                                required property var modelData
                                interfaceName: modelData
                            }
                            
                        }
                    }

                }
                Item {
                    Layout.fillHeight:true
                }
                
            }
            property var onPopupOpened : ()=>{
                VPNHandler.loadWireguardConfs()
            }
            
        }
    }
}