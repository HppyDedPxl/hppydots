import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick.Shapes
import QtQuick.Effects
import "./"
import "../Services"
import "../Appearance"
import "../Widgets"

BaseModule {
    id:baseModule
    dbgName: "mprisModule"
    content: _content
    popupContent: _popupContent
    doPopupScaleAnimation:false
    bPopupSupportsAttachment:true
    popupAttachmentSlotSize:60
    popupAttachment : musicViz

    visible: true
    Component {
        id: _content
        StyledSidebarDock {
            visible: MprisHandler.getPrimaryPlayerUnsafe() != null
            content: Rectangle {
                id: innerRect
                color : 'transparent'
                anchors.centerIn:parent
                width: parent.width-10
                height: width
                radius:width/2
                clip: true
                Image {
                    anchors.fill:parent
                    source: Quickshell.iconPath(DesktopEntries.heuristicLookup(MprisHandler.getPrimaryPlayerUnsafe().identity).icon)
                }
            }            
        }
    }

    Component {
        id: _popupContent

        Rectangle {
            function getAudioIcon(volume) {
                if (volume > .7)
                    return "";
                if (volume > .3)
                    return "";
                return "";
            }

            id: base
            height: 600
            width: 300
            color:'transparent'
            property var player : MprisHandler.getPrimaryPlayer()
            property var onOpen : ()=>{
                loader.item.seekBar.updateTime()
            }

            Loader {
                id: loader
                active : player != null
                sourceComponent: MprisWidget {
                    height:base.height
                    width:base.width
                }
            }
        }
    }

    Component {
        id:musicViz
        Rectangle {
            id:rec
            color:'transparent'
            MusicViz {
                width:parent.width
                height:parent.height
                orientation: baseModule.orientation
                gradient: LinearGradient {
                    GradientStop {
                        color: AppearanceProvider.backgroundColorSecondary
                    }
                }
            }   
        }
    }
}