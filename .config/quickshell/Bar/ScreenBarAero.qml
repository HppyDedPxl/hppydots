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

    property var baseColor:  AppearanceProvider.backgroundColor// Qt.rgba(0,0.7,.2,1)

    readonly property var anchorPresets : [
        [true,true,false,true],
        [true,true,true,false],
        [false,true,true,true],
        [true,false,true,true],
    ];

     anchors {
        top: anchorPresets[bar.orientation][0]
        right:anchorPresets[bar.orientation][1]
        bottom: anchorPresets[bar.orientation][2]
        left: anchorPresets[bar.orientation][3]
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
        property var alphaScale: .7
        width: parent.width
        height: barWidth
        gradient: Gradient {
            GradientStop { position: 0.0; color:  modHsvValue(modAlpha(baseColor,0.05 * baseRect.alphaScale),0.15)}
            GradientStop { position: .48; color:    modHsvValue(modAlpha(baseColor,.05* baseRect.alphaScale),0.13)}
            GradientStop { position: .52; color:  modHsvValue(modAlpha(baseColor,.3* baseRect.alphaScale),0.05 )}
            GradientStop { position: 1.0; color:  modHsvValue(modAlpha(baseColor,.4* baseRect.alphaScale),-0.25 )}
        }
        clip:true
       
    }
    Rectangle {
        id: contentRect
        property var screen: bar.screen
        property var barWidth : bar.barWidth
        property var orientation : bar.orientation
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