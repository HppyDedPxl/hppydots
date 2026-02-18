import QtQuick
import QtQuick.Effects
import Quickshell
import QtQuick.Layouts
import "../Appearance"
PanelWindow {
    id: rightBar
    property list<Item> content
    screen: scope.modelData
    implicitWidth: AppearanceProvider.rightBarWidth + AppearanceProvider.rightBarPadding
    color: 'transparent'
    exclusiveZone: AppearanceProvider.rightBarWidth


    anchors {
        top: true
        bottom: true
        right: true
    }

    RectangularShadow {
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.leftMargin: AppearanceProvider.rightBarPadding
        radius: 0
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }
    Rectangle{
        id:baseRect
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.leftMargin: AppearanceProvider.rightBarPadding
       color: AppearanceProvider.backgroundColorSecondary
       clip:true
    }
     Rectangle {
        id: contentRect
        anchors.fill: baseRect
        color:'transparent'
        property var screen : rightBar.screen
        ColumnLayout {
            id: barWidgets
            anchors.fill: parent
            spacing: 1
            children: rightBar.content  
            Rectangle {
                anchors.fill:parent
            }       
        }     
    }
}