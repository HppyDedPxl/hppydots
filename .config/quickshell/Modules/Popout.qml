import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland

PopupWindow {
    id: root

    function openOnClick() {
        grab.active = true;
    }

    function close() {
        if (grab.active)
            grab.active = false;
    }

    function calculateAnchorX(){
        if(root.orientation == 0 || root.orientation == 2){
            return baseModule.x + (baseModule.width / 2) - (width / 2)
        }
    }

    function calculateAnchorY(){
        if(root.orientation == 0){
            return targetBar.height
        }
        if(root.orientation == 2){
            return  -calculateImplicitHeight() + calculateParentPadding()
        }
    }

    function calculateParentPadding(){
        if(orientation == 0 || orientation == 2)
        {
            return root.targetBar.parent.height - root.targetBar.height;
        }
        else{
            return root.targetBar.parent.width - root.targetBar.width;

        }
    }

    function getRadiusSetForOrientation(){
        if(orientation == 0)
            return [0,0,AppearanceProvider.rounding,AppearanceProvider.rounding]
        if(orientation == 2)
            return [AppearanceProvider.rounding,AppearanceProvider.rounding,0,0]
    }

    function calculateImplicitHeight(){
        return c.height + calculateParentPadding() * 2
    }

    function calculateShapeGroupPopoutTargetY(){
        if(root.orientation == 0)
            return 0
        if(root.orientation == 2)
            return root.height - targetBar.height - AppearanceProvider.rounding/2
    }
    function calculatePopupGroupPopoutTargetY(){
        if(root.orientation == 0)
            return 0
        if(root.orientation == 2)
            return -c.height+AppearanceProvider.rounding
    }

    function calculateShapeGroupBaseY(){
        if(root.orientation == 0)
            return -AppearanceProvider.rounding * 2
        if(root.orientation == 2)
            return root.height + AppearanceProvider.rounding * 2
    }

    function calculatePopupGroupBaseY(){
        if(root.orientation == 0)
            return -c.height + AppearanceProvider.rounding + (AppearanceProvider.rounding/2)
        if(root.orientation == 2)
            return 0
        
    }

    function calculateLeftShapeRotation(){
        if(root.orientation == 0)
            return 0
        if(root.orientation == 2)
            return 90
    }

    function calculateRightShapeRotation(){
        if(root.orientation == 0)
            return 270
        if(root.orientation == 2)
            return 180
    }

    property var margin: AppearanceProvider.rounding
    property var bIsHovered: hoverHandler.hovered
    property Component content
    property var bOpen: false
    property var bOpenOnHover: false
    property var hyprlandGrabber: grab
    property double overrideWidth: -1
    property double baseWidth: overrideWidth > 0 ? overrideWidth : width
    property var shadow: shadowEffect
    property var targetBar : null
    property var orientation : 0
    property var _autoFocusItem : null

    // todo, everything for side bars left right :) this will be fun
    anchor.window: orientation == 0 ? topBar : bottomBar
    
    anchor.rect.x: calculateAnchorX()
    anchor.rect.y: calculateAnchorY()
    implicitWidth: (overrideWidth > 0 ? overrideWidth : c.width) + margin * 2
    implicitHeight: calculateImplicitHeight()
    color:'transparent'

    Item {
        states: [
            State {
                name: "open"
                when: root.bOpen == true
                PropertyChanges {
                    popupGroup {
                        y: calculatePopupGroupPopoutTargetY()
                    }

                    shapeGroup {
                        y: calculateShapeGroupPopoutTargetY()
                    }
                }
            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "open"
                reversible: true

                SequentialAnimation {
                    PropertyAnimation {
                        properties: "shapeGroup.y"
                        duration: {
                            var travelShapeGroup = calculateShapeGroupPopoutTargetY() - calculateShapeGroupBaseY();
                            var travelMainGroup = calculatePopupGroupPopoutTargetY() - calculatePopupGroupBaseY();;
                            var totalTravel = travelShapeGroup + travelMainGroup;
                            return (travelShapeGroup / totalTravel) * AppearanceProvider.popoutAnimDuration;
                        }
                        easing.type: Easing.InCubic
                    }
                    PropertyAnimation {
                        properties: "popupGroup.y"
                        duration: {
                            var travelShapeGroup = calculateShapeGroupPopoutTargetY() - calculateShapeGroupBaseY();
                            var travelMainGroup = calculatePopupGroupPopoutTargetY() - calculatePopupGroupBaseY();;
                            var totalTravel = travelShapeGroup + travelMainGroup;
                            return (travelMainGroup / totalTravel) * AppearanceProvider.popoutAnimDuration;
                        }
                        easing.type: Easing.OutCubic
                    }
                    ScriptAction {
                        script: {
                            if(c.item.getAutoFocusItem != null && c.item.getAutoFocusItem() != null){
                                c.item.getAutoFocusItem().forceActiveFocus()
                            }
                        }
                    }
                }
            }
        ]
    }

    HoverHandler {
        id: hoverHandler
        enabled: true
        blocking:false
    }
    Item {
        id: shapeGroup
        y: calculateShapeGroupBaseY()  
        Item {
            id: popupGroup
            y: calculatePopupGroupBaseY()
             MultiEffect {
                id: shadowEffect
                source: rect
                anchors.fill: rect
                shadowBlur: 1
                shadowEnabled: true
                shadowColor: AppearanceProvider.shadowColor
                shadowScale: 1.03
                shadowVerticalOffset: 3
                visible: true
            }
            Rectangle {
                id: rect
                color: baseModule.usedBackgroundColor
                x: margin-1
                
                property var roundingSet: getRadiusSetForOrientation()
                width: (root.overrideWidth > 0 ? root.overrideWidth : c.width) + 2
                height: c.height
                anchors.leftMargin: AppearanceProvider.rounding
                anchors.rightMargin: AppearanceProvider.rounding
                topLeftRadius: roundingSet[0]
                topRightRadius: roundingSet[1]
                bottomRightRadius: roundingSet[2]
                bottomLeftRadius: roundingSet[3]
                antialiasing: true
                Loader {
                    id: c
                    active: root.visible
                    anchors.centerIn: parent
                    sourceComponent: content !== null ? content : dummyContent
                }
            }
        }
        StyledCurveConnector{
            id:shapeL
            size: AppearanceProvider.rounding
            rotation:calculateLeftShapeRotation()
        }
        StyledCurveConnector{
            id:shapeR
            rotation:calculateRightShapeRotation()
            size: AppearanceProvider.rounding
            anchors.left:parent.left
            anchors.leftMargin: root.width-AppearanceProvider.rounding
        }      
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
