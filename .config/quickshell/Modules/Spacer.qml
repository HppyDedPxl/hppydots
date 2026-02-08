import "./"
import Quickshell
import QtQuick
import QtQuick.Layouts

Rectangle{
    property var preferredWidth: -1
    Layout.preferredWidth: preferredWidth
    Layout.maximumWidth: preferredWidth
    Layout.minimumWidth: preferredWidth
    Layout.fillWidth:true
    color : 'transparent'
}