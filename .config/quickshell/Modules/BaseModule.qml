import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io // for Process
import Quickshell.Widgets

Rectangle {
    id: baseModule
    Layout.fillWidth:false

    required property Component content
    property Component popupContent
    property string dbgName: "baseModule"
    property bool bPopupOnHover:false
    property double popupOverrideWidth: -1
    property bool bIsHovered : false
    property bool bDoHighlight: true
    property bool popupOpen: false
    property bool bInhibitClose: false
    property bool bOpenClicked:false
    property bool bHasClickAction:false
    property list<string> onClickExecCommand : []
    property color textColor: AppearanceProvider.textColor
    property color textColorOnBar: textColor
    property color usedBackgroundColor: AppearanceProvider.backgroundColor

    function openPopup() {
        popup.visible=true
        popup.openOnClick()
    }

    function closePopup() {
    }
    
    height: parent.height
    width:mainContent.width
    color: "transparent"

    states: [
        State {
            name: "closed"
            when: (bPopupOnHover && (!baseModule.bIsHovered && !popup.bIsHovered && !bInhibitClose)) || (!bPopupOnHover && !popup.hyprlandGrabber.active && !bInhibitClose)
               PropertyChanges {
                popup {
                    bOpen: false
                    visible:false
                }
            }
        }, 
        State {
            name: "open"
            when: (bPopupOnHover && (baseModule.bIsHovered == true || popup.bIsHovered == true)) || bInhibitClose == true || popup.hyprlandGrabber.active

            PropertyChanges {
                popup {
                    bOpen: true
                    visible:true
                }
            }
        }
    ]
    transitions: [
        Transition {
            from: "closed"
            to: "open"
        },
        Transition {
            from: "open"
            to: "closed"
            NumberAnimation {
                properties: "visible"
                duration:AppearanceProvider.popoutAnimDuration*2
                easing.type: Easing.InOutQuad
            }

        },
    ]

    Rectangle {
        id: background
        anchors.fill:parent
        color:'transparent'

        states: [
            State {
                name: "highlit"
                when: baseModule.bIsHovered && baseModule.bDoHighlight
                PropertyChanges {
                    baseModule {
                        textColorOnBar: AppearanceProvider.highlightColor
                    }
                }
            }
        ]
        transitions:[
            Transition{
                from:"*"
                to:"highlit"
                reversible: true

                PropertyAnimation {
                    properties:"baseModule.textColorOnBar"
                    duration:200
                    easing.type: Easing.InOutQuad
                }
            }

        ]
    }

    Popout {
        id: popup
        content: popupContent
        overrideWidth: popupOverrideWidth
    }

    Loader {
        id: mainContent
        anchors.fill: parent
        active: true
        sourceComponent: content
    }
    Process {
        id: onClickAction
        command: onClickExecCommand
    }

    MouseArea {
        id: mouse
        cursorShape: bHasClickAction || (!bPopupOnHover  && popupContent !== null) ? Qt.PointingHandCursor : Qt.ArrowCursor
        

        anchors.fill: baseModule
        enabled: {
            popupContent !== null || bHasClickAction;
        }
        hoverEnabled: true
        onEntered: {
            bIsHovered = true;
        }
        onExited: {
            bIsHovered = false;
        }
        onClicked: {

            if (bHasClickAction){
                onClickAction.startDetached();
            }
            else if(!bPopupOnHover){
                openPopup();
            }
        }
    }
}


