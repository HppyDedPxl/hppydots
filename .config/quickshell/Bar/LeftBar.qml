import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import "../Appearance"
PanelWindow {
    id: leftBar
    property list<Item> content
    screen: scope.modelData
    implicitWidth: AppearanceProvider.leftBarWidth + AppearanceProvider.leftBarPadding
    color: 'transparent'
    exclusiveZone: AppearanceProvider.leftBarWidth


    anchors {
        top: true
        bottom: true
        left: true
    }

    RectangularShadow {
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.rightMargin: AppearanceProvider.leftBarPadding
        radius: 0
        offset.x: AppearanceProvider.shadowOffsetX
        offset.y: AppearanceProvider.shadowOffsetY
        blur: AppearanceProvider.shadowBlur
        spread: AppearanceProvider.shadowSpread
        color: AppearanceProvider.shadowColor
    }
    Rectangle{
        id: baseRect
        anchors.top:parent.top
        anchors.left:parent.left
        anchors.right:parent.right
        anchors.bottom:parent.bottom
        anchors.rightMargin: AppearanceProvider.leftBarPadding
       //color: AppearanceProvider.backgroundColor
        clip:true
       Rectangle{
            rotation:-45
            height:parent.height
            width:parent.height
            anchors.centerIn:parent
            
            gradient: Gradient{
            orientation: Gradient.Vertical
            GradientStop {
                    position: 0
                    color: AppearanceProvider.backgroundColor
                }
                GradientStop {
                    position: 0.20
                    color: AppearanceProvider.backgroundColor
                }
                GradientStop {
                    position: 0.200001
                    color: AppearanceProvider.accentColor
                }
                GradientStop {
                    position: 0.22
                    color: AppearanceProvider.accentColor
                }
                GradientStop {
                    position: 0.220001
                    color: AppearanceProvider.accentColorLighter
                }
                GradientStop {
                    position: 0.24
                    color: AppearanceProvider.accentColorLighter
                }
                GradientStop {
                    position: 0.240001
                    color: AppearanceProvider.backgroundColorSecondary
                }
        }
       }
    }
    Rectangle {
        id: contentRect
        anchors.fill: baseRect
        color:'transparent'
        ColumnLayout {
            id: barWidgets
            anchors.fill: parent
            spacing: 1
            children: leftBar.content  
            Rectangle {
                anchors.fill:parent
                color: 'red'
            }       
        }     
    }
}