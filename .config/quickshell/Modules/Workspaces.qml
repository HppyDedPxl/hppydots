import QtQuick
import Quickshell
import Quickshell.Io // for Process
import Quickshell.Hyprland
import QtQuick.Layouts
import "../Services"
import "../Appearance"



BaseModule{
    function getAmountVisible(){
        let c = mainContentLoader.item.innerRepeater.model.values.length
        let vis = 0
        for(let i = 0; i < c; i++){
            if ( mainContentLoader.item.innerRepeater.itemAt(i).visible)
                vis++
        }
        return vis;
    }
    id: baseModule
    content: workspaceBar
    color:'transparent'
    property var blipSpacing : 15
    property var verticalMargins: 2
    width: getAmountVisible() * (parent.height - (verticalMargins*2)) + (getAmountVisible()-1) * blipSpacing
    Behavior on width {
                NumberAnimation {
                    duration:200
                }
            }
    Component {
        id: workspaceBar

        Rectangle {
            id: root
            color:'transparent'
            border.width:1
            radius:AppearanceProvider.rounding
            border.color:AppearanceProvider.activeColor
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: verticalMargins
            anchors.bottomMargin:verticalMargins
            property var margins : 2
            anchors.margins:margins
            property var innerRepeater : repeater

            Row {
                id:row
                spacing: blipSpacing
                anchors.centerIn:parent
                height:root.height
                Repeater {
                    id: repeater
                    model: Hyprland.workspaces
                    Rectangle{
                        id:workspaceWidgetRoot
                        color:'transparent'
                        anchors.top: parent.top
                        anchors.topMargin: parent.height/2 - height/2
                        width:parent.height/2
                        height:parent.height/2
                         function wsIsOnScreen(workspace) {
                            if(workspace !== null && workspace !== undefined){
                                return workspace.monitor !== null && workspace.monitor.name == scope.modelData.name;
                            }
                            return false;
                        }
                        required property var modelData
                        required property var index
                        property bool onThisScreen: wsIsOnScreen(modelData);
                        property bool isActive: Hyprland.focusedWorkspace?.id == modelData.id
                        visible: onThisScreen 

                        Rectangle{
                       
                        
                        id: workspaceWidget    
                        anchors.centerIn:parent                    
                        width: parent.height
                        height: parent.height
                        radius: parent.height
                        color: AppearanceProvider.inactiveColor
                        property bool isHovered
                        MouseArea {
                            anchors.fill:workspaceWidget
                            enabled: true
                            hoverEnabled: true
                            onEntered: {
                                workspaceWidget.isHovered=true
                            }
                            onExited:{
                                workspaceWidget.isHovered=false
                            }
                            onClicked: {
                                Hyprland.dispatch("workspace " + (modelData.id))
                            }
                        }
                        StyledText {
                            id: workspaceText
                            anchors.centerIn:parent
                            text: modelData.id
                            color: AppearanceProvider.inactiveTextColor
                        }

                        states: [
                            State {
                                name: "active"
                                when: isActive
                                PropertyChanges {
                                    workspaceWidget{
                                        width:row.height*0.9
                                        height:row.height*0.9
                                        color: AppearanceProvider.highlightColor
                                    }
                                    workspaceText{
                                        color: AppearanceProvider.highlightTextColor
                                    }
                                }
                            },
                            State {
                                name: "hovered"
                                when: workspaceWidget.isHovered
                                PropertyChanges {
                                    workspaceWidget{
                                        color: AppearanceProvider.highlightColor
                                    }
                                    workspaceText{
                                        color: AppearanceProvider.highlightTextColor
                                    }
                                }
                            }
                        ]
                        transitions: [
                            Transition {
                                from: ""
                                to: "active"
                                reversible: true
                                PropertyAnimation {
                                    properties: "width,height,color,opacity"
                                    duration: 250
                                    easing.type: Easing.InOutQuad
                                }
                            },
                            Transition {
                                from: "hovered"
                                to: "active"
                                reversible: true
                                PropertyAnimation {
                                    properties: "width,color"
                                    duration: 250
                                    easing.type: Easing.InOutQuad
                                }
                            },
                            Transition {
                                from: ""
                                to: "hovered"
                                reversible: true
                                PropertyAnimation {
                                    properties: "color"
                                    duration: 100
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        ]
                    }
                    }
                    
                }
            }
        } 
    }

    Component {
        id: workspacesPopup
        Text{}
    }
}
