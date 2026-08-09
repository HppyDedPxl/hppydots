import "../Appearance"
import "../Services"
import Qt.labs.folderlistmodel
import QtQuick
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland


Component {
    id: _gridViewEntry

    Rectangle {
        id: r

        required property string fileName
        required property var fileIsDir
        required property var fileUrl
        required property var filePath
        property var bHovered: false

        visible: fileName != "."
        height: 108
        width: 192
        color: 'transparent'
        radius: AppearanceProvider.rounding
        clip: true
        states: [
            State {
                name: "hovered"
                when: r.bHovered

                PropertyChanges {
                    button {
                        bgColor: AppearanceProvider.highlightColor
                        textColor: AppearanceProvider.highlightTextColor
                    }

                    r {
                        height: 108 + 4
                        width: 192 + 4
                    }

                }

            },
            State {
                name: "unhovered"
                when: !r.bHovered
            }
        ]
        transitions: [
            Transition {
                from: "unhovered"
                to: "hovered"
                reversible: true

                NumberAnimation {
                    properties: "r.height, r.width, r.x,r.y"
                    duration: 250
                }

                ColorAnimation {
                    properties: "button.bgColor, button.textcolor"
                    duration: 250
                }

            }
        ]

        Rectangle {
            id: button

            property var bgColor: "transparent"
            property var textColor: AppearanceProvider.textColor

            anchors.fill: parent
            radius: AppearanceProvider.rounding
            color: bgColor

            ColumnLayout {
                anchors.fill: parent

                Rectangle {
                    color: "transparent"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Text {
                        anchors.centerIn: parent
                        text: ""
                        font.pointSize: 35
                        color: button.textColor
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "transparent"

                    Text {
                        anchors.centerIn: parent
                        visible: true
                        text: fileName
                        color: button.textColor
                        font.pointSize: 13
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                if (r.fileIsDir)
                    wallpaperFolder = r.fileUrl;
                else
                    WallpaperProvider.setWallpaper(screen, r.fileUrl);
            }
            onEntered: {
                r.bHovered = true;
            }
            onExited: {
                r.bHovered = false;
            }
            cursorShape: Qt.PointingHandCursor
        }

    }

}
