import "../Appearance"
import "../Services"
import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    required property var uid
    required property var summary
    required property var start
    required property var end

    color: "transparent"
    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    Layout.fillWidth: true
    Layout.preferredHeight: 50

    RowLayout {
        Layout.fillWidth: true
        Layout.fillHeight: true

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: false
            Layout.preferredWidth: 10
            color: "transparent"

            Rectangle {
                anchors.centerIn: parent
                width: 4
                height: parent.height - 5
                color: AppearanceProvider.highlightColor
                radius: 4
            }

        }

        ColumnLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.topMargin: 2
            Layout.bottomMargin: 6

            Text {
                color: AppearanceProvider.textColor
                font.bold: true
                text: summary
            }

            Text {
                text: {
                    return timeToString(new Date(start * 1000)) + " - " + timeToString(new Date(end * 1000));
                }
                color: AppearanceProvider.textColor
            }

        }

    }

}
