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
    property var baseColor:  AppearanceProvider.backgroundColor// Qt.rgba(0,0.7,.2,1)
 
     function modAlpha(color, alphaChange){
        let c = Object.assign({},color)
        c.a -= alphaChange
        return c;
    }
    function modHsvValue(color, valueChange){
        let c = Object.assign({},color)
        c.hslLightness -= valueChange
        return c;
    }

    function getContentSizeSetForOrientation(){
        if(root.orientation == 0 || root.orientation == 2){
            return [root.margin - 1,root.margin/2,(root.overrideWidth > 0 ? root.overrideWidth : c.width) + 2,c.height]
        }
        else{
            return [root.margin/2,root.margin-1,c.width,(root.overrideWidth > 0 ? root.overrideWidth : c.height)+2]
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
                    mainGroup {
                        opacity: 1
                    }
                }
            },
            State {
                name: "closed"
                when: root.bOpen == false
                PropertyChanges {
                    mainGroup {
                        opacity: 0
                    }
                }
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
                            properties: "mainGroup.opacity"
                            duration: 250
                            easing.type: Easing.InOutCubic
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
                                    root.updateMask()
                                }
                            }
                        }
                    }
                }
            }
        ]
    }


    Item {
        id: mainGroup
        anchors.fill:parent
        opacity:0
        Rectangle {
            id: rect

            property var sizeSet: getContentSizeSetForOrientation()

          //  color: baseColor
            gradient: Gradient {
                    GradientStop { position: 0.0; color:  modHsvValue(modAlpha(baseColor,0.05 ),0.25)}
                    GradientStop { position: 1; color:    modHsvValue(modAlpha(baseColor,.2),0.15)}
                }
            x: sizeSet[0]
            y: sizeSet[1]
            width: sizeSet[2]
            height: sizeSet[3]
            border.width: 2
            border.color: AppearanceProvider.backgroundColorSecondary

            radius: AppearanceProvider.rounding /2 

            antialiasing: true

            Loader {
                id: c
                active: true
                anchors.centerIn: parent
                sourceComponent: content !== null ? content : root.dummyContent
                onLoaded:{
                    root.updateMask()
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
            color:'green'
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

}
