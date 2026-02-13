import "../Appearance"
import "../Services"
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
    property var shadow: shadowEffect
    property var targetBar: null
    property var orientation: 0
    property var _autoFocusItem: null

    function openOnClick() {
        grab.active = true;
    }

    function close() {
        if (grab.active)
            grab.active = false;

    }


    function calculateAnchorX() {
        if (root.orientation == 0 || root.orientation == 2)
            return baseModule.x + (baseModule.width / 2) - (width / 2);
        else if (root.orientation  == 3)
            return 0
    }

    function calculateAnchorY() {
        if (root.orientation == 0)
            return targetBar.height;

        if (root.orientation == 2)
            return -calculateImplicitHeight() + calculateParentPadding();

        if (root.orientation == 1 || root.orientation == 3)
            return -(baseModule.y + (height/2) - (baseModule.height*1.5))
    }

    function getContentSizeSetForOrientation(){
        if(root.orientation == 0 || root.orientation == 2){
            return [margin - 1,0,(root.overrideWidth > 0 ? root.overrideWidth : c.width) + 2,c.height]
        }
        else{
            return [0,margin-1,c.width,(root.overrideWidth > 0 ? root.overrideWidth : c.height)+2]
        }
    }

    function calculateParentPadding() {
        if (orientation == 0 || orientation == 2)
            return root.targetBar.parent.height - root.targetBar.height;
        else
            return root.targetBar.parent.width - root.targetBar.width;
    }

    function getRadiusSetForOrientation() {
        if (orientation == 0)
            return [0, 0, AppearanceProvider.rounding, AppearanceProvider.rounding];

        if (orientation == 2)
            return [AppearanceProvider.rounding, AppearanceProvider.rounding, 0, 0];
        if (orientation == 3)
            return [0, AppearanceProvider.rounding, AppearanceProvider.rounding, 0];

    }

    function calculateImplicitWidth(){
        if(orientation == 0 || orientation == 2)
            return  (overrideWidth > 0 ? overrideWidth : c.width) + margin * 2;
        else{
            return c.width + calculateParentPadding() * 2;
        }
    }

    function calculateImplicitHeight() {
        if(orientation == 0 || orientation == 2)
            return c.height + calculateParentPadding() * 2;
        else{
            return (overrideWidth > 0 ? overrideWidth : c.height) + margin * 2;
        }
    }

    function calculateShapeGroupPopoutTargetX() {
        if(root.orientation == 0 || root.orientation == 2)
            return 0
        if(root.orientation == 1)
            return root.width - AppearanceProvider.rounding

        return 0
        
    }

    function calculateShapeGroupPopoutTargetY() {
        if (root.orientation == 0)
            return 0;

        if (root.orientation == 2)
            return root.height - AppearanceProvider.rounding ;

        return 0

    }

    function calculatePopupGroupPopoutTargetX() {
        if( root.orientation == 1)
            return -c.width + AppearanceProvider.rounding

        return 0
    }

    function calculatePopupGroupPopoutTargetY() {
        if (root.orientation == 0)
            return 0;

        if (root.orientation == 2)
            return -c.height + AppearanceProvider.rounding;
        
        return 0;
    }

    function calculateShapeGroupBaseX(){
        if(root.orientation == 0 || root.orientation == 2){
            return 0
        }
        if(root.orientation == 3)
            return -AppearanceProvider.rounding * 2;

        return 0;

    }

    function calculateShapeGroupBaseY() {
        if (root.orientation == 0)
            return -AppearanceProvider.rounding * 2;

        if (root.orientation == 2)
            return root.height + AppearanceProvider.rounding * 2;

        return 0

    }

    function calculatePopupGroupBaseX () {
        if(root.orientation == 0 || root.orientation == 2){
            return 0
        }
        if(root.orientation == 3) {
            return -c.width + AppearanceProvider.rounding + (AppearanceProvider.rounding / 2)
        }
    }

    function calculatePopupGroupBaseY() {
        if (root.orientation == 0)
            return -c.height + AppearanceProvider.rounding + (AppearanceProvider.rounding / 2);

        if (root.orientation == 2)
            return 0;

        if (root.orientation == 3)
            return 0

    }

    function calculateLeftShapeRotation() {
        if (root.orientation == 0)
            return 0;
        if (root.orientation == 1)
            return 270
        if (root.orientation == 2)
            return 90;
        if(root.orientation == 3)
            return 180
    }

    function calculateRightShapeRotation() {
        if (root.orientation == 0)
            return 270;
        if (root.orientation == 1)
            return 0;
        if (root.orientation == 2)
            return 180;
        if (root.orientation == 3)
            return 270;
    }

    function calculateXOriginForOrientation(){
        if (orientation % 2 == 0)
            return root.width/2
        else
            return 0;
    }
    function calculateYOriginForOrientation(){
        if (orientation % 2 == 0){
            return 0;
        }
        else return root.height/2
    }

    function calculateTravelShapeGroup(){
        if(orientation == 0 || orientation == 2)
        {
            if(calculateShapeGroupPopoutTargetY() > calculateShapeGroupBaseY())
                return calculateShapeGroupPopoutTargetY() - calculateShapeGroupBaseY()
            return calculateShapeGroupBaseY() - calculateShapeGroupPopoutTargetY()  
        } 
        else
        {
            if(calculateShapeGroupPopoutTargetX() > calculateShapeGroupBaseX())
                return calculateShapeGroupPopoutTargetX() - calculateShapeGroupBaseX()
            return calculateShapeGroupBaseX() - calculateShapeGroupPopoutTargetX()  
        }
    }

    function calculateTravelPopupGroup(){
        if(orientation == 0 || orientation == 2) {
            if(calculatePopupGroupPopoutTargetY() > calculatePopupGroupBaseY())
                return calculatePopupGroupPopoutTargetY() - calculatePopupGroupBaseY()
            return calculatePopupGroupBaseY() - calculatePopupGroupPopoutTargetY()    
        }
        else{
            if(calculatePopupGroupPopoutTargetX() > calculatePopupGroupBaseX())
                return calculatePopupGroupPopoutTargetX() - calculatePopupGroupBaseX()
            return calculatePopupGroupBaseX() - calculatePopupGroupPopoutTargetX()    
        }
    }

    // todo, everything for side bars left right :) this will be fun
    anchor.window: orientation == 0 ? topBar : bottomBar
    anchor.rect.x: calculateAnchorX()
    anchor.rect.y: calculateAnchorY()
    implicitWidth: calculateImplicitWidth()
    implicitHeight: calculateImplicitHeight()
    color: 'transparent'

    Item {
        states: [
            State {
                name: "open"
                when: root.bOpen == true

                PropertyChanges {
                    popupGroup {
                        x: calculatePopupGroupPopoutTargetX()
                        y: calculatePopupGroupPopoutTargetY()
                    }

                    shapeGroup {
                        x: calculateShapeGroupPopoutTargetX()
                        y: calculateShapeGroupPopoutTargetY()
                    }

                    scale {
                        xScale: 1
                        yScale: 1
                    }

                }

            }
        ]
        transitions: [
            Transition {
                from: "*"
                to: "open"
                reversible: true

                ParallelAnimation {
                    SequentialAnimation {
                        ScriptAction {
                            script: {
                                if (c.item != null){
                                    if(c.item.getAutoFocusItem != null && c.item.getAutoFocusItem() != null){
                                        c.item.getAutoFocusItem().forceActiveFocus();
                                    }
                                    if(c.item.onOpen != null)
                                    {
                                        c.item.onOpen()
                                    }
                                }
                                
                                    

                            }
                        }

                        PropertyAnimation {
                            properties: "shapeGroup.x,shapeGroup.y"
                            duration: {
                                var travelShapeGroup = calculateTravelShapeGroup()
                                var travelMainGroup = calculateTravelPopupGroup()
                                var totalTravel = travelShapeGroup + travelMainGroup;
                                return (travelShapeGroup / totalTravel) * AppearanceProvider.popoutAnimDuration;
                            }
                            easing.type: Easing.InCubic
                        }

                        PropertyAnimation {
                            properties: "popupGroup.x,popupGroup.y"
                            duration: {
                                var travelShapeGroup = calculateTravelShapeGroup();
                                var travelMainGroup = calculateTravelPopupGroup();
                                var totalTravel = travelShapeGroup + travelMainGroup;
                                return (travelMainGroup / totalTravel) * AppearanceProvider.popoutAnimDuration;
                            }
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                PropertyAnimation {
                    properties: "scale.xScale,scale.yScale"
                    duration: 400
                    easing.type: Easing.InOutCubic
                }
            }
        ]
    }

    HoverHandler {
        id: hoverHandler
        enabled: true
        blocking: false
    }

    Item {
        id: shapeGroup
        x: calculateShapeGroupBaseX()
        y: calculateShapeGroupBaseY()

        Item {
            id: popupGroup
            x: calculatePopupGroupBaseX()
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

                property var sizeSet: getContentSizeSetForOrientation()
                property var roundingSet: getRadiusSetForOrientation()

                color: baseModule.usedBackgroundColor

                x: sizeSet[0]
                y: sizeSet[1]
                width: sizeSet[2]
                height: sizeSet[3]

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
        Item{
            id: adornmentShapesHorizontal
            visible: root.orientation % 2 == 0
            StyledCurveConnector {
                id: shapeL

                size: AppearanceProvider.rounding
                rotation: calculateLeftShapeRotation()
            }

            StyledCurveConnector {
                id: shapeR

                rotation: calculateRightShapeRotation()
                size: AppearanceProvider.rounding
                anchors.left: parent.left
                anchors.leftMargin: root.width - AppearanceProvider.rounding
            }
        }
        Item{
            id: adornmentShapesVertical
            visible: root.orientation % 2 != 0
            StyledCurveConnector {
                id: shapeT
                size: AppearanceProvider.rounding
                rotation: calculateLeftShapeRotation()
            }

            StyledCurveConnector {
                id: shapeB

                rotation: calculateRightShapeRotation()
                size: AppearanceProvider.rounding
                anchors.top: parent.top
                anchors.topMargin: root.height - AppearanceProvider.rounding
            }
        }

        transform: Scale {
            id: scale
            origin.x: calculateXOriginForOrientation()//root.width / 2
            origin.y: calculateYOriginForOrientation()
            xScale: 0
            yScale: 0
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
