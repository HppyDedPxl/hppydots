import "../Appearance"
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import "../Widgets"

PanelWindow {
    id: bar
    property list<Item> content
    property var barWidth : 0
    property var barPadding : 0
    property var debug : false
    property var orientation: 0
    screen: scope.modelData
    implicitHeight: barWidth + barPadding
    implicitWidth: barWidth + barPadding

    color: debug?'magenta':'transparent'
    exclusiveZone: barWidth
    mask : Region {regions: {barWidgets.children.map(x=>x.region)}}

    property var baseColor: Qt.rgba(0,0.7,.2,1)
    anchors {
        top: true
        left: true
        right: true
        bottom: false
    }

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

    Rectangle {
        id: baseRect

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.bottomMargin: barPadding

        width: parent.width
        height: barWidth
        gradient: Gradient {
            GradientStop { position: 0.0; color:  modAlpha(baseColor,0.2)}
            GradientStop { position: .48; color:    modHsvValue(modAlpha(baseColor,.2),0.1)}
            GradientStop { position: .52; color:  modHsvValue(modAlpha(baseColor,.3),0.05)}
            GradientStop { position: 1.0; color:  modHsvValue(modAlpha(baseColor,.4),-0.25)}
        }
        clip:true
       
    }
    Rectangle {
        id: contentRect
        property var screen: bar.screen
        property var barWidth : bar.barWidth
        anchors.fill: baseRect
        width: baseRect.width
        height: baseRect.height
        color: 'transparent'
        FlexboxLayout {
            id: barWidgets
            anchors.fill:parent
            alignItems: FlexboxLayout.AlignCenter
            children: bar.content
            gap:2
        }     
    }

    Rectangle{
        anchors.top: baseRect.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        implicitHeight:1
        color: modHsvValue(baseColor,.2)
    }
}