import "./"
import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle{
    property var preferredWidth: -1
    property var preferredHeight: -1
    Layout.preferredWidth: preferredWidth
    Layout.maximumWidth: preferredWidth
    Layout.minimumWidth: preferredWidth
    Layout.preferredHeight: preferredHeight
    Layout.maximumHeight: preferredHeight
    Layout.minimumHeight: preferredHeight
    Layout.fillWidth:true
    Layout.fillHeight:true
    color : 'transparent'
}