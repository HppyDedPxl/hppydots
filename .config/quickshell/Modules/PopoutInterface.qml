import "../Appearance"
import "../Services"
import "./"
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

PopupWindow {
    id: root
    property var margin: AppearanceProvider.rounding
    property var bIsHovered: hoverHandler.hovered
    property Component content
    property var bOpen: false
    property var bOpenOnHover: false
    property var hyprlandGrabber: grab
    property double overrideWidth: -1
    property double baseWidth: overrideWidth > 0 ? overrideWidth : width
    property var targetBar: null
    property var orientation: 0
    property var _autoFocusItem: null
    property var bFixedAttachment : null
    property var supportsAttachment : false
    property var attachmentSize : 0

    property var onPopupStartOpen: ()=>{}
    property var onPopupOpened: ()=>{}
    property var onPopupStartClosing : ()=>{}
    property var onPopupClosed: ()=>{}    
    property alias loadedContent : internalPopout.loadedContent
    property alias attachmentRect : internalPopout.attachmentRect
    property var attachment : null

    readonly property alias c : internalPopout.loader

    property var doScaling : true

    property var isClosing : false;

    signal ready


    color: 'transparent'


    function openOnClick() {
        grab.active = true;
    }

    function close() {
        if (grab.active)
            grab.active = false;
    }

    function calculateAnchorX() {
        console.log(bFixedAttachment)
        if(bFixedAttachment != null)
            return bFixedAttachment[0] + - (width / 2)
        if (root.orientation == 0 || root.orientation == 2) 
            return baseModule.x + (baseModule.width / 2) - (width / 2);
        else if (root.orientation == 1)
            return AppearanceProvider.getEffectiveScreenWidth(targetBar.screen)-root.width
        else if (root.orientation  == 3)
            return 0
    }

    function calculateAnchorY() {
        if(bFixedAttachment != null)
            return bFixedAttachment[1] -1
        if (root.orientation == 0)
            return targetBar.height;

        if (root.orientation == 2)
            return -calculateImplicitHeight() + calculateParentPadding();

        if (root.orientation == 1 || root.orientation == 3){
            return   -targetBar.height + (baseModule.y + margin*2 + baseModule.height) -  calculateImplicitHeight()/2
        }
    }

    function calculateImplicitWidth(){
        if(orientation == 0 || orientation == 2)
            return  (overrideWidth > 0 ? overrideWidth : c.width) + margin * 2;
        else{
            return c.width + AppearanceProvider.shadowBlur + (supportsAttachment ? root.attachmentSize : 0);
        }
    }

    function calculateImplicitHeight() {
        if(orientation == 0 || orientation == 2)
            return c.height + AppearanceProvider.shadowBlur + (supportsAttachment ? root.attachmentSize : 0);
        else{
            return (overrideWidth > 0 ? overrideWidth : c.height) + margin * 2;
        }
    }

        // todo, everything for side bars left right :) this will be fun
    anchor.window: orientation == 0 ? topBar : bottomBar
    anchor.rect.x: calculateAnchorX()
    anchor.rect.y: calculateAnchorY()
    implicitWidth: calculateImplicitWidth()
    implicitHeight: calculateImplicitHeight()


    NotchPopout {
        id: internalPopout
        root: root
    }

    HoverHandler {
        id: hoverHandler
        enabled: true
        blocking: false
    }

    HyprlandFocusGrab {
        id: grab
        windows: [root]
        onCleared: {
            close();
        }
    }

     Component {
        id: dummyContent

        Text {
        }

    }


}