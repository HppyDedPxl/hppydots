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
        Row{
            id:row
            anchors.fill: parent
            anchors.margins: 5
            spacing: 5

            function wsIsOnScreen(workspace) {
                if(workspace !== null && workspace !== undefined){
                    return workspace.monitor !== null && workspace.monitor.name == scope.modelData.name;
                }
                return false;
            }

            Repeater {
                model: 20
                delegate: Component {
                    id: delegate           
                    Loader {
                        property var ws: Hyprland.workspaces.values.find(w => w.id == index + 1)
                        property bool onThisScreen: wsIsOnScreen(ws);
                        property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)
                        active: onThisScreen
                        sourceComponent :  Component {
                            Rectangle{
                                id: workspaceWidget
                                width:row.height
                                height:row.height
                                radius: row.height/2
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
                                        Hyprland.dispatch("workspace " + (index+1))
                                    }
                                }
                                StyledText {
                                    id: workspaceText
                                    anchors.centerIn:parent
                                    property var ws: Hyprland.workspaces.values.find(w => w.id == index + 1)
                                    property bool onThisScreen: wsIsOnScreen(ws);
                                    property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)
                                    text: index + 1
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
        }
    }

    Component {
        id: workspacesPopup
        Text{}
    }
}
