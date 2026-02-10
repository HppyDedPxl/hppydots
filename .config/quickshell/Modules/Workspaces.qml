import QtQuick
import Quickshell
import Quickshell.Io // for Process
import Quickshell.Hyprland
import QtQuick.Layouts
import "../Services"
import "../Appearance"



BaseModule{
    id: baseModule
    content: workspaceBar
    
    Component {
        id: workspaceBar

        Rectangle {
            id: root
            color:'transparent'
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            property var margins : 4
            anchors.margins:margins

            Row {
                id:row
                spacing: 5
                height:root.height
                Repeater {
                    id: repeater
                    model: Hyprland.workspaces          
                    Rectangle{
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
                        id: workspaceWidget                        
                        width: root.height
                        height: root.height
                        radius: root.height/2
                        color: AppearanceProvider.inactiveColor
                        property bool isHovered
                        MouseArea {
                            anchors.fill:workspaceWidget
                            enabled: true
                            hoverEnabled: true
                            onEntered: {
                                isHovered=true
                            }
                            onExited:{
                                isHovered=false
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
                                        width:row.height*2
                                        color: AppearanceProvider.activeColor
                                    }
                                    workspaceText{
                                        color: AppearanceProvider.activeTextColor
                                    }
                                }
                            },
                            State {
                                name: "hovered"
                                when: isHovered
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
                                    properties: "width,color"
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

    Component {
        id: workspacesPopup
        Text{}
    }
}
