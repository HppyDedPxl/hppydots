import QtQuick
import QtQuick.Effects
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
                    position: 0.32
                    color: AppearanceProvider.backgroundColor
                }
                GradientStop {
                    position: 0.320001
                    color: AppearanceProvider.accentColor
                }
                GradientStop {
                    position: 0.34
                    color: AppearanceProvider.accentColor
                }
                GradientStop {
                    position: 0.340001
                    color: AppearanceProvider.accentColorLighter
                }
                GradientStop {
                    position: 0.36
                    color: AppearanceProvider.accentColorLighter
                }
                GradientStop {
                    position: 0.360001
                    color: AppearanceProvider.backgroundColorSecondary
                }
        }
       }
        
    }
}