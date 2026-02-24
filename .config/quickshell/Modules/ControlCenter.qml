import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

BaseModule {
    id: baseModule

    dbgName: "ccModule"
    width: parent.height
    content: _content
    popupContent: _popupContent

    Component {
        id: _content

        StyledSidebarDock {

            content: StyledBarIcon {
                anchors.fill: parent
                text: ""
            }

        }

    }

    Component {
        id: _popupContent

        Item {
            width: 300
            height: 400

            Item {
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 10

                RowLayout {
                    id: powerButtonBar

                    width: parent.width
                    spacing: 0
                    height: width / 5

                    StyledButton {
                        Layout.preferredWidth: parent.width / 5
                        Layout.preferredHeight: width
                        text: "󰍃"
                        fontSize: 30
                        onClick:()=>{
                            sendProcess.command=["sh","-c","logout"]
                            sendProcess.running=true
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    StyledButton {
                        Layout.preferredWidth: parent.width / 5
                        Layout.preferredHeight: width
                        text: ""
                        fontSize: 30
                        onClick:()=>{
                            sendProcess.command=["sh","-c","hyprlock"]
                            sendProcess.running=true
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    StyledButton {
                        Layout.preferredWidth: parent.width / 5
                        Layout.preferredHeight: width
                        text: "󰑓"
                        fontSize: 30
                        onClick:()=>{
                            sendProcess.command=["sh","-c","systemctl reboot"]
                            sendProcess.running=true
                        }
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    StyledButton {
                        Layout.preferredWidth: parent.width / 5
                        Layout.preferredHeight: width
                        text: ""
                        fontSize: 30
                        onClick:()=>{
                            sendProcess.command=["sh","-c","systemctl poweroff"]
                            sendProcess.running=true
                        }
                    }

                }

                Rectangle {
                    anchors.top: powerButtonBar.bottom
                    anchors.topMargin: 10
                    width: parent.width
                    height: 40
                    border.color: AppearanceProvider.accentColor
                    border.width: 3
                    color: 'transparent'
                    radius: AppearanceProvider.rounding / 2
                    visible: SystemInfo.bSupportsBacklightControl

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 6

                        StyledBarIcon {
                            Layout.preferredWidth: parent.height
                            Layout.preferredHeight: parent.height
                            text: ""
                        }

                        StyledButton {
                            Layout.preferredWidth: parent.height / 1.5
                            Layout.preferredHeight: parent.height / 1.5
                            radius: width
                            border.width: 1
                            text: "-"
                            onClick: () => {
                                SystemInfo.setBacklightBrightness(Math.max(0, Math.min(100, SystemInfo.currentBacklightBrightness - 10)));
                            }
                        }

                        StyledStepDisplay {
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height
                            value: SystemInfo.currentBacklightBrightness
                        }

                        StyledButton {
                            Layout.preferredWidth: parent.height / 1.5
                            Layout.preferredHeight: parent.height / 1.5
                            radius: width
                            text: "+"
                            border.width: 1
                            onClick: () => {
                                SystemInfo.setBacklightBrightness(Math.max(0, Math.min(100, SystemInfo.currentBacklightBrightness + 10)));
                            }
                        }
                    }
                }
            }

            Process {
                id: sendProcess
                running:false
            }
        }
    }
}
