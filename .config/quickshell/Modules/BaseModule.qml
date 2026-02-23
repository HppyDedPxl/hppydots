import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import Quickshell
import Quickshell.Io // for Process
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
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
    property bool bInhibitClose: false
    property bool bOpenClicked:false
    property bool bHasClickAction:false
    property list<string> onClickExecCommand : []
    property color textColor: AppearanceProvider.textColor
    property color textColorOnBar: textColor
    property color usedBackgroundColor: AppearanceProvider.backgroundColor
    readonly property var targetBar : parent.parent
    readonly property var orientation : targetBar.orientation
    property var hyprlandOpenShortcut: ""
    property var region: Region {}
    
    property var isPopupOpen:()=>{
        return popup.bOpen
    }

    property alias loadedBarContent : mainContent.item
    property alias loadedPopupContent : popup.loadedContent

    property var onPopupStartOpen: null
    property var onPopupOpened: null
    property var onPopupStartClosing : null
    property var onPopupClosed: null


    function hasPopupContent(){
        return popupContent != null;
    }

    function isOnActiveMonitor(){
        return Hyprland.focusedMonitor.name == modelData.name;
    }


    Loader {
        active: hyprlandOpenShortcut.length > 0
        sourceComponent : GlobalShortcut{
            name:hyprlandOpenShortcut
            onPressed:{
                if(isOnActiveMonitor())
                {
                    // If we are in a fullscreen application we generally want to disable the fullscreen
                    // mode. Firstly we dont need to have the popup on an overlay layer then, but secondly
                    // when starting a new application that will then not disappear behind the fullscreen
                    // window
                    if(SystemInfo.activeWindow['fullscreen'] > 0)
                        Hyprland.dispatch("fullscreen")
                    openPopup()
                }
            }
        }
    }
    

    property var mainContentLoader: mainContent

    function openPopup() {
        if( popupContent != null){
            popup.visible=true
            popup.openOnClick()
        }
    }

    function closePopup() {
        popup.hyprlandGrabber.active=false
    }
    
    height: orientation % 2 == 0 ? parent.height : width
    width: mainContent.item ? mainContent.item.width : 0
    
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
        orientation: baseModule.orientation
        targetBar:baseModule.targetBar
        onPopupStartOpen: ()=>{
            if(baseModule.onPopupStartOpen)
                baseModule.onPopupStartOpen();
            if(loadedBarContent && loadedBarContent.onPopupStartOpen)
                loadedBarContent.onPopupStartOpen()
            if(loadedPopupContent && loadedPopupContent.onPopupStartOpen)
                loadedPopupContent.onPopupStartOpen()
        }
        onPopupOpened:()=>{
            // We want to propagate the event to every level
            // if any of those elements implements this property we call it
            if(baseModule.onPopupOpened)
                baseModule.onPopupOpened();
            if(loadedBarContent && loadedBarContent.onPopupOpened)
                loadedBarContent.onPopupOpened()
            if(loadedPopupContent && loadedPopupContent.onPopupOpened)
                loadedPopupContent.onPopupOpened()
            
        }
        onPopupStartClosing:()=>{
            if(baseModule.onPopupStartClosing)
                baseModule.onPopupStartClosing();
            if(loadedBarContent && loadedBarContent.onPopupStartClosing)
                loadedBarContent.onPopupStartClosing()
            if(loadedPopupContent && loadedPopupContent.onPopupStartClosing)
                loadedPopupContent.onPopupStartClosing()
        }
        onPopupClosed:()=>{
            if(baseModule.onPopupClosed)
                baseModule.onPopupClosed();
            if(loadedBarContent && loadedBarContent.onPopupClosed)
                loadedBarContent.onPopupClosed()
            if(loadedPopupContent && loadedPopupContent.onPopupClosed)
                loadedPopupContent.onPopupClosed()
        }
    }

    Loader {
        id: mainContent
        anchors.fill: parent
        active: true
        sourceComponent: content
        onLoaded: {
            baseModule.region.item = mainContent.item
        }
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


