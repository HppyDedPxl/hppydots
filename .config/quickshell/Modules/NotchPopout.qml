import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

Item {
    
    property alias loadedContent : c.item
    readonly property alias loader : c
    property var attachmentRect : attachment
    property var root : null
    
    function getContentSizeSetForOrientation(){
        console.log("root is: " + root)
        if(root.orientation == 0 || root.orientation == 2){
            console.log("returning this here")
            return [margin - 1,0,(root.overrideWidth > 0 ? root.overrideWidth : c.width) + 2,c.height]
        }
        else{
            return [0,margin-1,c.width,(root.overrideWidth > 0 ? root.overrideWidth : c.height)+2]
        }
    }

    function calculateParentPadding() {

        if (root.orientation == 0 || root.orientation == 2)
            return root.targetBar.parent.height - root.targetBar.height;
        else
            return root.targetBar.parent.width - root.targetBar.width;
    }

    function getRadiusSetForOrientation() {

        if (root.orientation == 0 || undefined)
            return [0, 0, AppearanceProvider.rounding, AppearanceProvider.rounding];
        if (root.orientation == 1)
            return [AppearanceProvider.rounding,0,0,AppearanceProvider.rounding]
        if (root.orientation == 2)
            return [AppearanceProvider.rounding, AppearanceProvider.rounding, 0, 0];
        if (root.orientation == 3)
            return [0, AppearanceProvider.rounding, AppearanceProvider.rounding, 0];

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
        console.log(root.orientation)
        if(root.orientation == 0 || root.orientation == 2){
            return 0
        }

        if(root.orientation == 1)
            return root.width + AppearanceProvider.rounding * 4;
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
        if(root.orientation == 3) {
            return -c.width + AppearanceProvider.rounding + (AppearanceProvider.rounding / 2)
        }
        return 0
    }

    function calculatePopupGroupBaseY() {
        if (root.orientation == 0)
            return -c.height + AppearanceProvider.rounding + (AppearanceProvider.rounding / 2);
        return 0
    }

    function calculateLeftShapeRotation() {
        if (root.orientation == 0)
            return 0;
        if (root.orientation == 1)
            return 90; 
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
        if(root.bFixedAttachment != null){
            return root.bFixedAttachment[0]  - (targetBar.width/2 ) + root.width /2
        }
        if (orientation % 2 == 0)
        {
            if(baseModule.x+(root.width/2) > targetBar.width)
            {
                return baseModule.x - (targetBar.width - root.width)
            }
            if(baseModule.x - (root.width/2) < 0)
            {
                return baseModule.x
            }
            return root.width/2
        }      
        else
            return 0;
    }
    function calculateYOriginForOrientation(){
        if(root.bFixedAttachment != null){
            return 0
        }
        if (orientation % 2 == 0){
            return 0;
        }
        else
        {
            if(baseModule.y + (root.height/2) > targetBar.height)
            {
                return baseModule.y - (targetBar.height - root.height)
            }
            if(baseModule.y - (root.height/2) < 0)
            {
                return baseModule.y
            }
            return calculateImplicitHeight()/2
        } 
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

    function calculateAttachmentSize(){

        if(orientation % 2 == 0)
            return {x:c.width-AppearanceProvider.rounding*2, y:root.attachmentSize}
        else
            return {x:root.attachmentSize,y:c.height-AppearanceProvider.rounding*2}
        
    }

    function calculateAttachmentOffset(){
        if(orientation % 2 == 0)
            return {x:AppearanceProvider.rounding*2, y:0}
        else
            return {x:0,y:AppearanceProvider.rounding*2}
        
    }

    function setPopupAttachmentAnchors(attachmentRect){
        if(orientation == 0)
            attachmentRect.anchors.top = rect.bottom
        if(orientation == 3)
            attachmentRect.anchors.left = rect.right
    }



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
            },
            State {
                name: "closed"
                when: root.bOpen == false
            }
        ]
        transitions: [
            Transition {
                from: "closed"
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
                                if(state == "open"){
                                    root.onPopupStartOpen()
                                    PopupObserver.registerOpenPopup(root)
                                }
                                if(state == "closed" && isClosing)
                                {   

                                    root.onPopupClosed()
                                    root.updateMask();
                                    PopupObserver.deregisterOpenPopup(root)
                                    isClosing=false
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

                        ScriptAction {
                            script: {
                                if(state == "closed")
                                {
                                    isClosing = true
                                    root.onPopupStartClosing()
                                }
                                if(state == "open")
                                {
                                    root.onPopupOpened()
                                    baseModule.updateMask()
                                }
                            }
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


    Item {
        id: shapeGroup
        x: calculateShapeGroupBaseX()
        y: calculateShapeGroupBaseY()

        Item {
            id: popupGroup
            x: calculatePopupGroupBaseX()
            y: calculatePopupGroupBaseY()


            Rectangle {
                id: rect

                property var sizeSet: getContentSizeSetForOrientation()
                property var roundingSet: getRadiusSetForOrientation()

                color: AppearanceProvider.nativeBackgroundColor

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
                    active: true
                    anchors.centerIn: parent
                    sourceComponent: content !== null ? content : root.dummyContent
                    onLoaded:{
                        baseModule.updateMask()
                        root.ready()
                    }
                }
            }

            Rectangle {
                id: rectAttachment
                visible: supportsAttachment
                x: calculateAttachmentOffset().x
                y: calculateAttachmentOffset().y
                width: calculateAttachmentSize().x
                height:calculateAttachmentSize().y
                color:'transparent'
                opacity:1
                Component.onCompleted:()=>{
                    setPopupAttachmentAnchors(attachment);
                }
                Loader {
                    id: attachmentLoader
                    active: bPopupSupportsAttachment && root.attachment != null
                    anchors.fill:parent
                    sourceComponent: root.attachment
                }
            }

        }
        // * Horizontal Adornments
        Item{
            id: adornmentShapesHorizontal
            visible: root.orientation % 2 == 0
            StyledCurveConnector {
                id: shapeL
                size: AppearanceProvider.rounding
                rotation: calculateLeftShapeRotation()
                explicitColor: AppearanceProvider.nativeBackgroundColor
            }

            StyledCurveConnector {
                id: shapeR

                rotation: calculateRightShapeRotation()
                size: AppearanceProvider.rounding
                anchors.left: parent.left
                anchors.leftMargin: root.width - AppearanceProvider.rounding
                explicitColor: AppearanceProvider.nativeBackgroundColor

            }
        }
        // * Vertical Adornments
        Item{
            id: adornmentShapesVertical
            visible: root.orientation % 2 != 0
            StyledCurveConnector {
                id: shapeT
                size: AppearanceProvider.rounding
                rotation: calculateLeftShapeRotation()
                explicitColor: AppearanceProvider.nativeBackgroundColor

            }

            StyledCurveConnector {
                id: shapeB

                rotation: calculateRightShapeRotation()
                size: AppearanceProvider.rounding
                anchors.top: parent.top
                anchors.topMargin: root.height - AppearanceProvider.rounding
                explicitColor: AppearanceProvider.nativeBackgroundColor

            }
        }

        transform: Scale {
            id: scale
            origin.x: calculateXOriginForOrientation()//root.width / 2
            origin.y: calculateYOriginForOrientation()
            xScale: 1
            yScale: 1
        }

    }

}
